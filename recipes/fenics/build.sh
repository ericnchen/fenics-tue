#!/usr/bin/env bash
set -e

# This environment variable needs to be exported.
# For now this is done here so that I don't have to rebuild/repackage petsc.

mkdir -p "${PREFIX}/etc/conda/activate.d" "${PREFIX}/etc/conda/deactivate.d"
cp "${RECIPE_DIR}/activate-fenics-export-petsc-dir.sh" "${PREFIX}/etc/conda/activate.d/activate-fenics-export-petsc-dir.sh"
cp "${RECIPE_DIR}/deactivate-fenics-export-petsc-dir.sh" "${PREFIX}/etc/conda/deactivate.d/deactivate-fenics-export-petsc-dir.sh"
