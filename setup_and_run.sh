#!/bin/bash

# Step 1: Create and navigate to the build directory
mkdir build
cd build

# Step 2: Run CMake and make
cmake ..
make

# Step 3: Navigate back to the parent directory
cd ..

# Step 4: Compile logPrint.c
cc -c logPrint.c

# Step 5: Compile test1.c with the clang plugin
clang -fpass-plugin='build/skeleton/SkeletonPass.dylib' -c test1.c -g

# Step 6: Link the object files and create the executable
cc test1.o logPrint.o

# Step 7: Run the executable
./a.out
