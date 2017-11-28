# -*- coding: utf-8 -*-
"""
This script tests that HDF5 was compiled to work in parallel.

    mpirun -np 2 python tests/test_hdf5_parallel.py
"""


def test_hdf5_parallel():
    from random import randint
    suffix = ''.join((str(randint(1, 1000)), str(randint(1, 1000))))
    filename = '/tmp/mesh{}.hdf5'.format(suffix)

    # noinspection PyUnresolvedReferences
    from dolfin import UnitCubeMesh
    mesh = UnitCubeMesh(1, 1, 1)

    # noinspection PyUnresolvedReferences
    from dolfin import HDF5File
    with HDF5File(mesh.mpi_comm(), filename, 'w') as f:
        f.write(mesh, 'mesh')

    from os import remove
    remove(filename)


if __name__ == '__main__':
    test_hdf5_parallel()
