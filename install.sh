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

# Add common Claude install locations to PATH for this session
for dir in "$HOME/.local/bin" "$HOME/.claude/local/bin" "/usr/local/bin"; do
    if [ -d "$dir" ] && [[ ":$PATH:" != *":$dir:"* ]]; then
        export PATH="$dir:$PATH"
    fi
done

if ! command -v claude &> /dev/null; then
    echo "  Claude Code is not installed yet."
    echo "  Installing Claude Code for you..."
    echo ""
    curl -fsSL https://claude.ai/install.sh | bash
    echo ""

    # Re-add paths after install (installer may have created ~/.local/bin)
    for dir in "$HOME/.local/bin" "$HOME/.claude/local/bin" "/usr/local/bin"; do
        if [ -d "$dir" ] && [[ ":$PATH:" != *":$dir:"* ]]; then
            export PATH="$dir:$PATH"
        fi
    done

    # Persist PATH if ~/.local/bin exists but isn't in shell config
    if [ -d "$HOME/.local/bin" ]; then
        SHELL_RC=""
        if [ -f "$HOME/.zshrc" ]; then
            SHELL_RC="$HOME/.zshrc"
        elif [ -f "$HOME/.bashrc" ]; then
            SHELL_RC="$HOME/.bashrc"
        elif [ -f "$HOME/.bash_profile" ]; then
            SHELL_RC="$HOME/.bash_profile"
        fi

        if [ -n "$SHELL_RC" ] && ! grep -q '.local/bin' "$SHELL_RC" 2>/dev/null; then
            echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$SHELL_RC"
            echo "  Added ~/.local/bin to PATH in $(basename "$SHELL_RC")"
        fi
    fi

    if ! command -v claude &> /dev/null; then
        echo ""
        echo "  Claude Code installed but not found in PATH."
        echo "  Close this terminal, open a new one, and run this installer again:"
        echo ""
        echo "    curl -fsSL https://raw.githubusercontent.com/${REPO}/main/install.sh | bash"
        echo ""
        echo "  ─────────────────────────────────────────────"
        echo "  Need help? Follow @noevarner.ai"
        echo "  ─────────────────────────────────────────────"
        echo ""
        exit 0
    fi
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
echo "  └── CLAUDE.md Templates → ~/.noeai/claude-md-templates/"
echo ""
echo "  To get updates, just re-run this command."
echo "  The installer pulls the latest from GitHub automatically."
echo ""
echo "  ─────────────────────────────────────────────"
echo "  Free course + community: https://noeai.circle.so"
echo "  Follow @noevarner.ai for daily AI tutorials"
echo "  ─────────────────────────────────────────────"
echo ""
echo "  ✅ Ready! Now just type:"
echo ""
echo "    claude"
echo ""
echo "  Then type:  /noeai:start"
echo ""
