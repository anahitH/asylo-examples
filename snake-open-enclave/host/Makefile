# Copyright (c) Microsoft Corporation. All rights reserved.
# Licensed under the MIT License.

# Detect C and C++ compiler options
# if not gcc, default to clang-7

COMPILER=$(notdir $(CC))
ifeq ($(COMPILER), gcc)
        USE_GCC = true
endif

ifeq ($(USE_GCC),)
        CC = clang-7
        COMPILER=clang
endif

CFLAGS=$(shell pkg-config oehost-$(COMPILER) --cflags)
LDFLAGS=$(shell pkg-config oehost-$(COMPILER) --libs)

build:
	@ echo "Compilers used: $(CC), $(CXX)"
	oeedger8r ../sgx.edl --untrusted
	$(CC) -g -c $(CFLAGS) snake_app.cc
	$(CC) -g -c $(CFLAGS) sgx_u.c
	$(CC) -o snakehost sgx_u.o app_lib.o snake_app.o $(LDFLAGS)

clean:
	rm -f snakehost snake.o sgx_u.o sgx_u.c sgx_u.h sgx_args.h
