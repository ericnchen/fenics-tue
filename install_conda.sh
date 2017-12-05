#!/bin/bash
#
# Download and install the Anaconda Python distribution and build tools.

PREFIX="${HOME}/fenics-tue/conda"

FN="/tmp/miniconda${RANDOM}${RANDOM}.sh"
URL='https://repo.continuum.io/miniconda/Miniconda3-4.3.30-Linux-x86_64.sh'
MD5='0b80a152332a4ce5250f3c09589c7a81'

wget -q -O "${FN}" "${URL}"
if [ "$(md5sum ${FN} | awk '{ print $1 }')" != "${MD5}" ]; then
  echo "The Anaconda installation file downloaded from ${URL} was corrupted."
  echo "Try running this script again."
  exit 1
fi

bash "${FN}" -b -p "${PREFIX}" && "${PREFIX}/bin/conda" install -y conda-build
rm "${FN}"
