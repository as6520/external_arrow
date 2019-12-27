# Private docker base image that is used to generate
# manylinux wheel for kwiver
ARG BASE_IMAGE=kwiver-manylinux-python36

FROM ${BASE_IMAGE}

ARG WHEEL_PY_VERSION=cp36-cp36m
ARG REPOSITORY_URL=https://upload.pypi.org/legacy/

RUN cd /kwiver \
    && mkdir -p build/release \
    && cd build/release \
    && cmake ../../ \
       -DCMAKE_BUILD_TYPE=Release \
       -DKWIVER_BUILD_SHARED=OFF \
       -DKWIVER_ENABLE_C_BINDINGS=ON \
       -DKWIVER_ENABLE_PYTHON=ON \
       -DKWIVER_PYTHON_MAJOR_VERSION=3 \
       -DPYBIND11_PYTHON_VERSION=3 \
       -DCMAKE_BUILD_WITH_INSTALL_RPATH=ON \
       -DKWIVER_ENABLE_SPROKIT=ON \
       -DKWIVER_ENABLE_ARROWS=ON \
       -DKWIVER_ENABLE_PROCESSES=ON \
       -DKWIVER_ENABLE_TOOLS=ON \
       -DKWIVER_ENABLE_LOG4CPLUS=ON \
       -DKWIVER_INSTALL_SET_UP_SCRIPT=OFF \
       -DKWIVER_ENABLE_OPENCV=ON \
       -DKWIVER_ENABLE_FFMPEG=ON \
       -DKWIVER_ENABLE_ZeroMQ=ON \
       -DKWIVER_ENABLE_SERIALIZE_JSON=ON \
       -DKWIVER_ENABLE_SERIALIZE_PROTOBUF=ON \
       -Dfletch_DIR=/fletch/build/release \
   && make -j$(nproc)

COPY . /external_arrow
RUN cd /external_arrow \
    && pip3 install -U setuptools \
    && rm -rf _skbuild external_arrow.egg-info dist \
    && python3 setup.py bdist_wheel -- -Dfletch_DIR=/fletch/build/release \
                                      -Dkwiver_DIR=/kwiver/build/release \
                                   -- -j$(nproc) \
    && rm -rf _skbuild external_arrow.egg-info \
    && yum install -y zip

RUN cd /external_arrow \
    && export VERSION=$(cat VERSION) \
    && cd dist \
    && export LD_LIBRARY_PATH=/kwiver/build/release/lib:$LD_LIBRARY_PATH \
    && export WHEEL_PREFIX=external_arrow-${VERSION}-${WHEEL_PY_VERSION} \
    && auditwheel repair --plat manylinux2014_x86_64 ${WHEEL_PREFIX}-linux_x86_64.whl -w . \
    && unzip ${WHEEL_PREFIX}-manylinux2014_x86_64.whl \
    && echo "Removing ${WHEEL_PREFIX}-manylinux2014_x86_64.whl" \
    && rm -rf ${WHEEL_PREFIX}-manylinux2014_x86_64.whl \
    && echo $(basename external_arrow/.libs/libvital_vpm*.so*) \
    && patchelf --replace-needed  \
           $(basename external_arrow/.libs/libvital_vpm*.so*) \
           libvital_vpm.so.1.4.0 \
           external_arrow/lib/cpp_arrow/test_object_detector.so \
    && patchelf --replace-needed  \
          $(basename external_arrow/.libs/libvital_algo*.so*) \
          libvital_algo.so.1.4.0 \
          external_arrow/lib/cpp_arrow/test_object_detector.so \
    && rm external_arrow/.libs/libvital_algo* \
    && rm external_arrow/.libs/libvital_vpm* \
    && sed -i '/^external_arrow\/\.libs\/libvital_vpm/d' \
           external_arrow-${VERSION}.dist-info/RECORD \
    && sed -i '/^external_arrow\/\.libs\/libvital_algo/d' \
           external_arrow-${VERSION}.dist-info/RECORD \
    && zip -r ${WHEEL_PREFIX}-manylinux2014_x86_64.whl \
              external_arrow \
              external_arrow-${VERSION}.dist-info \
    && pip3 install ${WHEEL_PREFIX}-manylinux2014_x86_64.whl

RUN plugin_explorer --algo image_object_detector

ENV TWINE_REPOSITORY_URL=${REPOSITORY_URL}

ENTRYPOINT twine upload /external_arrow/dist/external_arrow*-manylinux2014_x86_64.whl
