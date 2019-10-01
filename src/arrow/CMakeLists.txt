link_directories("${KWIVER_LIBRARY_DIRS}")

set( sources
  register_test_object_detector.cxx
  test_object_detector.cxx
  )

set( headers
  test_object_detector.h
  )

include_directories( SYSTEM ${KWIVER_INCLUDE_DIRS} )
include_directories( ${CMAKE_CURRENT_SOURCE_DIR} ${CMAKE_CURRENT_BINARY_DIR} )

###
# Create the  Face Detection Plugin
kwiver_add_plugin( test_object_detector
  SUBDIR       "cpp_arrow"
  SOURCES      ${sources} ${headers}
  PRIVATE      ${KWIVER_LIBRARIES}
)

