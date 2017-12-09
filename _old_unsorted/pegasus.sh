#!/usr/bin/env bash

# This folder must have the following folders: dolfin-hpc, unicorn-hpc
WORK_DIR="${HOME}/software/pegasus"

build_install_dolfin_hpc () {
  # Add the UFC pkgconfig file path to PKG_CONFIG_PATH so that it can be discovered.
  export PKG_CONFIG_PATH="$(find ${HOME}/.local -name ufc-1.pc -exec dirname {} \;)"
  cd "${WORK_DIR}/dolfin-hpc"
  ./regen.sh
  # DISABLE THE PROGRESS BAR OR IT WILL BREAK!!!
  # DISABLE THE PROGRESS BAR OR IT WILL BREAK!!!
  # DISABLE THE PROGRESS BAR OR IT WILL BREAK!!!
  # DISABLE THE PROGRESS BAR OR IT WILL BREAK!!!
  # DISABLE THE PROGRESS BAR OR IT WILL BREAK!!!
  # DISABLE THE PROGRESS BAR OR IT WILL BREAK!!!
  # DISABLE THE PROGRESS BAR OR IT WILL BREAK!!!
  ./configure \
    --prefix="${HOME}/.local/dolfin-hpc" \
    --disable-progress-bar \
    --enable-mpi \
    --enable-mpi-io \
    --with-gts \
    --with-parmetis \
    --with-petsc="$(pkg-config --variable prefix PETSc)"
  # PETSC_DIR should be /usr/lib/petscdir/3.7.3/x86_64-linux-gnu-real but the above does it automatically.
  make
  make check
  make install
}

fix_dolfin_pkgconfig () {
  # The unicorn-hpc configuration files explicitly looks for dolfin-hpc 0.8.3-hpc.
  # The problem is that the version of dolfin-hpc installed is 0.8.4-hpc.
  # Use sed again to edit the dolfin.pc file to say 0.8.3-hpc.
  # The file is in $HOME/.local/dolfin-hpc/pkgconfig and could be edited manually too.
  sed -i "s|0.8.4-hpc|0.8.3-hpc|g" "$(find ${HOME}/.local -name dolfin.pc)"
}

build_install_unicorn_hpc () {
  # The ufc-1.pc and dolfin.pc files needs to be temporarily added to PKG_CONFIG_PATH.
  PKG_CONFIG_PATH="$(find ${HOME}/.local -name dolfin.pc -exec dirname {} \;)"
  PKG_CONFIG_PATH="$(find ${HOME}/.local -name ufc-1.pc -exec dirname {} \;):${PKG_CONFIG_PATH}"
  export PKG_CONFIG_PATH
  cd "${WORK_DIR}/unicorn-hpc"
  ./regen.sh
  # Explicitly set CC and CXX to the MPI variants.
  CC=mpicc CXX=mpicxx ./configure \
    --prefix="${HOME}/.local/unicorn-hpc"
  make
  make check
  make install
}

create_environment_variables () {
  # This will create a file called "source_me.sh" that has PKG_CONFIG_PATH properly set.
  # It could be moved or renamed, but must be sourced before compiling anything in the future.
  # Source it with "source filename" or ". filename".
  UFC_PC_DIR="$(find ${HOME}/.local -name ufc-1.pc -exec dirname {} \;)"
  DOLFIN_PC_DIR="$(find ${HOME}/.local -name dolfin.pc -exec dirname {} \;)"
  UNICORN_PC_DIR="$(find ${HOME}/.local -name unicorn.pc -exec dirname {} \;)"
  MY_PKG_CONFIG_PATH="${UFC_PC_DIR}:${DOLFIN_PC_DIR}:${UNICORN_PC_DIR}"
  # Create the file.
  echo '#!/usr/bin/env bash' > "${WORK_DIR}/source_me.sh"
  echo "export PKG_CONFIG_PATH=${MY_PKG_CONFIG_PATH}:${PKG_CONFIG_PATH}" >> "${WORK_DIR}/source_me.sh"
}

run_unicorn_testcase () {
  # This test case runs the cube example as described on the repository.
  # It runs fine for me but it didn't converge because of the iterative solver.
  # I think that's just a parameter setting and not with the installation.

  # Source the environment variable before compiling.
  # In scripts should use "." and not "source".
  . "${WORK_DIR}/source_me.sh"
  cd "${WORK_DIR}/unicorn-hpc/ucsolver/icns/cube"
  # Clean any left over files and recompile.
  make clean
  make
  # Run the test case.
  mpirun -np 4 cube -p parameters -m mesh.xml
}

#build_install_dolfin_hpc
#fix_dolfin_pkgconfig
#build_install_unicorn_hpc
#create_environment_variables
#run_unicorn_testcase
