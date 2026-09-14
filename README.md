# Week 4 — Data engineering, pull requests, and Make

This is your workspace for the week 4 tutorial. You will build a small data pipeline,
commit your work in two branches, and merge both through pull requests.

## Start here

1. **Use this template** on GitHub to create your own repository (do not fork).
2. Clone your new repository and open it in Positron/VS Code.
3. Download the data
4. Open `src/data_engineering.R` and start at Exercise 1.

## How this repo is organised

| Folder | What it is | Do you edit it? |
|---|---|---|
| `examples/` | Worked code from the slides. Runnable. | No — read and run it |
| `src/` | Your scripts. Exercises live here as stubs. | **Yes** |
| `data/` | Raw CSV files, downloaded in step 3 | No |
| `temp/` | Intermediate outputs you generate | No — generated |
| `output/` | Final outputs you generate | No — generated |

## The rule about committing

**Commit scripts and the makefile. Never commit the contents of `data/`, `temp/`, or `output/`.**

Generated files are reproducible: anyone with your code can rebuild them. Committing them
makes your history noisy and your diffs unreadable. The `.gitignore` already enforces this,
so you mostly need to remember *why*.

## Working method

The `examples/` folder shows you a pattern. The stubs in `src/` ask you to apply it to a new
problem. The stubs deliberately do **not** contain the answer — they contain the questions
that get you there. When you are stuck:

1. Re-read the matching example.
2. Re-read the question in the comment — it usually names the verb you need.
3. Ask a neighbour, then ask me.

Solutions are in the slide deck, at the end. Use them only if you are truly blocked; reading
the answer before you have struggled a little is the fastest way to not learn this.

## What you practice today

Two merged pull requests in your own repository:

- **PR1** — `feature/week4-data` → `main` (the data engineering work)
- **PR2** — `feature/week4-make` → `main` (the Make automation)

Each PR should contain several small commits, not one giant one. The commit checkpoints are
marked in the stub files.
