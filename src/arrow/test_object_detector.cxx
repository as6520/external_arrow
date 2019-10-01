#include "test_object_detector.h"
#include <vector>
#include <kwiversys/SystemTools.hxx>
#include <iostream>

namespace external_arrow {
namespace arrow {

// ----------------------------------------------------------------
class test_object_detector::priv
{
public:
  // -- CONSTRUCTORS --
  priv(){}

  ~priv(){}


  bool check_config(kwiver::vital::config_block_sptr const &config,
                    kwiver::vital::logger_handle_t const &logger) const
  {
    return true;
  }

  std::string m_detector_name = "TestObjectDetector";
}; // end class test_object_detector::priv

// ==================================================================
test_object_detector::test_object_detector(): d( new priv ){ }

test_object_detector::~test_object_detector(){ }

// ------------------------------------------------------------------
kwiver::vital::config_block_sptr
test_object_detector::
get_configuration() const {
  kwiver::vital::config_block_sptr config = kwiver::vital::algorithm::get_configuration();
  return config;
}

// ------------------------------------------------------------------
void
test_object_detector::
set_configuration(kwiver::vital::config_block_sptr in_config)

{
  kwiver::vital::config_block_sptr config = this->get_configuration();
  config->merge_config(in_config);
}

// ------------------------------------------------------------------
bool test_object_detector::
check_configuration(kwiver::vital::config_block_sptr in_config) const
{
  return  true;
}

// ------------------------------------------------------------------
kwiver::vital::detected_object_set_sptr
test_object_detector::
detect( kwiver::vital::image_container_sptr image_data) const
{
  auto detected_set = std::make_shared< kwiver::vital::detected_object_set>();
  return detected_set;
}

} } // end namespace

