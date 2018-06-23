#!/usr/bin/env bash

# This environment variable needs to be exported.
# For now this is done here so that I don't have to rebuild/repackage petsc.

export OLD_PETSC_DIR="${PETSC_DIR}"
export PETSC_DIR="${CONDA_PREFIX}"
