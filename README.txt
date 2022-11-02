Will Davis:
To construct additional tests
First make sure you run the commands from compilation steps below.
go to defs.h and select what params you want
run:
make bike-random-kat
make bike-encap-kat
make bike-decap-kat
This creates the binarys which you can execute

Additionally for interoperability testing
Again: go to defs.h and select what params you want
Then you can run:
make createKeyPairs
make createEncaps
make checkDecaps
Note that in these two files, you have to manually switch between
reading from and writing to _java_ or _csharp_

/FromNIST/createEncapsulations.c
/FromNIST/checkDecapsulations.c


Compilation Instructions
------------------------
BIKE reference and optimized implementations assume that OpenSSL and NTL 
libraries are available in the platform.

In most Linux/Debian distributions, the following commands will install all 
required packages:
sudo apt-get install libssl-dev
sudo apt-get install libntl-dev

The GMP library is a dependency of the NTL library. Many Linux distributions 
include GMP library by default. In case GMP is not natively available in your 
distribution, run the following additional command:
sudo apt-get install libgmp-dev   

The NTL library can be built with or without support to GF2X lib. The GF2X lib
enables faster polynomial multuplication, thus we recommend the use of NTL lib
with GF2X support. Check if the NTL available in your machine has GF2X support.
In case not, you will need to install GF2X lib (v 1.2 2017-07-03 14:28) and 
build NTL (v 11.3.2 2018.11.15) as follows:
$ ./configure NTL_GF2X_LIB=on
$ make
$ make check
$ make install
Also, make sure that -lgf2x is added to the compilation flags after -lgmp when
compiling BIKE.
 
Defining the Exectuable to be Built 
-----------------------------------
To compile this code for NIST KAT routine: make bike-nist-kat
To compile this code for demo tests: make bike-demo-test

Editing Scheme Parameters:
--------------------------
TO EDIT PARAMETERS AND SELECT THE BIKE VARIANT: please edit defs.h file in the 
indicated sections. 

Editing Debug Parameters:
-------------------------
The file measurements.h controls how the cycles are counted. Note that #define 
REPEAT is initially set to 100, which means that every keygen, encaps and decaps 
is repeated 100 times and the number of cycles is averaged.

