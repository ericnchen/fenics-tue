#!/usr/bin/env bash

(cd dijitso && "${PYTHON}" setup.py install)
(cd ufl     && "${PYTHON}" setup.py install)
(cd instant && "${PYTHON}" setup.py install)
(cd fiat    && "${PYTHON}" setup.py install)
(cd ffc     && "${PYTHON}" setup.py install)
