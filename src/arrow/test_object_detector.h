#ifndef EXTERNAL_ARROW_ARROW_TEST_OBJECT_DETECTOR_H
#define EXTERNAL_ARROW_ARROW_TEST_OBJECT_DETECTOR_H

#include <vital/algo/image_object_detector.h>

namespace external_arrow {
namespace arrow {

class test_object_detector
  : public kwiver::vital::algorithm_impl< test_object_detector, kwiver::vital::algo::image_object_detector>
{
public:
  test_object_detector();
  virtual ~test_object_detector();

  virtual kwiver::vital::config_block_sptr get_configuration() const;
  virtual void set_configuration(kwiver::vital::config_block_sptr config);
  virtual bool check_configuration(kwiver::vital::config_block_sptr config) const;

  // Main detection method
  virtual kwiver::vital::detected_object_set_sptr detect( kwiver::vital::image_container_sptr image_data) const;

private:
  class priv;
  const std::unique_ptr<priv> d;
};

} } // end namespace

#endif /* EXTERNAL_ARROW_ARROW_OBJECT_DETECTOR_H */
