from skbuild import setup
import os.path as osp

fletch_root = osp.join('/mnt','usb1', 'ashringi', 'pypi', 'fletch', 'build', 'release-static')
kwiver_root = osp.join('/mnt','usb1', 'ashringi', 'pypi', 'kwiver', 'build', 'release')

setup( name='external_arrow',
       version='0.0.1',
       packages=[ 'external_arrow',
                  'external_arrow.arrow',
                ],
       setup_requires=[
                        'setuptools',
                      ],
       install_requires=[
                            'kwiver',
                        ],
       cmake_args=[
                    '-DCMAKE_BUILD_TYPE=Release',
                    '-DENABLE_CPP_ARROW=ON',
                    '-DKWIVER_PYTHON_MAJOR_VERSION=3',
                    '-Dfletch_DIR={0}'.format(fletch_root),
                    '-Dkwiver_DIR={0}'.format(kwiver_root)
                  ],
       cmake_install_dir='external_arrow',
       entry_points={
                'kwiver.python_plugin_registration':
                    [
                        'simple_detector=external_arrow.arrow.test_object_detector',
                    ],
                'kwiver.cpp_search_paths':
                    [
                        'simple_detector=external_arrow.register_cpp_arrow:get_cpp_path',
                    ]
                },
       classifiers=[
                        "Development Status :: 3 - Alpha",
                        "Topics :: Test",
                   ]
    )
