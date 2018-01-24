#!/usr/bin/env bash
set -e

TOKEN=$1
RECIPE=$2

docker run \
  -v $(pwd)/recipes:/home/builder/recipes \
  --rm \
  fenics-tue:builder \
  /anaconda/bin/conda build \
    --channel tue \
    --skip-existing \
    --token $TOKEN \
    $RECIPE
