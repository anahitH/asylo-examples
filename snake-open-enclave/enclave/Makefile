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

CFLAGS=$(shell pkg-config oeenclave-$(COMPILER) --cflags)
LDFLAGS=$(shell pkg-config oeenclave-$(COMPILER) --libs)

all:
	$(MAKE) build
	$(MAKE) keys
	$(MAKE) sign

build:
	@ echo "Compilers used: $(CC), $(CXX)"
	oeedger8r ../snake.edl --trusted
	$(CC) -g -c $(CFLAGS) -DOE_API_VERSION=2 snake_enclave.c -o snake_enclave.o
	$(CC) -g -c $(CFLAGS) -DOE_API_VERSION=2 snake_t.c -o snake_t.o
	$(CC) -o snakeenc snake_t.o snake_enclave.o $(LDFLAGS)

sign:
	oesign sign -e snakeenc -c snake.conf -k private.pem

clean:
	rm -f snake_enclave.o snakeenc snakeenc.signed private.pem public.pem snake_t.o snake_t.h snake_t.c snake_args.h

keys:
	openssl genrsa -out private.pem -3 3072
	openssl rsa -in private.pem -pubout -out public.pem
