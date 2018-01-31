#!/usr/bin/env bash
set -e

"${PYTHON}" test/test-meshes.py
"${PYTHON}" test/test-mesh-generation.py
