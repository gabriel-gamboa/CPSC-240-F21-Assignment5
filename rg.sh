#!/bin/bash


#Author: Floyd Holliday
#Program name: Basic Float Operations

rm *.o
rm *.out

echo "This is program Assignment 5"

echo "Assemble the module time.asm"
nasm -f elf64 -l hertz.lis -o time.o time.asm -g -gdwarf

echo "Compile the C++ module isfloat.cpp"
g++ -c -Wall -m64 -no-pie -l isfloat.lis -o isfloat.o isfloat.cpp -std=c++17 -g

echo "Compile the C module clocks.c"
g++ -c -Wall -m64 -no-pie -o clocks.o clocks.c -std=c++17 -g #look up c version

echo "Link the three object files already created"
g++ -m64 -no-pie -o frequency.out isfloat.o clocks.o time.o -std=c++17 -g #look up version

echo "Run the program Assignment 2"
gdb ./frequency.out

echo "The bash script file is now closing."
