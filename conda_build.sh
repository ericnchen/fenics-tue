#!/bin/bash
#
# Shortcut/alias to conda-build with proper options.

PREFIX="${HOME}/fenics-tue/conda"

if [ "${1}" == "purge" ]; then
  "${PREFIX}/conda/bin/conda" build purge
  return 0
fi

"${PREFIX}/bin/conda" build "recipes/${1}" \
                      --no-anaconda-upload \
                      --old-build-string   \
                      --channel conda-forge
