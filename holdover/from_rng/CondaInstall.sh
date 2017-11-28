#!/usr/bin/env bash

WORKDIR="$(pwd)"
INSTALLDIR="${HOME}/.local/opt"

if [[ ! -d "${INSTALLDIR}" ]]; then
    mkdir -p "${INSTALLDIR}"
fi

module purge
module load /share/apps/modules/gcc49 /share/apps/modules/openmpi2gcc49

install_conda () {
    bash "${WORKDIR}/external_downloads/Miniconda3-latest-Linux-x86_64.sh" -b -p "${INSTALLDIR}/miniconda3"
    "${INSTALLDIR}/miniconda3/bin/conda" create -n intel --offline --no-default-packages -y
    find "${WORKDIR}/conda_packages" -name *.tar.* | xargs -I{} "${INSTALLDIR}/miniconda3/bin/conda" install -y {} --no-deps -n intel --verbose
}

#install_conda
