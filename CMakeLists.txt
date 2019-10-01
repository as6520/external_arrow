cmake_minimum_required(VERSION 3.3)
find_package(fletch REQUIRED)
find_package(kwiver REQUIRED)

include(kwiver-utils)
include(kwiver-configcheck)
include(kwiver-flags)

option( ENABLE_CPP_ARROW "ENABLE C++ ARROW" OFF )

if (${ENABLE_CPP_ARROW} )
  add_subdirectory(src)
endif()

