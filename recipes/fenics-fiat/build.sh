#!/usr/bin/env bash
set -e

source "${RECIPE_DIR}/fix-environment.sh"

pip install --no-deps --no-binary :all: .
