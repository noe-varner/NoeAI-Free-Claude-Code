# Meta Ads MCP for Claude Code

Manage your Meta (Facebook) Ads directly from Claude Code. 15 tools for campaigns, insights, audiences, and more.

## Install (One Command)

```bash
curl -fsSL https://raw.githubusercontent.com/noe-varner/NoeAI-Free-Claude-Code/main/meta-ads-mcp/install.sh | bash
```

Then open Claude Code and type:

```
/meta-ads-setup
```

The wizard walks you through everything step by step. No coding required.

## What You Get

| Tool | What it does |
|------|-------------|
| `meta_list_campaigns` | List all campaigns with status, budget, objective |
| `meta_list_adsets` | List ad sets with targeting, budget, schedule |
| `meta_list_ads` | List ads with creative details |
| `meta_account_insights` | Account-level performance (spend, clicks, ROAS...) |
| `meta_campaign_insights` | Campaign performance with breakdowns |
| `meta_adset_insights` | Ad set performance with breakdowns |
| `meta_ad_insights` | Individual ad performance |
| `meta_create_campaign` | Create new campaigns |
| `meta_update_campaign` | Update campaign name, status, budget |
| `meta_create_adset` | Create ad sets with targeting + budget |
| `meta_update_adset` | Update ad set targeting, budget, status |
| `meta_create_ad` | Create ads linking creative to ad sets |
| `meta_update_ad` | Update ad status or creative |
| `meta_list_audiences` | List custom audiences |
| `meta_create_audience` | Create custom audiences |

## Example Commands

Once installed, just talk to Claude naturally:

- "Show me my active campaigns"
- "What's my ad spend this month?"
- "Break down performance by age and gender"
- "Create a traffic campaign called Q1 Push with $50/day"
- "Pause campaign 12345"

## Requirements

- [Claude Code](https://claude.ai/download) installed
- A Meta Ad Account (any active ad account in Meta Business Manager)
- Python 3.10+ (the wizard will help install this if needed)

## Security

- Your access token is stored locally in `~/.mcp.json` (never committed to git)
- The token only leaves your machine when calling Meta's API directly
- No data is sent to any third-party servers

## Uninstall

```bash
rm -rf ~/.claude/skills/meta-ads-setup
rm -rf ~/mcp-servers/meta-ads-mcp
```

Then remove the `meta-ads` entry from `~/.mcp.json`.
