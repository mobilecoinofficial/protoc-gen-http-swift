#!/bin/bash

# Copyright 2020, gRPC Authors All rights reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

set -eu

HERE="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "${HERE}/../test-boilerplate.sh"

function all_at_once {
  echo "[${TEST}]"

  prepare

  protoc \
    --plugin="${PROTOC_GEN_HTTP_SWIFT}" \
    --http-swift_out="${OUTPUT_DIR}" \
    --http-swift_opt=Client=true,Visibility=Public \
    --proto_path="${PROTO_DIR}" \
    -I "${PROTO_DIR}"/api/proto \
    -I "${PROTO_DIR}"/attest/api/proto \
    -I "${PROTO_DIR}"/consensus/api/proto \
    -I "${PROTO_DIR}"/fog/api/proto \
    -I "${PROTO_DIR}"/fog/report/api/proto \
    "${PROTO_DIR}"/*.proto

  validate
}

all_at_once