# clients — who is paying us

One job: one folder per client, and nothing about one client inside another's folder.

## Layout
```
clients/
  _template/           copy this to start a client
  <client-name>/
    CONTEXT.md         who they are, what they bought, where they are in delivery
    notes/             call notes, dated (YYYY-MM-DD-topic.md)
    deliverables/      what we've handed them
```

## Inputs
- Working (this task): the one client folder named in the request
- Reference (every task): `../business/offer.md` (what they bought)

Do NOT load: any other client's folder. Ever.

## Rules
- Call notes are dated and never edited after the day. Add a new note instead.
- A client's `CONTEXT.md` is the only file that says where they are in delivery.

## Human check
Before any client-facing message goes out, read it against their `CONTEXT.md`. Wrong name or wrong stage is the failure this folder exists to prevent.
