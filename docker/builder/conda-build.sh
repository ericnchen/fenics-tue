#!/usr/bin/env bash
set -e
/anaconda/bin/conda build -c tue "${@}"
