# EXTERNAL ARROW

This repository is an example for registering external plugins with kwiver and diva wheel 

## REQUIREMENTS
1. [libgl1-mesa-dev](https://packages.ubuntu.com/search?keywords=libgl1-mesa-dev)
2. [libexpat1-dev](https://packages.ubuntu.com/xenial/libexpat1-dev)
3. [libgtk2.0-dev](https://packages.ubuntu.com/xenial/libgtk2.0-dev)
4. [liblapack-dev](https://packages.ubuntu.com/xenial/liblapack-dev)
5. [libpython3-dev](https://packages.ubuntu.com/xenial/libpython3-dev)
6. [kwiver](https://pypi.org/project/kwiver/)
7. [diva-framework](https://pypi.org/project/diva-framework/)

## INSTALLATION
### EXTERNAL ARROW

    pip install external_arrow

## VERIFYING REGISTRATION

    plugin_explorer --algo image_object_detector
    
    Plugins that implement type "image_object_detector"
    ---------------------
    Info on algorithm type "image_object_detector" implementation "TestObjectDetector"
      Plugin name: TestObjectDetector
            Test to verify if a python algorithm can be registered externally
    ---------------------
    Info on algorithm type "image_object_detector" implementation "external_arrow.arrow.test_object_detector"
      Plugin name: external_arrow.arrow.test_object_detector
            Version: 1.0
            Test to verify if a cpp algorithm can be registered externall
    ---------------------
    Info on algorithm type "image_object_detector" implementation "create_detection_grid"
      Plugin name: create_detection_grid
		    Create a grid of detections across the input image.
    ---------------------
    Info on algorithm type "image_object_detector" implementation "example_detector"
	  Plugin name: example_detector
		    Simple example detector that just creates a user-specified bounding box.
	---------------------
	Info on algorithm type "image_object_detector" implementation "hough_circle"
	  Plugin name: hough_circle
	        Hough circle detector
	---------------------
	Info on algorithm type "image_object_detector" implementation "detect_heat_map"
	  Plugin name: detect_heat_map
		    OCV implementation to create detections from heatmaps
`TestObjectDetector` and `external_arrow.arrow.test_object_detector` are python and c++ arrows registered by external_arrow

 

## REGISTERING ARROW/PROCESSES FROM EXTERNAL PACKAGE
Kwiver uses entrypoints to register vital arrows and sprokit processes.

|Language|Entrypoint|
|:---:|:---:|
|C++|kwiver.cpp_search_paths|
|python|kwiver.python_plugin_registration|

### PYTHON ARROW/PROCESS
The python process and arrows are registered using `kwiver.python_plugin_registration` in setup.py. Every process and arrows in the external package must be registered individually by specifying a unique key-value pair associated with the entrypoint . For example

    'kwiver.python_plugin_registration': 
    [ 'simple_detector=external_arrow.arrow.test_object_detector']
where `external_arrow.arrow.test_object_detector` is python arrow containing `__vital_algorithm_register__`

### C++ ARROW/PROCESS
The c++ process and arrows are registered using `kwiver.cpp_search_paths` in setup.py.  For registering c++ libraries, kwiver requires absolute path to the directory where the c++ libraries are present in the package. For example

    'kwiver.cpp_search_paths':
    ['simple_detector=external_arrow.register_cpp_arrow:get_cpp_path']
  where `external_arrow.register_cpp_arrow:get_cpp_path` is a python function that returns the directory where c++ libraries for `external_arrow` are present in the package.
  
#### Note: Kwiver wheel does not provide the development environment for c++ extension that depend on kwiver. A c++ `arrows` and `sprokit processes` based extension would be built against the static build of [fletch](https://github.com/Kitware/fletch) and [kwiver](https://github.com/Kitware/kwiver). 
