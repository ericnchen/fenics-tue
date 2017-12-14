#!/bin/bash
#
# Install all of the FEniCS Python components.

PIP_OPTIONS="--no-deps --no-binary :all:"

if [ "$(hostname -s)" == 'rng' ] || [ "$(hostname -s)" == 'furnace' ]; then
  PIP_OPTIONS="${PIP_OPTIONS} --proxy https://proxy.wfw.wtb.tue.nl:443"
fi

pip install ${PIP_OPTIONS} -r "${RECIPE_DIR}/component-requirements.txt"
