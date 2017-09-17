#!/usr/bin/env bash
#
# Script to install all of the defined packages using conda-build.

conda install -c "file:/${HOME}/miniconda3/conda-bld/" -c conda-forge \
  fenics \
  gcc==4.8.5 \
  h5py \
  ipython \
  libgcc==4.8.5 \
  matplotlib \
  mpi4py \
  mshr
  nose \
  pandas \
  pytest \
  scipy \
  seaborn \
  sphinx \
  sphinx_rtd_theme
