---
name: meta-ads-setup
description: Step-by-step wizard to set up the Meta Ads MCP server for Claude Code.
---

# Meta Ads MCP Setup Wizard

Interactive setup that walks you through connecting your Meta (Facebook) Ad account to Claude Code via an MCP server. When done, you'll have 15 tools for managing campaigns, reading insights, creating ads, and managing audiences -- all from within Claude Code.

## What Gets Installed

- A Python MCP server (FastMCP) that talks directly to the Meta Marketing API
- 15 tools: list/create/update campaigns, ad sets, ads, insights with breakdowns, custom audiences
- Registered in your `~/.mcp.json` so Claude Code picks it up automatically

---

## STEP 0: Check Prerequisites

Before starting, verify the user has:
1. **Claude Code** installed and working
2. **A Meta Ad Account** (any active ad account in Meta Business Manager)
3. **Python 3.10+** available (check with `python3 --version`, or install via `uv` if needed)

Run these checks:
```bash
python3 --version
```

If Python is below 3.10, check for `uv`:
```bash
which uv || ls ~/.local/bin/uv
```

If neither exists, install `uv` which will manage Python for us:
```bash
curl -LsSf https://astral.sh/uv/install.sh | sh
```

Then use `uv` to create a Python 3.12 venv later in Step 5.

Tell the user what you found and move to Step 1.

---

## STEP 1: Create a Meta App

Tell the user:

> We need a Meta App to generate API credentials. This takes about 2 minutes.
>
> 1. Go to **https://developers.facebook.com/apps/create/**
> 2. Choose **"Other"** for use case, click Next
> 3. Choose **"Business"** as the app type, click Next
> 4. Give it a name (e.g. "Claude Code Ads") and select your Business Account
> 5. Click **Create App**
>
> Once created, you'll land on the App Dashboard.

**STOP and ask the user:** "Let me know when your app is created. What did you name it?"

Wait for confirmation before proceeding.

---

## STEP 2: Add Marketing API to the App

Tell the user:

> Now we need to add the Marketing API product to your app.
>
> 1. In your App Dashboard, click **"Add Product"** in the left sidebar (or scroll down on the dashboard)
> 2. Find **"Marketing API"** and click **"Set up"**
> 3. That's it -- it's now added to your app

**STOP and ask:** "Done? Let's move on to generating your access token."

---

## STEP 3: Create a System User + Generate Token

Tell the user:

> System Users give us a token that never expires -- perfect for automation.
>
> 1. Go to **https://business.facebook.com/settings/system-users** (Business Settings > Users > System Users)
> 2. Click **"Add"** to create a new system user
> 3. Name it something like "Claude Code" and set role to **Admin**
> 4. Click **"Create System User"**
> 5. Now click **"Generate New Token"**
> 6. Select your app (the one you just created, e.g. "Claude Code Ads")
> 7. Check these permissions:
>    - `ads_management`
>    - `ads_read`
>    - `business_management`
> 8. Set token expiration to **"Never"**
> 9. Click **"Generate Token"**
> 10. **COPY THE TOKEN** -- you won't be able to see it again!

**STOP and ask the user to paste their access token.**

When they paste it, store it in a variable -- we'll use it in Step 5.

---

## STEP 4: Assign Ad Account to System User

Tell the user:

> The system user needs access to your specific ad account.
>
> 1. Still in Business Settings > System Users, click on your "Claude Code" system user
> 2. Click **"Add Assets"**
> 3. Select **"Ad Accounts"** from the asset type dropdown
> 4. Find and select your ad account
> 5. Toggle on **"Full Control"** (or at minimum: Manage campaigns)
> 6. Click **"Save Changes"**
>
> Now I need your **Ad Account ID**. You can find it in:
> - Meta Ads Manager URL: `https://adsmanager.facebook.com/adsmanager/manage/campaigns?act=XXXXXXXXX`
> - Or Business Settings > Accounts > Ad Accounts -- the number shown

**STOP and ask for their Ad Account ID.** It's a number like `123456789012345`. They do NOT need to include the `act_` prefix -- we'll add it automatically.

---

## STEP 5: Validate Token + Install Server

Now that we have the access token and ad account ID, validate everything works before installing.

### 5a: Validate the token

```bash
curl -s "https://graph.facebook.com/v21.0/act_{AD_ACCOUNT_ID}?fields=name,account_status,currency&access_token={TOKEN}"
```

**If this returns an error:**
- `(#200) ... NOT grant ads_management` -- The system user doesn't have the ad account assigned. Go back to Step 4.
- `Invalid OAuth access token` -- Token was copied wrong. Regenerate in Step 3.
- `(#100) ... does not exist` -- Wrong ad account ID. Double-check in Ads Manager.

**If it returns JSON with the account name** -- We're good! Show the user their account info and proceed.

### 5b: Create the MCP server directory

Determine where to install. Use `~/mcp-servers/meta-ads-mcp/` as the default, or ask the user if they prefer somewhere else.

```bash
mkdir -p ~/mcp-servers/meta-ads-mcp
```

### 5c: Create the virtual environment

