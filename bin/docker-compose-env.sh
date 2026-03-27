#!/usr/bin/env bash

set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

detect_compose_project() {
  local container_name="$1"
  docker inspect -f '{{ index .Config.Labels "com.docker.compose.project" }}' "$container_name" 2>/dev/null || true
}

existing_project="$(detect_compose_project better-together-db)"
export COMPOSE_PROJECT_NAME="${COMPOSE_PROJECT_NAME:-${existing_project:-better-together-rails}}"
