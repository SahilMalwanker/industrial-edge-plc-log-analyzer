#!/bin/sh
set -eu

ROOT_DIR=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
COMPOSE_DIR="$ROOT_DIR/deploy/compose"
ENV_FILE="$COMPOSE_DIR/.env"

if [ ! -f "$ENV_FILE" ]; then
  printf '%s\n' "Missing $ENV_FILE. Run: cp deploy/compose/.env.example deploy/compose/.env" >&2
  exit 1
fi

docker network inspect element-logic >/dev/null 2>&1 || docker network create element-logic >/dev/null
docker compose --env-file "$ENV_FILE" -f "$COMPOSE_DIR/docker-compose-opensearch.yaml" up -d
docker compose --env-file "$ENV_FILE" -f "$COMPOSE_DIR/docker-compose-opensearch-dashboards.yaml" up -d
