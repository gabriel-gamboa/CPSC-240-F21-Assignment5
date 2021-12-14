#!/bin/bash


#Author: Floyd Holliday
#Program name: Basic Float Operations

rm *.o
rm *.out

echo "This is program Assignment 5"

echo "Assemble the module time.asm"
nasm -f elf64 -l time.lis -o time.o time.asm

echo "Assemble the module clock_speed.asm"
nasm -f elf64 -o clock_speed.o clock_speed.asm

echo "Compile the C++ module isfloat.cpp"
g++ -c -Wall -m64 -no-pie -l isfloat.lis -o isfloat.o isfloat.cpp -std=c++17 #look up c version

echo "Compile the C module clocks.c"
g++ -c -Wall -m64 -no-pie -o clocks.o clocks.c -std=c++17 #look up c version

echo "Link the three object files already created"
g++ -m64 -no-pie -o frequency.out isfloat.o clocks.o time.o clock_speed.o -std=c++17  #look up version

echo "Run the program Assignment 5"
./frequency.out

echo "The bash script file is now closing."
