# NoeAI Free Claude Code — One-Command Installer (Windows)
# Installs free skills, templates, and resources

$ErrorActionPreference = "Stop"

$REPO = "noe-varner/NoeAI-Free-Claude-Code"
$REPO_URL = "https://github.com/$REPO.git"
$INSTALL_DIR = "$env:USERPROFILE\.noeai"
$SKILL_DIR = "$env:USERPROFILE\.claude\commands\noeai"

Write-Host ""
Write-Host "  NoeAI Free Claude Code"
Write-Host "  ======================"
Write-Host ""

# -- Check for Claude Code --

$claudePath = Get-Command claude -ErrorAction SilentlyContinue
if (-not $claudePath) {
    Write-Host "  Claude Code is not installed yet."
    Write-Host ""
    Write-Host "  Copy and paste this into PowerShell to install it:"
    Write-Host ""
    Write-Host "    irm https://claude.ai/install.ps1 | iex"
    Write-Host ""
    Write-Host "  Then run this installer again:"
    Write-Host ""
    Write-Host "    irm https://raw.githubusercontent.com/$REPO/main/install.ps1 | iex"
    Write-Host ""
    Write-Host "  -----------------------------------------"
    Write-Host "  Need help? Follow @noevarner.ai"
    Write-Host "  -----------------------------------------"
    Write-Host ""
    exit 0
}

Write-Host "  OK Claude Code detected"
Write-Host ""

# -- Check for git --

$gitPath = Get-Command git -ErrorAction SilentlyContinue
if (-not $gitPath) {
    Write-Host "  Git is not installed yet."
    Write-Host ""
    Write-Host "  Download it from: https://git-scm.com/download/win"
    Write-Host "  Then run this installer again."
    Write-Host ""
    exit 0
}

# -- Clone or update the repo --

if (Test-Path $INSTALL_DIR) {
    Write-Host "  Updating existing installation..."
    Push-Location $INSTALL_DIR
    git pull --quiet origin main
    Pop-Location
    Write-Host "  Updated to latest version."
} else {
    Write-Host "  Downloading NoeAI Free Claude Code..."
    git clone --quiet $REPO_URL $INSTALL_DIR
    Write-Host "  Downloaded."
}

Write-Host ""

# -- Install skills to Claude Code --

Write-Host "  Installing skills..."
if (-not (Test-Path $SKILL_DIR)) {
    New-Item -ItemType Directory -Path $SKILL_DIR -Force | Out-Null
}

$SKILL_COUNT = 0
$skillFiles = Get-ChildItem -Path "$INSTALL_DIR\skills\*.md" -ErrorAction SilentlyContinue
foreach ($skill in $skillFiles) {
    Copy-Item $skill.FullName -Destination $SKILL_DIR -Force
    $skillName = $skill.BaseName
    Write-Host "    OK /noeai:$skillName"
    $SKILL_COUNT++
}

if ($SKILL_COUNT -eq 0) {
    Write-Host "    No skills found."
} else {
    Write-Host "  $SKILL_COUNT skill(s) installed."
}

Write-Host ""

# -- Summary --

Write-Host "  Done!"
Write-Host ""
Write-Host "  What was installed:"
Write-Host "  +-- Skills -> ~\.claude\commands\noeai\"
Write-Host "  +-- Course -> ~\.noeai\course\"
Write-Host "  +-- Gifts -> ~\.noeai\gifts\"
Write-Host "  +-- CLAUDE.md Templates -> ~\.noeai\claude-md-templates\"
Write-Host ""
Write-Host "  To get updates, just re-run this command."
Write-Host "  The installer pulls the latest from GitHub automatically."
Write-Host ""
Write-Host "  -----------------------------------------"
Write-Host "  Free course + community: https://noeai.circle.so"
Write-Host "  Follow @noevarner.ai for daily AI tutorials"
Write-Host "  -----------------------------------------"
Write-Host ""
Write-Host "  Ready! Now just type:"
Write-Host ""
Write-Host "    claude"
Write-Host ""
Write-Host "  Then type:  /noeai:start"
Write-Host ""
