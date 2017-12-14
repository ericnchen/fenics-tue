#!/bin/bash
#
# Download and install the Anaconda Python distribution and build tools.

PREFIX="${HOME}/fenics-tue"
CONDA_DIR="${PREFIX}/conda"

FN="/tmp/miniconda${RANDOM}${RANDOM}.sh"
URL='https://repo.continuum.io/miniconda/Miniconda3-4.3.30-Linux-x86_64.sh'
MD5='0b80a152332a4ce5250f3c09589c7a81'

bash check_internet.sh
if [ "${?}" != "0" ]; then
  if [ "$(hostname -s)" == "rng" ] || [ "$(hostname -s)" == "furnace" ]; then
    export https_proxy="https://proxy.wfw.wtb.tue.nl:443"
  else
    echo "No internet connectivity available."
    exit 1
  fi
fi

wget -q -O "${FN}" "${URL}"
if [ "$(md5sum ${FN} | awk '{ print $1 }')" != "${MD5}" ]; then
  echo "The Anaconda installation file downloaded from ${URL} was corrupted."
  echo "Try running this script again."
  exit 1
fi

# Install conda.
bash "${FN}" -b -p "${CONDA_DIR}" && "${CONDA_DIR}/bin/conda" install -y conda-build && rm "${FN}"

# Link the default ${CONDA_DIR}/bin directory to ${PREFIX}/bin.
ln -s "${CONDA_DIR}/bin/" "${PREFIX}/bin"
