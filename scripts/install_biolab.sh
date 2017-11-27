#!/usr/bin/env bash
#
# Script to install all of the defined packages using conda-build.

MY_INSTALL_DIR="${HOME}/fenics-tue"

while [[ "${#}" -gt 0 ]]; do
  case "${1}" in
    -h|--help)
      echo "Usage:"
      echo ""
      echo "install_biolab.sh -p PATH"
      echo ""
      echo "Options:"
      echo ""
      echo "-h, --help    show this help info"
      echo "-p PATH       specify location to install to"
      echo "              defaults to ${MY_INSTALL_DIR}"
      exit 0
      ;;
    -p)
      shift
      if [[ "${#}" -gt 0 ]]; then
        MY_INSTALL_DIR="${1}"
      fi
      shift
      ;;
    *)
      echo "Try: install_biolab.sh -h"
      exit
      ;;
  esac
done

export MY_INSTALL_DIR && \
  install_miniconda && \
  export PATH="${MY_INSTALL_DIR}/bin:${PATH}" && \
  sh build.sh && \
  conda install -c "file:/${MY_INSTALL_DIR}/conda-bld/" -c conda-forge -y \
    fenics=2017.1 \
    gcc==4.8.5 \
    h5py \
    ipython \
    libgcc==4.8.5 \
    matplotlib \
    mpi4py \
    mshr=2017.1 \
    nose \
    pandas \
    pytest \
    scipy \
    seaborn \
    sphinx \
    sphinx_rtd_theme \
    sphinxcontrib \
    sphinxcontrib-bibtex && \
  rm "${HOME}/._mpich" "${HOME}/._hdf5" "${HOME}/._petsc" "${HOME}/._fenics" && \
  conda build purge && \
  echo "Done!"
