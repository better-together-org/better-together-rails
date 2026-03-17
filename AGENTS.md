# AGENTS.md

Instructions for AI coding agents working in this repository.

## Repository Write Boundary (CRITICAL)
- Only create, edit, move, or delete files inside this repository root.
- Never write project artifacts to `/tmp` or other system-wide temporary locations.
- Use repository-local temporary paths such as `tmp/`.
- If a command defaults to `/tmp`, override it to a path under this repository.

## Working Rules
- Prefer small, reviewable changes.
- Run targeted tests/lint for touched files before finishing.
- Do not commit secrets, credentials, or production data.
