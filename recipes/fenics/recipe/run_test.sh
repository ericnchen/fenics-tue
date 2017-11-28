#!/usr/bin/env bash

"${PREFIX}/bin/mpirun" -np 2 "${PYTHON}" test_hdf5_parallel.py
