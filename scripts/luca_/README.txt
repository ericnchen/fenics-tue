README For installing Fenics on the RNG

First you need to extract fenics:    tar -xzf fenics-tue-20170918.tar.gz

Replace the scrips/install_biolab.sh with the one in this folder

Put the miniconda.sh in the home directory

Futhermore go to fenics-tue/external/fenics-feedstock/recipe
Make sure line 10 of build.sh looks as following:
pip install --proxy https://proxy.wfw.wtb.tue.nl:80 --no-deps --no-binary :all: -r "${RECIPE_DIR}/component-requirements.txt"

On the RNG server you need to export the following proxy settings
export https_proxy=https://proxy.wfw.wtb.tue.nl:443
export https_proxy=https://proxy.wfw.wtb.tue.nl:80

Install fenics by going into fenics-tue/scripts/ and run the install_biolab.sh 
(sh sh install_biolab.sh -p $HOME/fenics-2017.1.0)
