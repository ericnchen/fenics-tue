#!/usr/bin/env bash
set -e

mkdir -p "${PREFIX}/etc/conda/activate.d" "${PREFIX}/etc/conda/deactivate.d"

cp "${RECIPE_DIR}/${march}/activate-gcc_linux-64.sh"        "${PREFIX}/etc/conda/activate.d/activate-gcc_linux-64.sh"
cp "${RECIPE_DIR}/${march}/activate-gfortran_linux-64.sh"   "${PREFIX}/etc/conda/activate.d/activate-gfortran_linux-64.sh"
cp "${RECIPE_DIR}/${march}/activate-gxx_linux-64.sh"        "${PREFIX}/etc/conda/activate.d/activate-gxx_linux-64.sh"

cp "${RECIPE_DIR}/${march}/deactivate-gcc_linux-64.sh"      "${PREFIX}/etc/conda/deactivate.d/deactivate-gcc_linux-64.sh"
cp "${RECIPE_DIR}/${march}/deactivate-gfortran_linux-64.sh" "${PREFIX}/etc/conda/deactivate.d/deactivate-gfortran_linux-64.sh"
cp "${RECIPE_DIR}/${march}/deactivate-gxx_linux-64.sh"      "${PREFIX}/etc/conda/deactivate.d/deactivate-gxx_linux-64.sh"
