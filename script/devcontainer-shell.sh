#!/bin/bash
project_root=$(dirname "${BASH_SOURCE[0]}")/..
if [ -e ${project_root}/.env ]; then
  source ${project_root}/.env
fi
export COMPOSE_FILE=${COMPOSE_FILE:-${project_root}/.devcontainer/docker-compose.yml}
export COMPOSE_PROJECT_NAME=${COMPOSE_PROJECT_NAME:-rubygems}
docker-compose up -d && docker-compose exec app /bin/bash -l "$@"