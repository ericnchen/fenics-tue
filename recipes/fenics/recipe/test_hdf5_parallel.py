# -*- coding: utf-8 -*-
"""
This script tests that HDF5 was compiled to work in parallel.

    mpirun -np 2 python test_hdf5_parallel.py
"""


def test_hdf5_parallel():
    """
    Test that meshes can be exported to HDF5 format in parallel.
    """

    # noinspection PyUnresolvedReferences
    from dolfin import UnitCubeMesh
    mesh = UnitCubeMesh(1, 1, 1)
    comm = mesh.mpi_comm()
    name = 'test_mesh.hdf5'

    # noinspection PyUnresolvedReferences
    from dolfin import HDF5File
    with HDF5File(comm, name, 'w') as f:
        f.write(mesh, 'mesh')

    # Clean up

    # noinspection PyUnresolvedReferences
    from dolfin import MPI
    if MPI.rank(comm) == 0:
        from os import remove
        remove(name)


if __name__ == '__main__':
    test_hdf5_parallel()
