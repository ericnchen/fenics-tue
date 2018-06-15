#!/usr/bin/env bash
set -e

export PETSC_DIR="${PREFIX}"
make
pip install --no-deps --no-binary :all: .