If `uv` is available:
```bash
~/.local/bin/uv venv --python 3.12 ~/mcp-servers/meta-ads-mcp/venv
~/.local/bin/uv pip install --python ~/mcp-servers/meta-ads-mcp/venv/bin/python "mcp>=1.0.0" httpx
```

If only system Python 3.10+ is available:
```bash
python3 -m venv ~/mcp-servers/meta-ads-mcp/venv
~/mcp-servers/meta-ads-mcp/venv/bin/pip install "mcp>=1.0.0" httpx
```

### 5d: Copy the server code

Read the server code from this skill's reference file and write it to the install location:

```
Read: ~/.claude/skills/meta-ads-setup/reference/server.py
Write to: ~/mcp-servers/meta-ads-mcp/server.py
```

### 5e: Verify the server loads

```bash
~/mcp-servers/meta-ads-mcp/venv/bin/python -c "
import sys, os
os.environ['META_ACCESS_TOKEN'] = 'test'
os.environ['META_AD_ACCOUNT_ID'] = 'act_123'
sys.path.insert(0, os.path.expanduser('~/mcp-servers/meta-ads-mcp'))
from server import mcp
tools = mcp._tool_manager._tools
print(f'Server loaded: {len(tools)} tools registered')
for name in sorted(tools.keys()):
    print(f'  - {name}')
"
```

Should show 15 tools. If it errors, debug the Python/dependency issue.

---

## STEP 6: Register in Claude Code

Read the user's `~/.mcp.json` file. If it exists, add the `meta-ads` entry to the existing `mcpServers` object. If it doesn't exist, create it.

The entry to add (substitute real values):

```json
"meta-ads": {
  "command": "FULL_PATH_TO_VENV/bin/python",
  "args": ["FULL_PATH_TO/server.py"],
  "env": {
    "META_ACCESS_TOKEN": "THE_TOKEN_THEY_PASTED",
    "META_AD_ACCOUNT_ID": "act_THEIR_ACCOUNT_ID"
  }
}
```

IMPORTANT:
- Use absolute paths (expand `~` to the actual home directory)
- Prepend `act_` to the ad account ID if the user didn't include it
- The token goes in `env`, never hardcoded in the server code

---

## STEP 7: Verify End-to-End

Run a live API test using the installed server's Python and the real credentials:

```bash
FULL_PATH_TO_VENV/bin/python -c "
import os, asyncio, sys
os.environ['META_ACCESS_TOKEN'] = 'THE_TOKEN'
os.environ['META_AD_ACCOUNT_ID'] = 'act_THE_ID'
sys.path.insert(0, 'FULL_PATH_TO_SERVER_DIR')

import httpx
async def test():
    async with httpx.AsyncClient(timeout=30.0) as client:
        resp = await client.get(
            'https://graph.facebook.com/v21.0/act_THE_ID',
            params={
                'fields': 'name,account_status,currency,amount_spent',
                'access_token': os.environ['META_ACCESS_TOKEN']
            }
        )
        data = resp.json()
        if 'error' in data:
            print(f'ERROR: {data[\"error\"][\"message\"]}')
        else:
            print(f'Connected to: {data.get(\"name\")}')
            print(f'Currency: {data.get(\"currency\")}')
            print(f'Total spend: {int(data.get(\"amount_spent\", 0))/100:.2f}')
            print('SUCCESS - Meta Ads MCP is ready!')

asyncio.run(test())
"
```

---

## STEP 8: Done!

Tell the user:

> Your Meta Ads MCP server is installed and ready!
>
> **Restart Claude Code** to load the new MCP server. Then you can use commands like:
>
> - "Show me my active campaigns"
> - "What's my ad spend this month?"
> - "Break down my performance by age and gender"
> - "Create a new traffic campaign called Q1 Push with a $50/day budget"
> - "Pause campaign 12345"
> - "Show me my custom audiences"
>
> **15 tools available:**
> `meta_list_campaigns`, `meta_list_adsets`, `meta_list_ads`,
> `meta_account_insights`, `meta_campaign_insights`, `meta_adset_insights`, `meta_ad_insights`,
> `meta_create_campaign`, `meta_update_campaign`,
> `meta_create_adset`, `meta_update_adset`,
> `meta_create_ad`, `meta_update_ad`,
> `meta_list_audiences`, `meta_create_audience`
>
> **Security note:** Your access token is stored locally in `~/.mcp.json`. It never leaves your machine except when calling Meta's API directly. Treat this file like a password vault -- don't commit it to git or share it.

---

## CRITICAL RULES

1. **NEVER skip validation.** Always test the token in Step 5a before installing anything.
2. **NEVER hardcode tokens** in the server code. They go in `~/.mcp.json` env vars only.
3. **STOP at every STOP point** and wait for the user. Do not rush ahead.
4. **If anything fails**, diagnose clearly. Common issues:
   - Token missing permissions -- Step 3 (regenerate with correct scopes)
   - Ad account not assigned -- Step 4 (add asset to system user)
   - Python too old -- Install via `uv` with Python 3.12
   - Import errors -- Check venv activation and pip install
5. **Use absolute paths** everywhere in `.mcp.json`. Never use `~` or relative paths.
6. **Always prepend `act_`** to the ad account ID if the user provides just the number.
