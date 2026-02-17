#!/bin/bash
# Meta Ads MCP - One-command installer for Claude Code
# Downloads the setup wizard skill so you can type /meta-ads-setup in Claude Code

set -e

REPO="noe-varner/NoeAI-Free-Claude-Code"
BRANCH="main"
BASE_URL="https://raw.githubusercontent.com/${REPO}/${BRANCH}/meta-ads-mcp"
SKILL_DIR="$HOME/.claude/skills/meta-ads-setup"

echo ""
echo "  Meta Ads MCP - Installing Claude Code Skill..."
echo "  ================================================"
echo ""

# Create skill directory
mkdir -p "${SKILL_DIR}/reference"

# Download SKILL.md
echo "  [1/2] Downloading setup wizard..."
curl -fsSL "${BASE_URL}/SKILL.md" -o "${SKILL_DIR}/SKILL.md"

# Download server.py
echo "  [2/2] Downloading MCP server..."
curl -fsSL "${BASE_URL}/reference/server.py" -o "${SKILL_DIR}/reference/server.py"

echo ""
echo "  Done! Installed to: ${SKILL_DIR}"
echo ""
echo "  NEXT STEPS:"
echo "  1. Open Claude Code (or restart it if already open)"
echo "  2. Type: /meta-ads-setup"
echo "  3. Follow the step-by-step wizard"
echo ""
echo "  The wizard will walk you through everything:"
echo "  - Creating a Meta App"
echo "  - Generating your access token"
echo "  - Connecting your ad account"
echo "  - Installing and testing the MCP server"
echo ""
