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