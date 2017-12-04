#!/bin/bash
#
# Install all of the FEniCS Python components.

pip install --no-deps --no-binary :all: -r "${RECIPE_DIR}/component-requirements.txt"
