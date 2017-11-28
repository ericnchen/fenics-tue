# -*- coding: utf-8 -*-


def test_hdf5_is_parallel():
    from dolfin import HDF5File, UnitCubeMesh, mpi_comm_world
    mesh = UnitCubeMesh(1, 1, 1)
    with HDF5File(mpi_comm_world(), '/tmp/mesh.hdf5', 'w') as f:
        f.write(mesh, 'mesh')


if __name__ == '__main__':
    test_hdf5_is_parallel()
