#
# Copyright 2018 Asylo authors
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
#

licenses(["notice"])  # Apache v2.0

package(
    default_visibility = ["//visibility:public"],
)

load("//asylo/bazel:copts.bzl", "ASYLO_DEFAULT_COPTS")
load(
    "//asylo/bazel:asylo.bzl",
    "sim_enclave_loader",
    "sim_enclave_test",
)
load(
    "//asylo/bazel:sim_enclave.bzl",
    "sim_enclave",
)

sim_enclave(
    name = "snake_enclave.so",
    srcs = [
        "snake_enclave.cc",
        "snake_enclave_lib.cc",
        "interface_selectors.h",
        "snake.h",
        "enclave_conio.h",
    ],
    copts = ASYLO_DEFAULT_COPTS,
    deps = [
        "//asylo/platform/primitives",
        "//asylo/util:status_macros",
    ],
)

sim_enclave_loader(
    name = "snake_driver",
    srcs = [
        "app_driver.cc",
        "snake.cc",
        "interface_selectors.h",
        "snake.h",
        "conio.h",
    ],
    copts = ASYLO_DEFAULT_COPTS,
    enclaves = {"snake": ":snake_enclave.so"},
    deps = [
        "//asylo/platform/primitives",
        "//asylo/platform/primitives:untrusted_primitives",
        "//asylo/platform/primitives/sim:untrusted_sim",
        "//asylo/platform/primitives/util:dispatch_table",
        "//asylo/util:status",
        "//asylo/util:status_macros",
        "@com_github_gflags_gflags//:gflags_nothreads",
    ],
)

