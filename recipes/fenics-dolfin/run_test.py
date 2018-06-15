# -*- coding: utf-8 -*-
"""
Checks that this version of FEniCS/DOLFIN was compiled with parallel HDF5 and
a few extra preconditoners and solvers.
"""

import dolfin as df

assert df.has_hdf5_parallel()

assert df.has_krylov_solver_preconditioner('hypre_amg')
assert df.has_krylov_solver_preconditioner('hypre_euclid')
assert df.has_krylov_solver_preconditioner('hypre_parasails')

assert df.has_lu_solver_method('mumps')

assert df.has_petsc()
assert df.has_petsc4py()
