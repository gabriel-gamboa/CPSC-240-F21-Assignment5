;****************************************************************************************************************************
;Program name: "Assignment 4".  This program greets a user by their inputted name  *
;and title.  Copyright (C) 2021  Gabriel Gamboa                                                                                 *
;This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License  *
;version 3 as published by the Free Software Foundation.                                                                    *
;This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied         *
;warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.     *
;A copy of the GNU General Public License v3 is available here:  <https://www.gnu.org/licenses/>.                           *
;****************************************************************************************************************************

;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3=========4=========5=========6=========7**
;Author information
;  Author name: Gabriel Gamboa
;  Author email: gabe04@csu.fullerton.edu
;
;Program information
; Program name: Assignment 5
;  Programming languages X86 with one module in C and one module in C++
;  Date program began 2021-Dec-05
;  Date program completed 2021-Dec-14
;
;Purpose
;  This program takes the value of resistance and current and
;  returns the power computation if inputs are valid, otherwise
;  it tells user to try again
;Project information
;  Files: maxwell.c, hertz.asm, r.sh
;  Status: The program has been tested extensively with no detectable errors.
;
;Translator information
;  Linux: nasm -f elf64 -l hertz.lis -o hertz.o hertz.asm


;============================================================================================================================================================


;===== Begin code area ============================================================================================================
extern printf
extern scanf
extern fgets
extern strlen
extern stdin
extern atof
extern ispositivefloat
extern getfreq
extern clock_speed
global execution


segment .data
align 16
clock_time db "The current clock time is %ld tics", 10, 0
farewell_message db "Gabriel wishes you a Nice Day.", 10, 0
mess db "Invalid input detected.  You may run this program again", 10, 0
heightprompt db "Please enter the height in meters of the dropped marble: ", 0
marble_time db "The marble will reach the earth after %5.9lf seconds.", 10, 0
exec_time db "The execution time was %ld tics which equals %5.9lf ns", 10, 0
one_float_format db "%lf",0
stringform db "%s", 0
align 64
segment .bss  ;Reserved for uninitialized data

programmers_name resb 256                  ;256 byte space created
height_string resb 256                        ;256 byte space created
cur_string resb 256                        ;256 byte space created

segment .text ;Reserved for executing instructions.

execution:

;=============================================================================================
;back up data in registers
push rbp
mov  rbp,rsp
push rdi                                                    ;Backup rdi
push rsi                                                    ;Backup rsi
push rdx                                                    ;Backup rdx
push rcx                                                    ;Backup rcx
push r8                                                     ;Backup r8
push r9                                                     ;Backup r9
push r10                                                    ;Backup r10
push r11                                                    ;Backup r11
push r12                                                    ;Backup r12
push r13                                                    ;Backup r13
push r14                                                    ;Backup r14
push r15                                                    ;Backup r15
push rbx                                                    ;Backup rbx
pushf                                                       ;Backup rflags



;======Get clock time ========================================================================================================================

;this gets information about the clock
;info stored is clock_time in tics
mov rax, 0
mov rdx, 0

cpuid                              ; Identifies the type of cpu being used on pc.
rdtsc                              ; Counts the number of cycles/tics occured since pc reset.

shl rdx, 32
add rax, rdx            ;info stored here in rax is clock_time (value) in tics
mov r14, rax



;====================================================================================================================================================

mov rax, 0
mov rdi, clock_time               ;"The current clock time is tics"
mov rsi, r14
call printf



;===================Prompt user for marble height ===================================================================================================================================================

mov rax, 0                            ;format for printf, no floats used
mov rdi, heightprompt                 ;"Please enter the height in meters of the dropped marble: "
call printf


;===== Obtain the marble height value and validate=============================================================================================================================================

;set up scanf for height_string
mov rax, 0
mov rdi, stringform
mov rsi, height_string
call scanf


;check input value for float
;mov rax, 0
;mov rdi, height_string
;call ispositivefloat
mov r13, rax            ;r15 {0 is invalid, 1 is valid}

;check whether input is valid or not
cmp r13, 0
jne validprocess

;message run again
mov rax, 0
mov rdi, mess       ;"Invalid input detected.  You may run this program again"
call printf

;create -1.0 to return to driver for invalid inputs
push qword -1
cvtsi2sd xmm14, [rsp]   ;convert -1 to -1.0 and store it in xmmm15
pop rax

jmp continue

