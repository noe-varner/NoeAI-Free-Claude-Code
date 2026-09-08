# money — what comes in and goes out

One job: the numbers, from the files, never from memory.

## Layout
```
money/
  YYYY-MM/            one folder per month
    income.md         what came in, by client or product
    expenses.md       what went out, by tool or vendor
    summary.md        the month in five lines, written after the month closes
```

## Inputs
- Working (this task): the one month folder named in the request
- Reference (every task): `../business/numbers.md` (which numbers matter)

Do NOT load: bank statements or exports that hold account numbers. Keep those outside this workspace.

## Rules
- Every number traces to a line in `income.md` or `expenses.md`. If it isn't there, the answer is "not recorded", not a guess.
- No secrets here: no card numbers, no logins, no statement PDFs.

## Human check
Compare `summary.md` to the real bank balance once a month. If they disagree, the files are wrong, not the bank.
