BASE_CFLAGS = -g -pedantic -Wno-unused-function -std=gnu11

LIBSGXDIR = /usr/local/lib

SGX_CFLAGS = $(BASE_CFLAGS) \
             -fno-stack-protector -static -fvisibility=hidden
SGX_LDFLAGS = -static -nostdlib -nostartfiles -Wl,-T,sgx.lds
SGX_LIBS = $(LIBSGXDIR)/sgx-entry.o $(LIBSGXDIR)/libsgx.a \
           $(LIBSGXDIR)/libpolarssl-sgx.a $(LIBSGXDIR)/libc-sgx.a
LDLIBS = -L. -lpolarssl -lelf

CFLAGS := $(BASE_CFLAGS) -fno-stack-protector -fvisibility=hidden

ALL := snake snake_enclave
all: $(ALL)

snake_enclave: snake_enclave.o
	$(CC) $(SGX_LDFLAGS) $< -o $@ $(SGX_LIBS)

snake: snake.o nonEncLib.o
	$(CC) $< -o $@

clean:
	rm -f $(ALL) snake.o snake_enclave.o

