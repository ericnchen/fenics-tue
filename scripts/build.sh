#!/usr/bin/env bash
#
# Script to build all of the defined packages using conda-build.

conda_build() {
  conda-build "${HOME}/shared/external/${1}-feedstock" \
              -c "file:/${HOME}/miniconda3/conda-bld/" \
              -c conda-forge
}

for each in mpich hdf5 petsc fenics; do
  if [ ! -e "${HOME}/._${each}" ]; then
    conda_build "${each}" && touch "${HOME}/._${each}"
  else
    echo "Skipping build for ${each} because it already exists."
  fi
done
