# Claude Code Cheat Sheet

Everything from the course on one page. Bookmark this.

---

## Core Concepts

| Concept | What It Is | You Learned It In |
|---------|-----------|-------------------|
| **CLAUDE.md** | A file Claude reads every conversation. Makes all output personalized to your business. | Lesson 1 |
| **Skills** | Text files with instructions that become slash commands. One command = one workflow. | Lesson 2 |
| **MCP** | Model Context Protocol — connects Claude to your real tools (Airtable, CRM, APIs, etc.) | Lesson 3 |
| **Agents** | Multiple Claudes working in parallel on different tasks simultaneously. | Lesson 4 |
| **Build Pattern** | Describe it → Claude builds it → Tweak with one sentence → Repeat. | Lesson 5 |

---

## Essential Commands

| Command | What It Does |
|---------|-------------|
| `claude` | Start Claude Code |
| `/noeai:lesson-1` through `/noeai:lesson-6` | Run course lessons |
| `/noeai:skill-builder` | Build new skills from scratch (Gift from Lesson 2) |
| `/noeai:summarize` | Summarize any content |
| `/noeai:repurpose` | Repurpose content for multiple platforms |
| `/help` | Show all available commands |

---

## CLAUDE.md Quick Reference

**Location:** Create it in your project folder (wherever you run `claude` from)

**Template:**
```markdown
# CLAUDE.md

## About Me
[Your name and what you do]

## My Audience
[Who you serve]

## My Voice & Style
[How you communicate]

## Tools I Use
[Your platforms and software]

## Current Focus
[What you're working on right now]
```

**Pro tips:**
- Claude reads this EVERY conversation automatically
- The more specific you are, the better the output
- Update it as your business evolves
- You can have different CLAUDE.md files in different project folders

---

## Skills Quick Reference

**What they are:** Text files at `~/.claude/commands/` that become slash commands

**Structure (3 parts):**
```markdown
---
description: "What this skill does"
---

# Instructions
[Tell Claude what to do in plain English]

## Rules
[Guardrails for consistent output]
```

**How to create one:**
1. Type `/noeai:skill-builder`
2. Describe what you want
3. It builds and saves the skill for you

**Where they live:** `~/.claude/commands/[skill-name].md`

---

## MCP Quick Reference

**What it is:** Lets Claude connect to external tools and services

**What it enables:**
- Read/write to Airtable, Google Sheets, Notion
- Access your CRM data
- Connect to APIs (Meta Ads, Stripe, etc.)
- Search the web live
- Access your file system

**How to set it up:** Type `/mcp-builder` and tell it which tool you want to connect

---

## Agents Quick Reference

**What they are:** Multiple Claudes working at the same time on different tasks

**When to use them:**
- Multiple independent tasks (research + writing + analysis)
- Content for multiple platforms at once
- Comparing multiple competitors
- Any time you'd assign work to 3+ people simultaneously

**When NOT to use them:**
- Single simple tasks (just ask normally)
- Sequential tasks where B needs A's result first

**How to use them:** Just ask Claude to do multiple things at once. Example:
```
Research these 3 competitors in parallel and give me a comparison...
```

---

## The Build Pattern

This works for ANYTHING — landing pages, emails, proposals, dashboards, reports:

1. **Describe** what you want in plain English
2. **Claude builds** it from scratch, personalized to your CLAUDE.md
3. **Tweak** with one sentence ("make the colors darker", "add a pricing section")
4. **Repeat** until it's perfect

---

## Your Gift Files

| Gift | Location | From |
|------|----------|------|
| 30 Prompts That Print Money | `~/.noeai/gifts/30-prompts-that-print-money.md` | Lesson 1 |
| Skill Builder (skill) | `/noeai:skill-builder` | Lesson 2 |
| 5 Agent Workflows | `~/.noeai/gifts/5-agent-workflows.md` | Lesson 4 |
| Business-in-a-Box Prompt Pack | `~/.noeai/gifts/business-in-a-box.md` | Lesson 5 |
| This Cheat Sheet | `~/.noeai/gifts/cheat-sheet.md` | Lesson 6 |

---

## Troubleshooting

**"Command not found" when I type `claude`**
→ Claude Code isn't installed. Run: `npm install -g @anthropic-ai/claude-code`

**Skills don't show up when I type `/`**
→ Make sure the skill file is at `~/.claude/commands/[name].md`
→ Re-run the installer: `bash <(curl -fsSL https://raw.githubusercontent.com/noe-varner/NoeAI-Free-Claude-Code/main/install.sh)`

**CLAUDE.md doesn't seem to work**
→ Make sure it's in the folder where you RUN `claude` (not a random folder)
→ The file must be named exactly `CLAUDE.md` (case-sensitive)

**MCP connection isn't working**
→ Double-check your API key in the config
→ Run `/mcp-builder` again and follow the steps carefully
→ Make sure the MCP server is running

**Agents aren't running in parallel**
→ Make sure you're asking for INDEPENDENT tasks (not tasks that depend on each other)
→ Be explicit: "spawn 3 agents in parallel" or "do these simultaneously"

---

## What's Next

**Free resources you already have:**
- 30 prompts, 5 agent workflows, 10 mega-prompts, and this cheat sheet
- `/noeai:skill-builder` to create unlimited custom skills
- `/noeai:summarize` and `/noeai:repurpose` utility skills

**Want to go deeper?**
- Join the community: https://noeai.circle.so
- Premium system: 17 skills, 5 MCP configs, templates, monthly drops
- Follow @noevarner.ai for daily tutorials

---

**You completed the course. You're in the top 1%. Now go build something.** 🏆
