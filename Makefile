
# BIKE reference and optimized implementations assume that OpenSSL and NTL libraries are available in the platform.

# To compile this code for NIST KAT routine use: make bike-nist-kat
# To compile this code for demo tests use: make bike-demo-test

# TO EDIT PARAMETERS AND SELECT THE BIKE VARIANT: please edit defs.h file in the indicated sections.

# The file measurements.h controls how the cycles are counted. Note that #define REPEAT is initially set to 100,
# which means that every keygen, encaps and decaps is repeated 100 times and the number of cycles is averaged.

# Verbose levels: 0, 1, 2 or 3
VERBOSE=0

CC:=g++
CFLAGS:=-m64 -O3

SRC:=*.c ntl.cpp FromNIST/rng.c
INCLUDE:=-I. -I$(OpenSSL)/include -L$(OpenSSL)/lib -std=c++11 -lcrypto -lssl -lm -ldl -lntl -lgmp -lpthread

all: bike-nist-kat

bike-demo-test: $(SRC) *.h tests/test.c
	$(CC) $(CFLAGS) tests/test.c $(SRC) $(INCLUDE) -DVERBOSE=$(VERBOSE) -DNIST_RAND=1 -o $@

bike-nist-kat: $(SRC) *.h FromNIST/*.h FromNIST/PQCgenKAT_kem.c
	$(CC) $(CFLAGS) FromNIST/PQCgenKAT_kem.c $(SRC) $(INCLUDE) -DVERBOSE=$(VERBOSE) -DNIST_RAND=1 -o $@

bike-random-kat: $(SRC) *.h FromNIST/*.h FromNIST/additionalRandomTesting.c
	$(CC) $(CFLAGS) FromNIST/additionalRandomTesting.c $(SRC) $(INCLUDE) -DVERBOSE=$(VERBOSE) -DNIST_RAND=1 -o $@

bike-encap-kat: $(SRC) *.h FromNIST/*.h FromNIST/additionalEncapsulationTesting.c
	$(CC) $(CFLAGS) FromNIST/additionalEncapsulationTesting.c $(SRC) $(INCLUDE) -DVERBOSE=$(VERBOSE) -DNIST_RAND=1 -o $@

bike-decap-kat: $(SRC) *.h FromNIST/*.h FromNIST/additionalDecapsulationTesting.c
	$(CC) $(CFLAGS) FromNIST/additionalDecapsulationTesting.c $(SRC) $(INCLUDE) -DVERBOSE=$(VERBOSE) -DNIST_RAND=1 -o $@

createKeyPairs: $(SRC) *.h FromNIST/*.h FromNIST/createKeyPairs.c
	$(CC) $(CFLAGS) FromNIST/createKeyPairs.c $(SRC) $(INCLUDE) -DVERBOSE=$(VERBOSE) -DNIST_RAND=1 -o $@

createEncaps: $(SRC) *.h FromNIST/*.h FromNIST/createEncapsulations.c
	$(CC) $(CFLAGS) FromNIST/createEncapsulations.c $(SRC) $(INCLUDE) -DVERBOSE=$(VERBOSE) -DNIST_RAND=1 -o $@

checkDecaps: $(SRC) *.h FromNIST/*.h FromNIST/checkDecapsulations.c
	$(CC) $(CFLAGS) FromNIST/checkDecapsulations.c $(SRC) $(INCLUDE) -DVERBOSE=$(VERBOSE) -DNIST_RAND=1 -o $@

clean:
	rm -f PQCkemKAT_*
	rm -f bike*

