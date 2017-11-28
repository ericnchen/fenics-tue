#!/usr/bin/env bash

alias con="${HOME}/testing-fenics-tue/conda/bin/conda"
con create -n og -c conda-forge python=3.5 fenics=2017.1

export act="${HOME}/testing-fenics-tue/conda/bin/activate"
source $act og