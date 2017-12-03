#!/bin/bash
#
# Shortcut/alias to conda-build with proper options.

PREFIX="${HOME}/fenics-tue/conda"

"${PREFIX}/bin/conda" build "recipes/${1}" \
                      --no-anaconda-upload \
                      --old-build-string   \
                      --channel conda-forge