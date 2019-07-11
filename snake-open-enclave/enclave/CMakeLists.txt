# Copyright (c) Microsoft Corporation. All rights reserved.
# Licensed under the MIT License.

# Use the edger8r to generate C bindings from the EDL file.
add_custom_command(OUTPUT snake_t.h snake_t.c snake_args.h
  DEPENDS ${CMAKE_SOURCE_DIR}/snake.edl
  COMMAND openenclave::oeedger8r --trusted ${CMAKE_SOURCE_DIR}/snake.edl)

add_executable(enclave enc.c ${CMAKE_CURRENT_BINARY_DIR}/snake_t.c)

target_compile_definitions(enclave PUBLIC OE_API_VERSION=2)

# Need for the generated file snake_t.h
target_include_directories(enclave PRIVATE ${CMAKE_CURRENT_BINARY_DIR})

target_link_libraries(enclave openenclave::oeenclave openenclave::oelibc)
