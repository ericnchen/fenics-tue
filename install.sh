#!/usr/bin/env bash
#
# TODO WIP

# TODO Generate config info from script. Hardcoded for now to test install.
FENICS_TARGET="2017.1.0"
PYTHON_TARGET="3.5"
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

    echo "Installing Miniconda to ${PREFIX_TARGET}/conda ..."
    bash "/tmp/miniconda${RNG}.sh" -b -p "${PREFIX_TARGET}/conda" > /dev/null 2>&1
    rm   "/tmp/miniconda${RNG}.sh"

    "${PREFIX_TARGET}/conda/bin/conda" install -y conda-build > /dev/null 2>&1
  fi
}


install() {
  # Installs the conda base system and then the appropriate FEniCS version(s).
  # TODO Revisit this.

  install_conda_base
}


build() {
  # Build a conda package defined in recipes.
  #
  # Usage
  #   build name_of_package python_version_number
  #     [0]             [1]                   [2]
  #
  # Example
  #   build fenics 2.7
  #   build fenics 3.5

  check_internet
  if [ "${?}" != "0" ]; then
    export https_proxy="https://${PROXY_SERVER}:443"
  fi

  check_directory "recipes/${1}"
  if [ "${?}" == "1" ]; then
    echo "ERROR: Recipe for ${1} was not found."
    return 1
  fi

  echo "Building ${1} ..."
  conda_build "${1}"
  conda_build purge
}


conda_build() {
  # Shortcut to the conda build command.
  #
  # Usage
  #   conda_build name_of_recipe

  if [ "${1}" != "purge" ]; then
    "${PREFIX_TARGET}/conda/bin/conda" build "recipes/${1}" -c system -c conda-forge

  else
    "${PREFIX_TARGET}/conda/bin/conda" build purge
  fi
}


build_fenics() {
  # Build the regular FEniCS package collection, for both Python 2.7 and 3.5.
  #
  # Note: The below build order is required.

  conda_build hdf5

  conda_build dijitso
  conda_build ufl
  conda_build fiat
  conda_build ffc
  conda_build instant
  conda_build dolfin
  conda_build mshr

  conda_build fenics

  conda_build purge
}
