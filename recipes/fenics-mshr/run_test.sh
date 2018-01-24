#!/usr/bin/env bash
set -e

source "${RECIPE_DIR}/fix-environment.sh"

"${PYTHON}" test/test-meshes.py
"${PYTHON}" test/test-mesh-generation.py
