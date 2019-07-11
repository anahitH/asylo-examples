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
	oeedger8r ../snake.edl --untrusted
	$(CC) -g -c $(CFLAGS) snake.c
	$(CC) -g -c $(CFLAGS) snake_u.c
	$(CC) -o snakehost snake_u.o snake.o $(LDFLAGS)

clean:
	rm -f snakehost snake.o snake_u.o snake_u.c snake_u.h snake_args.h
