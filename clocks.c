//****************************************************************************************************************************
//Program name: "Assignment 5".  This program greets calculates how long   *
//it takes a marble from a give height to fall to the earth..
//Copyright (C) 2021  Gabriel Gamboa                                                                                 *
//This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License  *
//version 3 as published by the Free Software Foundation.                                                                    *
//This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied         *
//warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.     *
//A copy of the GNU General Public License v3 is available here:  <https://www.gnu.org/licenses/>.                           *
//****************************************************************************************************************************




// ;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3=========4=========5=========6=========7**
// ;Author information
// ;  Author name: Gabriel Gamboa
// ;  Author email: gabe04@csu.fullerton.edu
// ;
// ;Program information
// ; Program name: Assignment 5
// ;  Programming languages X86 with one module in C
// ;  Date program began 2021-Dec-05
// ;  Date program completed 2021-Dec-14
// ;
// ;Purpose
// ;  This program takes in a given height of a marble from the earth
// ;  and calculates how long it takes to reach the earth if dropped.
// ;  Value is returned in both tics and nanoseconds.
// ;Project information
// ;  Files: clocks.c, time.asm, clock_speed.asm, r.sh, rg.sh
// ;  Status: The program has been tested extensively with no detectable errors.
// ;
//This file
//   File name: clocks.c
//   Language: C
//   Compile: g++ -c -Wall -m64 -no-pie -o clocks.o clocks.c -std=c++17
//   Link: g++ -m64 -no-pie -o frequency.out isfloat.o clocks.o time.o clock_speed.o -std=c++17
//
//
// ;============================================================================================================================================================
//
//===== Begin code area ===========================================================================================================

#include <stdio.h>
#include <stdint.h>
#include <time.h>
#include <sys/time.h>
#include <stdlib.h>
#include <string.h>

extern "C" double execution(); //don't know what the "C" does, but when using isfloat which uses "C", this function
//requires the "C" now too.  Other program with similar structure did not require "C"
int main(int argc, char* argv[])
{double answer = 0.0;
 printf("Welcome to Gravitational experiments by Gabriel Gamboa.\n");
 answer = execution();
 printf("The main function recieved this number %8.5lf and will keep it.\n",answer);
 printf("A 0 will be returned to the OS. Bye.\n");
 return 0;
}
//=======1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**
