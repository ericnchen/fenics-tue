#!/usr/bin/env bash
#
# WIP

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
    echo "Installing conda environment ${TARGET} ... "
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
