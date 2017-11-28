# -*- coding: utf-8 -*-
"""
WIP

This script should do the following:

1. Check if conda is already installed.
    a. If not installed, then install it to the designated path (ask later).
    b. If it is installed, check if it needs to be updated.
        a. If it needs to be updated, ask for permission?
2. Ask for a root/base installation path for conda and later FEniCS.
    a. By default, it should be ``${HOME}/fenics``.
    b. By default, conda would install to ``${HOME}/fenics/conda``.
    c. By default, FEniCS should install to ``${HOME}/fenics/fenics-2017`` etc.
    d. This root/base path can be overwritten by user.
3. Ask for other configuration options.
4. Create a bash script that will execute and do the compiling/installing.
5. Ask for confirmation before installing.
"""
import os


class InstallationOptions(object):
    def __init__(self):
        self._install_prefix = os.path.expanduser('~')
        self._install_folder = 'fenics'

    @property
    def install_prefix(self):
        return self._install_prefix

    @install_prefix.setter
    def install_prefix(self, val):
        self._install_prefix = val if not val.endswith('/') else val[:-1]

    @property
    def install_folder(self):
        return self._install_folder

    @install_folder.setter
    def install_folder(self, val):
        val = val if not val.endswith('/') else val[:-1]
        val = val if not val.startswith('/') else val[1:]
        self._install_folder = val
        # if not val.startswith('/') else val[1:]

    def install_directory(self):
        return '/'.join((self.install_prefix, self.install_folder))

    def confirm_install_directory(self):
        msg = 'Enter the full base install directory [{}]: '
        val = raw_input(msg.format(self.install_directory()))

        if val != '':
            self.install_prefix, self.install_folder = split_path(val)

        print(self.install_prefix)
        print(self.install_folder)
        print(self.install_directory())

        # tmp = raw_input('test [default]')


def split_path(path):
    prefix = '/'.join(path.split('/')[:-1])
    folder = path.split('/')[-1]

    # only a local (e.g., `fenics-tue`) path was given --> use cwd
    if prefix == '':
        prefix = os.getcwd()

    # a sublocal (e.g., `prefix/fenics-tue`) path was given --> prepend cwd
    elif not prefix.startswith('/'):
        prefix = '/'.join((os.getcwd(), prefix))

    return prefix, folder


def main():
    options = InstallationOptions()

    options.confirm_install_directory()
    # Do something here to ask user for installation path override.

    # print('The full installation directory is: {}'.format(
    #     options.install_directory()))


if __name__ == '__main__':
    main()
