# Agent Instructions for mammos-devtools

Read these files before editing:

1. `CONTRIBUTING.md`
2. `CONTRIBUTING-MaMMoS.md`
3. The target package's `CONTRIBUTING.md`
4. The target package's `AGENTS.md`

`packages/` contains separate Git repositories. Check branch and status in the
root repository and in each package repository you touch. Do not assume a root
branch name or status applies to packages.

Keep human-facing project standards in `CONTRIBUTING-MaMMoS.md`,
`CONTRIBUTING.md`, README files, or normal docs. Use `AGENTS.md` only for
agent-specific operational guidance.

Package repositories must work as standalone checkouts. Do not write package
code, tests, docs, or commands that require `mammos-devtools` or sibling
repositories unless the package documentation explicitly says so.

Prefer focused package edits. A pattern in one package is useful context, but do
not propagate changes across every package without a concrete reason.

For shared contribution guidance, edit root `CONTRIBUTING-MaMMoS.md` and run
`pixi run sync-contributing-mammos`. Do not edit synced package copies directly.
