#!/bin/sh
set -eu

ROOT_DIR=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
COMPOSE_DIR="$ROOT_DIR/deploy/compose"
ENV_FILE="$COMPOSE_DIR/.env"

docker compose --env-file "$ENV_FILE" -f "$COMPOSE_DIR/docker-compose-opensearch-dashboards.yaml" down
docker compose --env-file "$ENV_FILE" -f "$COMPOSE_DIR/docker-compose-opensearch.yaml" down
