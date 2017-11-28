#!/usr/bin/env bash
#
# TODO WIP

# TODO Generate config info from script. Hardcoded for now to test install.
FENICS_TARGET="2017.1.0"
PYTHON_TARGET="3.5"
LINALG_TARGET="mkl"
FOLDER_TARGET="testing-fenics-tue"
PREFIX_TARGET="${HOME}/${FOLDER_TARGET}"

PROXY_SERVER="proxy.wfw.wtb.tue.nl"


check_internet() {
  # Check if internet is available.
  #
  # Exit Codes
  #   0 - internet is available
  #   * - internet is not available

  wget -q --tries=2 --timeout=2 --spider https://google.com
}


check_directory() {
  # Check if directory exists to figure out if something should be done.
  #
  # Usage
  #   check_directory /path/to/directory
  #
  # Exit Codes
  #   0 - do nothing (directory exists)
  #   1 - do something (directory doesn't exist)

  if [ ! -e "${1}" ]; then
    return 1
  fi

  return 0
}


install_conda_base() {
  # Installs the conda base system.

  check_internet
  if [ "${?}" != "0" ]; then
    export https_proxy="https://${PROXY_SERVER}:443"
  fi

  check_directory "${PREFIX_TARGET}/conda"
  if [ "${?}" == "1" ]; then
    local RNG="${RANDOM}${RANDOM}"
    local SYS="$([ "$(uname -s)" == "Darwin" ] && echo "MacOSX" || echo "Linux")"
    local URL="https://repo.continuum.io/miniconda/Miniconda3-latest-${SYS}-x86_64.sh"

    echo "Downloading Miniconda ..."
    wget -q -O "/tmp/miniconda${RNG}.sh" "${URL}"

    echo "Installing conda to ${PREFIX_TARGET}/conda ..."
    bash "/tmp/miniconda${RNG}.sh" -b -p "${PREFIX_TARGET}/conda" > /dev/null 2>&1
    rm   "/tmp/miniconda${RNG}.sh"

    echo "Installing the conda-build tool ..."
    "${PREFIX_TARGET}/conda/bin/conda" install -y conda-build > /dev/null 2>&1
  fi
}


install_conda_environment() {
  # Installs the conda environment.

  local TARGET="${FENICS_TARGET}-py${PYTHON_TARGET}-${LINALG_TARGET}"

  check_internet
  if [ "${?}" != "0" ]; then
    export https_proxy="https://${PROXY_SERVER}:443"
  fi

  check_directory "${PREFIX_TARGET}/conda/envs/${TARGET}"
  if [ "${?}" == "1" ]; then
    echo "Installing conda environment ${TARGET} ..."
    "${PREFIX_TARGET}/conda/bin/conda" env create -f "${TARGET}.yaml"
    #> /dev/null 2>&1
  fi
}


install() {
  # Installs the conda base system and then the appropriate FEniCS version(s).

  install_conda_base
#  install_conda_environment
}


#install

build_hdf5() {
  # Build the HDF5 library with parallel support.

  echo "Building the HDF5 library with parallel support ..."
  "${PREFIX_TARGET}/conda/bin/conda" build -c conda-forge --python "${PYTHON_TARGET}" recipes/hdf5-parallel
  "${PREFIX_TARGET}/conda/bin/conda" build purge
}

build_fenics() {
  # Build DOLFIN with a parallel supported HDF5 library.

  echo "Building DOLFIN with a parallel supported HDF5 library ..."
  "${PREFIX_TARGET}/conda/bin/conda" build -c conda-forge --python "${PYTHON_TARGET}" recipes/fenics-hdf5-parallel
  "${PREFIX_TARGET}/conda/bin/conda" build purge
}

build_instant() {
  # Build (convert) instant into a conda package.

  echo "Converting instant into a conda package ..."
  "${PREFIX_TARGET}/conda/bin/conda" build -c conda-forge --python "${PYTHON_TARGET}" recipes/instant
  "${PREFIX_TARGET}/conda/bin/conda" build purge
}

build_ufl() {
  # Build (convert) UFL into a conda package.

  echo "Converting UFL into a conda package ..."
  "${PREFIX_TARGET}/conda/bin/conda" build -c conda-forge --python "${PYTHON_TARGET}" recipes/ufl
  "${PREFIX_TARGET}/conda/bin/conda" build purge
}

build_dijitso() {
  # Build (convert) dijitso into a conda package.

  echo "Converting dijitso into a conda package ..."
  "${PREFIX_TARGET}/conda/bin/conda" build -c conda-forge --python "${PYTHON_TARGET}" recipes/dijitso
  "${PREFIX_TARGET}/conda/bin/conda" build purge
}

build_fiat() {
  # Build (convert) FIAT into a conda package.

  echo "Converting FIAT into a conda package ..."
  "${PREFIX_TARGET}/conda/bin/conda" build -c conda-forge --python "${PYTHON_TARGET}" recipes/fiat
  "${PREFIX_TARGET}/conda/bin/conda" build purge
}

build_ffc() {
  # Build (convert) FFC into a conda package.
  #
  # Requires
  #   dijitso
  #   UFL
  #   FIAT

  echo "Converting FFC into a conda package ..."
  "${PREFIX_TARGET}/conda/bin/conda" build -c conda-forge --python "${PYTHON_TARGET}" recipes/ffc
  "${PREFIX_TARGET}/conda/bin/conda" build purge
}