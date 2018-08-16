#!/bin/bash

set -e

export ANDROID_NDK=${HOME}/android-ndk
export NE10_ANDROID_TARGET_ARCH=${ARCH:-armv7}
BUILD_DEBUG=${DEBUG:-0}

TEST_TYPES="
  smoke \
  regression \
  performance
"
for test_type in ${TEST_TYPES}; do
  rm -rf build && mkdir build && pushd build
  cmake \
    -DCMAKE_TOOLCHAIN_FILE=../android/android_config.cmake \
    -DBUILD_DEBUG=${BUILD_DEBUG} \
    -DNE10_TEST_NAME=${test_type} \
    ..
  VERBOSE=1 make -j8
  popd
done
