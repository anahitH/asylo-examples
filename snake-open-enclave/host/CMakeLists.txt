# Copyright (c) Microsoft Corporation. All rights reserved.
# Licensed under the MIT License.

add_custom_command(OUTPUT snake_u.h snake_u.c snake_args.h
  DEPENDS ${CMAKE_SOURCE_DIR}/snake.edl
  COMMAND openenclave::oeedger8r --untrusted ${CMAKE_SOURCE_DIR}/snake.edl)

add_executable(snake_host host.c ${CMAKE_CURRENT_BINARY_DIR}/snake_u.c)

target_include_directories(snake_host PRIVATE
  # Needed for the generated file snake_u.h
  ${CMAKE_CURRENT_BINARY_DIR})

target_link_libraries(snake_host openenclave::oehostapp)
