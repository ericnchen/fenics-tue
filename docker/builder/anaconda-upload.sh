#!/usr/bin/env bash
set -e

if [[ -z "${1}" ]]; then
  echo "Error: No Anaconda token specified."
  exit 1
fi

if [[ -z "${2}" ]]; then
  echo "Error: No compiled archive package specified."
  exit 1
fi

/anaconda/bin/anaconda -t "${1}" upload "${2}"
