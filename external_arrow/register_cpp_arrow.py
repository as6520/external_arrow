import os
import external_arrow

def get_cpp_path():
    module_path = os.path.dirname(os.path.abspath(external_arrow.__file__))
    cpp_path = os.path.join(module_path, 'lib', 'cpp_arrow')
    return cpp_path

