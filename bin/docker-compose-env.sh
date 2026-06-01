#!/usr/bin/env bash

set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
repo_basename="$(basename "$repo_root")"
git_common_dir="$(git -C "$repo_root" rev-parse --git-common-dir)"
primary_repo_root="$(cd "$(dirname "$git_common_dir")" && pwd)"

# Better Together Rails uses fixed service/container names for the shared dev
# database, Redis, and Elasticsearch services. Secondary git worktrees must
# reuse the primary compose project instead of inventing a per-worktree one.
export COMPOSE_PROJECT_NAME="${COMPOSE_PROJECT_NAME:-better-together-rails}"

sanitize_slug() {
  printf '%s' "$1" | tr '[:upper:]' '[:lower:]' | sed -E 's/[^a-z0-9]+/_/g; s/^_+//; s/_+$//'
}

if [[ "$repo_basename" == "better-together-rails" ]]; then
  worktree_db_suffix=""
else
  worktree_db_suffix="_$(sanitize_slug "$repo_basename")"
fi

canonical_ce_repo="$(cd "$(dirname "$primary_repo_root")/community-engine-rails" 2>/dev/null && pwd || true)"

export BTR_WORKTREE_DB_SUFFIX="${BTR_WORKTREE_DB_SUFFIX:-$worktree_db_suffix}"
export COMMUNITY_ENGINE_PATH="${COMMUNITY_ENGINE_PATH:-$canonical_ce_repo}"
export DB_HOST="${DB_HOST:-better-together-db}"
export DB_PORT="${DB_PORT:-5432}"
export DB_USERNAME="${DB_USERNAME:-postgres}"
export DB_PASSWORD="${DB_PASSWORD:-postgres}"
export POSTGRES_HOST="${POSTGRES_HOST:-$DB_HOST}"
export POSTGRES_USER="${POSTGRES_USER:-$DB_USERNAME}"
export POSTGRES_PASSWORD="${POSTGRES_PASSWORD:-$DB_PASSWORD}"
export REDIS_URL="${REDIS_URL:-redis://better-together-redis:6379}"
export SEARCH_BACKEND="${SEARCH_BACKEND:-pg_search}"
export ELASTICSEARCH_DISABLED="${ELASTICSEARCH_DISABLED:-true}"
