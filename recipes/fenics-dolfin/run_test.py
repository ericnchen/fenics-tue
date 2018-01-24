# -*- coding: utf-8 -*-
"""
Checks that this version of FEniCS/DOLFIN was compiled with parallel HDF5 and
a few extra preconditoners and solvers.
"""

from dolfin import (
    has_hdf5_parallel,
    has_krylov_solver_preconditioner,
    has_lu_solver_method,
    has_petsc
)

assert has_hdf5_parallel()

assert has_krylov_solver_preconditioner('hypre_amg')
assert has_krylov_solver_preconditioner('hypre_euclid')
assert has_krylov_solver_preconditioner('hypre_parasails')

assert has_lu_solver_method('mumps')

assert has_petsc()
