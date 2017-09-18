fenics-tue
==========
Conda based development and simulation environment for FEniCS.

Requirements
------------
* gcc 4.8+
* git
* patch
* wget

Download
--------
From an internet connected computer::

   git clone https://github.com/ericnchen/fenics-tue.git
   cd fenics-tue
   git submodule update --init --recursive

Install
-------
From an internet connected computer and after the **Download** step is done::

   cd scripts
   sh install_biolab.sh -p /path/to/install/dir

One Line Install
----------------
Copy, paste, and run the following (should be one line)::

   git clone https://github.com/ericnchen/fenics-tue.git && cd fenics-tue && git submodule update --init --recursive && cd scripts && sh install_biolab.sh

This will install to HOME/fenics-tue by default. Append ``-p /path/to/install/dir`` to the end of the line to install elsewhere, like so::

   git clone https://github.com/ericnchen/fenics-tue.git && cd fenics-tue && git submodule update --init --recursive && cd scripts && sh install_biolab.sh -p $HOME/my_dir

Use
---
Add the following to your ``.profile`` or ``.bashrc``::

   export PATH=/path/to/install/bin:$PATH

Replace the path with where you installed it, but leave the ``bin`` part at the end.

By default, it would be::

   export PATH=$HOME/fenics-tue/bin:$PATH
