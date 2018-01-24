fenics-tue
==========
Conda based development and simulation environment for FEniCS.

Installation
------------
First, install the Anaconda Python distribution and package manager::

   $ curl -o Miniconda3.sh https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh && bash Miniconda3.sh

It should ask you a few simple questions.

Next, install our custom build of FEniCS, which has been uploaded to the ``tue``
channel on Anaconda Cloud::

   $ conda create -n fenics -c tue python=3.5 fenics

Let's break down the arguments. This first part::

   conda create -n fenics

Instructs the ``conda`` package manager to ``create`` a new environment named
``fenics``. You can have multiple environments (e.g., one for each project/simulation),
and you can name them anything you want.

Moving on::

   -c tue

This part tells ``conda`` to look for (prefer) packages in our ``tue`` channel.
This part is absolutely vital. Without it, ``conda`` will at best not be able
to download ``fenics``, and at worse will download ``fenics`` from the ``conda-forge``
repository.

Finally::

   python=3.5 fenics=2017.1.0

This part tells ``conda`` to install Python 3.5, and FEniCS 2017.1.0. Currently,
Python 2.7 (``python=2.7``) would work as well, but no other versions of Python
will (should) work.

Details
-------
These are just building notes that I haven't organized yet::

   # python -> fenics-dijitso
   # python -> fenics-ufl
   # python -> fenics-instant
   # python -> fenics-fiat
   
   # python -> [fenics-ufl, fenics-fiat] -> fenics-ffc
   # python -> [fenics-dijitso, fenics-ufl, fenics-instant, fenics-fiat, fenics-ffc] -> fenics-dolfin
   # python -> [fenics-dijitso, fenics-ufl, fenics-instant, fenics-fiat, fenics-ffc, fenics-dolfin] -> fenics-mshr
   
   # openmpi
   
   # openmpi -> blacs
   # openmpi -> hdf5
   # openmpi -> hypre
   # openmpi -> scotch
   
   # openmpi -> blacs -> scalapack
   
   # openmpi -> [blacs, blacs, scotch, scalapack] -> mumps
   
   # openmpi -> [blacs, scalapack, scotch, mumps, hdf5, hypre, suitesparse] -> petsc
