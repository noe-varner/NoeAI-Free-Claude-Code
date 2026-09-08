# ICM Starter — the folder structure that cuts your Claude token bill

Claude burns tokens reading files it doesn't need. A messy workspace makes it open fifty files to answer one question. This starter gives Claude one small map to read first, then one folder per job. It reads one file, not fifty.

Method: [Interpretable Context Methodology](https://arxiv.org/abs/2603.16021) by Jake Van Clief and Jimmy McDermott. This is the same shape my own business workspace runs on.

## Use it (two minutes)

1. Download this folder (green **Code** button → Download ZIP, or copy the `icm-starter` folder).
2. Rename it to your business name. Open it in Claude Code: `cd your-folder` then `claude`.
3. Fill in `_shared/business.md` and `_shared/voice.md`. Leave everything else as it is.
4. Put your existing files where they belong: one of the five job folders. Anything you can't place goes in `ops/inbox/`.

## Already have a mess?

Open your existing folder in Claude Code and paste the prompt in `_templates/restructure-prompt.md`. It rebuilds your folders onto this shape, writes the CONTEXT files, and stops so you can check the result.

## What's inside

| Path | What it is |
|---|---|
| `CLAUDE.md` | the router. Claude reads this first, every session. Keep it under one screen. |
| `CONTEXT.md` | the map of the five jobs |
| `business/` `content/` `clients/` `money/` `ops/` | one folder per job, each with its own `CONTEXT.md` |
| `_shared/` | the things that never change per task: who you are, how you sound, the rules |
| `_templates/` | blank starters, including the restructure prompt |

Built by [@noevarner.ai](https://instagram.com/noevarner.ai). The full free course lives one level up.
