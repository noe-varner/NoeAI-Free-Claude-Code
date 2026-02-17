---
description: "Build MCP (Model Context Protocol) servers that enable LLMs to interact with external services. Use when creating new MCP integrations, building tool servers, or wrapping APIs for Claude. Supports both Python (FastMCP) and TypeScript implementations."
---

# MCP Server Development Guide

Build high-quality MCP servers that enable LLMs to interact with external services and APIs.

---

## Development Process

Follow this 4-phase approach:

### Phase 1: Deep Research & Planning

Before writing code:

1. **Study the API exhaustively**
   - Read all API documentation
   - Identify authentication methods
   - Map out rate limits and constraints
   - Test endpoints manually first

2. **Design workflow-focused tools**
   - Build thoughtful, high-impact workflow tools
   - NOT just API endpoint wrappers
   - Think: "What tasks will the LLM need to accomplish?"

3. **Plan for LLM context limits**
   - Return high-signal information, not data dumps
   - Design pagination from the start
   - Set character limits (25,000 default)

4. **Create evaluation scenarios early**
   - Write 10 realistic test questions
   - Iterate based on agent performance

### Phase 2: Implementation

Choose your stack:

- **Python**: Use FastMCP (`pip install fastmcp`)
- **TypeScript**: Use MCP SDK (`npm install @modelcontextprotocol/sdk`)

Implementation order:
1. Set up project structure
2. Implement core infrastructure (API helpers, error handling)
3. Build tools systematically with proper schemas
4. Apply validation (Pydantic for Python, Zod for TypeScript)

### Phase 3: Review & Refine

Code quality checklist:
- [ ] DRY - No duplicate code
- [ ] Composable - Reusable utilities
- [ ] Consistent - Same patterns throughout
- [ ] Error handling - Graceful failures with guidance
- [ ] Type safety - Full type coverage
- [ ] Documentation - Clear descriptions and examples

### Phase 4: Evaluation

Create evaluations to verify your server works:
- 10 complex, realistic, read-only questions
- Require multiple tool calls to answer
- Verify LLMs can effectively use your server

---

## Quick Reference

### Naming Conventions

| Language | Server Name | Tool Names |
|----------|-------------|------------|
| Python | `{service}_mcp` | `slack_send_message` |
| TypeScript | `{service}-mcp-server` | `slack_send_message` |

### Tool Annotations (Required)

```
readOnlyHint: true/false     # Does NOT modify state
destructiveHint: true/false  # Deletes or overwrites data
idempotentHint: true/false   # Safe to retry
openWorldHint: true/false    # Interacts with external world
```

### Response Formats

Support both:
- **JSON**: Machine-readable for programmatic use
- **Markdown**: Human-readable with proper formatting

### Character Limits

```python
CHARACTER_LIMIT = 25000

if len(response) > CHARACTER_LIMIT:
    return f"{response[:CHARACTER_LIMIT]}\n\n[Truncated - use filters to narrow results]"
```

### Pagination Pattern

Always return:
```json
{
  "items": [...],
  "has_more": true,
  "next_offset": 50,
  "total_count": 1234
}
```

---

## Best Practices

**DO:**
- Design tools around workflows, not API endpoints
- Return actionable error messages that guide correct usage
- Include pagination metadata on all list operations
- Validate all inputs against schemas
- Support both markdown and JSON output formats

**DON'T:**
- Return exhaustive data dumps
- Expose internal error details
- Skip input validation
- Ignore rate limits
- Create overly complex multi-step tools

---

## Transport Options

| Transport | Use Case |
|-----------|----------|
| **stdio** | Local integrations, desktop apps |
| **HTTP** | Remote services, multi-client |
| **SSE** | Real-time updates, streaming |

---

## Security Checklist

- [ ] Input validation against JSON schemas
- [ ] Sanitize all user inputs
- [ ] OAuth 2.1 or secure API key management
- [ ] Prevent command injection
- [ ] Prevent directory traversal
- [ ] Don't expose internal error details
- [ ] Log security-relevant events
