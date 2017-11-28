# -*- coding: utf-8 -*-


def test_install_prefix_strips_trailing_slash():
    from install import InstallationOptions

    options1 = InstallationOptions()
    options1.install_prefix = '/opt'
    assert not options1.install_prefix.endswith('/')

    options2 = InstallationOptions()
    options2.install_prefix = '/opt/'
    assert not options2.install_prefix.endswith('/')

    assert options1.install_directory() == options2.install_directory()


def test_install_folder_strips_slashes():
    from install import InstallationOptions

    options1 = InstallationOptions()
    options1.install_folder = 'fenics-test'
    assert not options1.install_folder.startswith('/')

    options2 = InstallationOptions()
    options2.install_folder = '/fenics-test'
    assert not options2.install_folder.startswith('/')

    options3 = InstallationOptions()
    options3.install_folder = 'fenics-test/'
    assert not options3.install_folder.endswith('/')

    assert options1.install_directory() == options2.install_directory()
    assert options1.install_directory() == options3.install_directory()


def test_split_local_path():
    import os
    from install import split_path

    prefix, folder = split_path('folder')

    assert prefix == os.getcwd()
    assert folder == 'folder'


def test_split_full_path():
    from install import split_path

    prefix, folder = split_path('/full_path/to/folder')

    assert prefix == '/full_path/to'
    assert folder == 'folder'


def test_split_sub_local_path():
    import os
    from install import split_path

    prefix, folder = split_path('local_path/to/folder')

    assert prefix == '/'.join((os.getcwd(), 'local_path/to'))
    assert folder == 'folder'
