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

## Session Audit And Worktree Bootstrap
- Start each agent session with `./scripts/session_command_log.sh init`.
- Before mutating work, run `./scripts/session_worktree.sh ensure --repo . --agent <codex|claude|copilot|local> --session-id "${CODEX_THREAD_ID:-$(date -u +%Y%m%dT%H%M%SZ)}" --storage-mode local`.
- Run consequential commands through `./scripts/session_command_log.sh run --intent "<intent>" -- <command>`.
- Session command logs and worktree metadata must remain anchored in the repository's main `logs/sessions/` directory, even when the current shell is inside a linked worktree.
