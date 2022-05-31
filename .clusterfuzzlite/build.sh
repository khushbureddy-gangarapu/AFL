#!/bin/bash -eu
# Copyright 2020 Google Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
################################################################################

# Build and install project (using current CFLAGS, CXXFLAGS).

#!/bin/bash -eu

./buildconf.sh
# configure scripts usually use correct environment variables.
./configure

make clean
make -j$(nproc) all

$CXX $CXXFLAGS -std=c++11 -Ilib/ \
    $SRC/imgRead.c -o $OUT/imgRead \
    $LIB_FUZZING_ENGINE .libs/libFuzzingEngine.a
