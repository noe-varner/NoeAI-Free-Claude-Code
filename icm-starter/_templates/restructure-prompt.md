# The restructure prompt

Open your existing folder in Claude Code and paste this. It rebuilds onto the ICM shape and stops for you to check.

```
Restructure my files on ICM.

Rules:
1. Read the ICM starter shape: a root CLAUDE.md that only routes, a CONTEXT.md map, five job folders (business, content, clients, money, ops) each with its own CONTEXT.md, a _shared folder for voice and rules, a _templates folder for blank starters.
2. First, list every file here with a one-line guess of which job folder it belongs to. Show me the list and STOP. Do not move anything yet.
3. After I approve the list, move the files. Anything you cannot place goes in ops/inbox/.
4. Write a CONTEXT.md in each job folder that says: what lives here, what to read first, what NOT to load, and one human check.
5. Write the root CLAUDE.md as a router under one screen: where things live, and which folder to open for which kind of request. It must not describe what is inside the folders.
6. Every move fixes every link to the moved file. Verify zero broken links before you finish.
7. Never delete anything. Never put a secret in a file.
Report what moved, what went to inbox, and what you could not resolve.
```