;if valid, convert string to float
validprocess:
mov rax, 0
mov rdi, height_string        ;mov height_string to rdi and convert it to a float
call atof
movsd xmm15, xmm0
;Done w/ input data validation

;============================================================================================================================================================================================


;============= Begin arithmetic section  ===============================================================
;divide 98 by 10 to get 9.8 needed in formula
push qword 98
cvtsi2sd xmm14, [rsp]   ;convert 98 to 98.0 and store it in xmmm15
pop rax

;push 10 to divide 98 by it to get 9.8 needed in formula
push qword 10
cvtsi2sd xmm13, [rsp]   ;convert 10 to 10.0 and store it in xmmm15
pop rax

;divide 98 by 10 and store it in xmm14
divsd xmm14, xmm13      ;xmm14 contains 9.8

;push 2 onto stack to convert to 2.0 and use 2.0 neeeded in formula
push qword 2
cvtsi2sd xmm13, [rsp]   ;convert 2 to 2.0 and store it in xmm13
pop rax

;do calculations of how long it will take marble to reach earth from height
;and print out
mov rax, 1              ;1 floating point number will be passed into printf
mov rdi, marble_time     ;"The marble will reach the earth after %5.9lf seconds."
divsd xmm14, xmm13       ; xmm14 is divided by 2.0, and answer is stored in xmm14
divsd xmm15, xmm14       ;Meters inputted is divided by G/2 and stored in xmm15
sqrtsd xmm15, xmm15       ;sqrt of xmm15 is taken and stored in xmm15 (time in secs to reach earth)
movsd xmm0, xmm15
call printf
;pop rax


;============= End of arightmetic section ==============================================================

;======Get clock time ========================================================================================================================

;this gets information about the clock
;info stored is clock_time in tics
mov rax, 0
mov rdx, 0

cpuid                              ; Identifies the type of cpu being used on pc.
rdtsc                              ; Counts the number of cycles/tics occured since pc reset.

shl rdx, 32
add rax, rdx                      ;info stored here in rax is clock_time (value) in tics
mov r15, rax

;====================================================================================================================================================

;output current clock time in tics
mov rax, 0
mov rdi, clock_time             ;"The current clock time is %ld tics"
mov rsi, r15                    ;r15 has clock time in tics
call printf

;====================================================================================================================================================

;call clock_speed to get value of processor in GHz
;we wiil use this to convert our exectution time from tics to nanoseconds
;to do this we divide # of tics by top processor spped
;this will give us execution time value in seconds
;
mov rax, 0
call clock_speed            ;function that returns value of max processor speed in xmm0
movsd xmm15, xmm0           ;store max processor speed in xmm15
cvtsi2sd xmm14, r15         ;r15 holds exec time, we convert to float in xmm14 to use in calculations
divsd xmm14, xmm15          ;divide xmm14 by xmm15 (max processor speed) to
                            ;get execution time in seconds

;get one billion = 1 000 000 000 in xmm13 to multiply by xmm14 to go from seconds to nanoseconds
push qword 1000000000
cvtsi2sd xmm13, [rsp]
pop rax


mov rax, 1
mov rdi, exec_time               ;"The execution time was %ld which equals ns"
sub r15, r14                ;r14 holds original clock time. subtracting r15 by r14 will give us execution time
mov rsi, r15                ;might be some error here. Not sure how having an integer and float in same
mulsd xmm14, xmm13          ;xmm14 holds execution time in nanoseconds now
movsd xmm0, xmm14           ;call will affect things
call printf




;====================================================================================================================================================

;farewell from asm message
mov rax, 0
mov rdi, farewell_message      ;"Gabriel wishes you a nice day"
call printf



;============================================================================================================

continue:                     ;invalid input jumps to this part
movsd xmm0, xmm14              ;power return to caller.

;=================================================================================================================


;===== Restore backed up registers ===============================================================================
popf                                                        ;Restore rflags
pop rbx                                                     ;Restore rbx
pop r15                                                     ;Restore r15
pop r14                                                     ;Restore r14
pop r13                                                     ;Restore r13
pop r12                                                     ;Restore r12
pop r11                                                     ;Restore r11
pop r10                                                     ;Restore r10
pop r9                                                      ;Restore r9
pop r8                                                      ;Restore r8
pop rcx                                                     ;Restore rcx
pop rdx                                                     ;Restore rdx
pop rsi                                                     ;Restore rsi
pop rdi                                                     ;Restore rdi
pop rbp                                                     ;Restore rbp

ret

;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**
