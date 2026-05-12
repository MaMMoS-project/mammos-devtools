# Agent Instructions for mammos-devtools

This file is only for AI coding agents. Human-facing contribution policy and
project guidance belong in `CONTRIBUTING.md`, `CONTRIBUTING-MaMMoS.md`, README
files, or normal documentation.

Read these files before editing:

1. `CONTRIBUTING.md`
2. `CONTRIBUTING-MaMMoS.md`
3. The target package's `CONTRIBUTING.md`
4. The target package's `AGENTS.md`

`packages/` contains separate Git repositories. Check branch and status in the
root repository and in each package repository you touch. Do not assume a root
branch name or status applies to packages. Make branch changes and commits
inside the repository that owns the files you changed.

Package repositories must work as standalone checkouts unless their package
documentation explicitly says otherwise. Do not write package code, tests, docs,
or commands that require `mammos-devtools` or sibling repositories by default.

MaMMoS packages depend on each other, so a change in one package may require
downstream changes in others. Do not make multi-package changes without explicit
approval from the user. Operate only on the packages needed for the task.

When new information is needed, put it in the document for its audience. Use
README files, examples, or normal docs for user-facing information. Use package
`CONTRIBUTING.md` for package-specific developer guidance and root
`CONTRIBUTING-MaMMoS.md` for shared MaMMoS developer guidance. Use `AGENTS.md`
only for AI-specific operating instructions. After editing root
`CONTRIBUTING-MaMMoS.md`, run `pixi run sync-contributing`; do not edit synced
package copies directly.
