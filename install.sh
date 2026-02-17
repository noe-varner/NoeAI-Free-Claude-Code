#!/bin/bash
# NoeAI Free Claude Code — One-Command Installer
# Installs free skills, templates, and resources

set -e

REPO="noe-varner/NoeAI-Free-Claude-Code"
REPO_URL="https://github.com/${REPO}.git"
INSTALL_DIR="$HOME/.noeai"
SKILL_DIR="$HOME/.claude/commands/noeai"

echo ""
echo "  NoeAI Free Claude Code"
echo "  ======================"
echo ""

# ── Check for Claude Code ────────────────────────────────

if ! command -v claude &> /dev/null; then
    echo "  Claude Code is not installed yet."
    echo ""
    echo "  No worries — here's how to get it (takes 2 minutes):"
    echo ""
    echo "  STEP 1: Install Node.js (if you don't have it)"
    echo "  ───────────────────────────────────────────────"
    if [[ "$OSTYPE" == "darwin"* ]]; then
        echo "  Download from: https://nodejs.org"
        echo "  (Click the big green button, install, done.)"
    else
        echo "  Download from: https://nodejs.org"
        echo "  Or: sudo apt install nodejs npm"
    fi
    echo ""
    echo "  STEP 2: Install Claude Code"
    echo "  ───────────────────────────"
    echo "  npm install -g @anthropic-ai/claude-code"
    echo ""
    echo "  STEP 3: Run this installer again"
    echo "  ────────────────────────────────"
    echo "  curl -fsSL https://raw.githubusercontent.com/${REPO}/main/install.sh | bash"
    echo ""
    echo "  ─────────────────────────────────────────────"
    echo "  Follow @noevarner.ai for setup help"
    echo "  ─────────────────────────────────────────────"
    echo ""
    exit 0
fi

echo "  ✓ Claude Code detected"
echo ""

# ── Clone or update the repo ──────────────────────────────

if [ -d "$INSTALL_DIR" ]; then
    echo "  Updating existing installation..."
    cd "$INSTALL_DIR"
    git pull --quiet origin main
    echo "  Updated to latest version."
else
    echo "  Downloading NoeAI Free Claude Code..."
    git clone --quiet "$REPO_URL" "$INSTALL_DIR"
    echo "  Downloaded."
fi

echo ""

# ── Install skills to Claude Code ─────────────────────────

echo "  Installing skills..."
mkdir -p "$SKILL_DIR"

SKILL_COUNT=0
for skill_file in "$INSTALL_DIR/skills/"*.md; do
    if [ -f "$skill_file" ]; then
        cp "$skill_file" "$SKILL_DIR/"
        SKILL_NAME=$(basename "$skill_file" .md)
        echo "    ✓ /noeai:${SKILL_NAME}"
        SKILL_COUNT=$((SKILL_COUNT + 1))
    fi
done

if [ "$SKILL_COUNT" -eq 0 ]; then
    echo "    No skills found."
else
    echo "  ${SKILL_COUNT} skill(s) installed."
fi

echo ""

# ── Summary ───────────────────────────────────────────────

echo "  Done!"
echo ""
echo "  What was installed:"
echo "  ├── Skills → ~/.claude/commands/noeai/"
echo "  ├── Course → ~/.noeai/course/"
echo "  ├── Gifts → ~/.noeai/gifts/"
echo "  ├── CLAUDE.md Templates → ~/.noeai/claude-md-templates/"
echo "  └── MCP Server Templates → ~/.noeai/mcp-servers/"
echo ""
echo "  NEXT STEPS:"
echo "  1. Open Claude Code:  claude"
echo "  2. Start the course:  /noeai:lesson-1"
echo "  3. Or try a skill:    /noeai:summarize"
echo ""
echo "  To get updates, just re-run this command."
echo "  The installer pulls the latest from GitHub automatically."
echo ""
echo "  ─────────────────────────────────────────────"
echo "  Free course + community: https://noeai.circle.so"
echo "  Follow @noevarner.ai for daily AI tutorials"
echo "  ─────────────────────────────────────────────"
echo ""
