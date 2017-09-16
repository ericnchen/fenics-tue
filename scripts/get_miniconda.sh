#!/usr/bin/env bash

miniconda_install_path="${HOME}/miniconda3"

install_miniconda() {
  wget -O /tmp/miniconda.sh https://repo.continuum.io/miniconda/Miniconda3-4.3.21-Linux-x86_64.sh && \
    sh /tmp/miniconda.sh -b -p "${miniconda_install_path}" && \
    rm -rf /tmp/miniconda.sh
}

if [ ! -d "${miniconda_install_path}" ]; then
  install_miniconda
fi

# vvv testing vvv
export PATH="${miniconda_install_path}/bin:${PATH}"

conda install -c conda-forge -y \
    gcc==4.8.5 \
    libgcc==4.8.5

#conda install -c conda-forge -y fenics

echo ""
echo "export PATH=${miniconda_install_path}/bin:${PATH}"
echo ""
