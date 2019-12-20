from skbuild import setup
import os.path as osp

with open('VERSION', 'r') as f:
    version = f.read().strip()

with open('README.md', 'r') as f:
    long_description = f.read().strip()

setup( name='external_arrow',
       version=version,
       long_description=long_description,
       packages=[ 'external_arrow',
                  'external_arrow.arrow',
                ],
       platforms=[
                    'linux',
                    'Unix'
                 ],
       setup_requires=[
                        'setuptools',
                        'cmake',
                        'scikit-build'
                      ],
       install_requires=[
                            'kwiver==1.4.2',
                        ],
       cmake_args=[
                    '-DCMAKE_BUILD_TYPE=Release',
                    '-DENABLE_CPP_ARROW=ON',
                    '-DKWIVER_PYTHON_MAJOR_VERSION=3',
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
                        "Intended Audience :: Developers",
                        "Programming Language :: Python :: 3.5",
                        "Programming Language :: Python :: 3.6",
                        "Programming Language :: Python :: 3.7",
                        "Programming Language :: Python :: 3.8",
                        "Operating System :: Unix",
                        "License :: OSI Approved :: BSD License"
                   ],
       python_requires=">=3.5",
    )
