1. Write a function countFrequency that takes an array of integers and returns a new array of pairs, where each pair contains a unique number and its frequency.
Input: The first line contains an integer n — the size of the array. The second line contains n integers representing the elements of the array.
Output: pairs of numbers, where each pair consists of a unique number followed by its frequency. The pairs must be printed in ascending order of the unique numbers—one pair per line.

extern printf
extern scanf
extern qsort

section .data
    fmt_int db "%ld", 0
    fmt_pair db "%ld %ld", 0xA, 0
    newline db 0xA, 0

section .bss
    n resq 1
    arr resq 100      
    freq resq 100
    sorted resq 100

section .text
global main
main:

    push rbp
    mov rbp, rsp

    mov rdi, fmt_int
    mov rsi, n
    xor eax, eax
    call scanf
    
    ; Read array elements
    mov rcx, [n]
    mov rbx, arr

read_loop:
    push rcx
    push rbx
    mov rdi, fmt_int
    mov rsi, rbx
    xor eax, eax
    call scanf
    pop rbx
    pop rcx
    add rbx, 8
    loop read_loop
    
    
    mov rdi, arr
    mov rsi, [n]
    call cntfrq
    
    
    call printPair

    mov rsp, rbp
    pop rbp
    ret


cntfrq:
    push rbp
    mov rbp, rsp
    sub rsp, 32        
    
 
    mov [rbp-8], rdi   
    mov [rbp-16], rsi  
    
 
    mov rdi, [rbp-8]  
    mov rsi, [rbp-16] 
    mov rdx, 8         
    mov rcx, compare   
    call qsort
    
    
    mov r12, [rbp-8]   
    mov r13, [rbp-16] 
    mov r14, freq      
    mov r15, sorted    
    xor rbx, rbx       
    xor rcx, rcx      
    
cnt_loop:
    cmp rcx, r13
    jge cnt_done
    
    mov rax, [r12 + rcx*8]  
    mov rdx, 1             
    

    mov r8, rcx
    inc r8
find_consec:
    cmp r8, r13
    jge store_freq
    mov r9, [r12 + r8*8]
    cmp rax, r9
    jne store_freq
    inc rdx
    inc r8
    jmp find_consec
    
store_freq:
   
    mov [r15 + rbx*8], rax
    mov [r14 + rbx*8], rdx
    inc rbx
    
 
    mov rcx, r8
    jmp cnt_loop
    
cnt_done:
    mov [rbp-24], rbx 
    

    mov rdi, r15      
    mov rsi, rbx      
    mov rdx, 8        
    mov rcx, compare
    call qsort
    
    mov rax, r15      
    mov rdx, r14       
    mov rcx, [rbp-24]  
    
    mov rsp, rbp
    pop rbp
    ret


printPair:
    push rbp
    mov rbp, rsp
    

    
    mov r15, sorted    
    mov r14, freq     
    mov r13, rbx       
    xor r12, r12       
    
print_lp:
    cmp r12, r13
    jge print_done
    
    
    mov rdi, fmt_pair
    mov rsi, [r15 + r12*8]
    mov rdx, [r14 + r12*8]  
    xor eax, eax
    call printf
    
    inc r12
    jmp print_lp
    
print_done:
    mov rsp, rbp
    pop rbp
    ret


compare:
    push rbp
    mov rbp, rsp
    
    mov rax, [rdi]
    mov rdx, [rsi]     
    
    cmp rax, rdx
    jl less
    jg greater
    xor eax, eax       
    jmp done
less:
    mov eax, -1
    jmp done
greater:
    mov eax, 1
done:
    mov rsp, rbp
    pop rbp
    ret

2. Write a function rotateArray that rotates an array to the right by k positions. For example, rotating [1, 2, 3, 4, 5] by 2 positions results in [4, 5, 1, 2, 3].
Input: The first line contains two integers n and k — the size of the array and the number of positions to rotate. The second line contains n integers representing the elements of the array.
Output: Print the array after it has been rotated to the right by k positions—one item per line.



extern printf
extern scanf

section .data
    format_int db "%ld", 0
    format_int2 db "%ld ", 0
    format_two_int db "%ld %ld", 0
    newline db 0xA, 0

section .bss
    n resq 1
    k resq 1
    arr resq 1000      
    temp resq 1000     

section .text
global main

main:
    push rbp
    mov rbp, rsp
    
    mov rdi, format_two_int
    mov rsi, n
    mov rdx, k
    xor eax, eax
    call scanf
    
   
    mov rcx, [n]
    mov rbx, arr
.read_loop:
    push rcx
    push rbx
    mov rdi, format_int
    mov rsi, rbx
    xor eax, eax
    call scanf
    pop rbx
    pop rcx
    add rbx, 8
    loop .read_loop
    
    
    mov rdi, arr
    mov rsi, [n]
    mov rdx, [k]
    call rotateArray
    
    
    mov rdi, arr
    mov rsi, [n]
    call printArray
    
    
    mov rsp, rbp
    pop rbp
    ret


rotateArray:
    push rbp
    mov rbp, rsp
    push r12
    push r13
    push r14
    push r15
    
    mov r12, rdi      
    mov r13, rsi       
    mov r14, rdx      
    
    
    mov rax, r14
    xor rdx, rdx
    div r13         
    mov r14, rdx      
    
   
    cmp r14, 0
    je .rotate_done
    
   
    mov rcx, r14       
    mov rsi, r12      
    mov rdi, temp      
    mov r15, r13      
    sub r15, r14      
    lea rsi, [r12 + r15*8]  
    
.copy_last_k:
    test rcx, rcx
    jz .copy_first_part
    mov rax, [rsi]
    mov [rdi], rax
    add rsi, 8
    add rdi, 8
    dec rcx
    jmp .copy_last_k
    
.copy_first_part:
   
    mov rcx, r13
    sub rcx, r14       
    mov rsi, r12       
    mov rdi, r12
    lea rdi, [rdi + r14*8] 
    
    
    lea rsi, [rsi + rcx*8 - 8]  
    lea rdi, [rdi + rcx*8 - 8]  
    
.copy_first_loop:
    test rcx, rcx
    jz .restore_last_k
    mov rax, [rsi]
    mov [rdi], rax
    sub rsi, 8
    sub rdi, 8
    dec rcx
    jmp .copy_first_loop
    
.restore_last_k:
    
    mov rcx, r14     
    mov rsi, temp      
    mov rdi, r12       
.copy_temp_back:
    test rcx, rcx
    jz .rotate_done
    mov rax, [rsi]
    mov [rdi], rax
    add rsi, 8
    add rdi, 8
    dec rcx
    jmp .copy_temp_back
    
.rotate_done:
    pop r15
    pop r14
    pop r13
    pop r12
    mov rsp, rbp
    pop rbp
    ret


printArray:
    push rbp
    mov rbp, rsp
    push r12
    push r13
    
    mov r12, rdi    
    mov r13, rsi      
    xor rbx, rbx       
    
print_lp:
    cmp rbx, r13
    jge .print_done
    
    
    mov rdi, format_int2
    mov rsi, [r12 + rbx*8]
    xor eax, eax
    call printf
    
    inc rbx
    jmp print_lp
    
.print_done:
    pop r13
    pop r12
    mov rsp, rbp
    pop rbp
    ret


3. Write a program that takes an array of integers and a threshold value. Create a function averageAboveThreshold that returns the average of all elements greater than the threshold. If no such element exists, return 0.
Example:
Input: arr = [4, 9, 2, 10, 7], threshold = 5  
Output: 8.67
Input
The first line contains two integers n and threshold — the size of the array and the threshold value.
The second line contains n integers representing the elements of the array.

Output
Print the average of all elements greater than the threshold, rounded to two decimal places.
If no elements exceed the threshold, print 0.

extern printf 
extern scanf

section .data
    format_int db "%ld", 0
    fmt_int2 db "%ld %ld", 0
    format_float db "%.2lf", 0xA, 0
    fmt_0 db "0", 0xA, 0
    zero dq 0.0

section .bss
    n resq 1
    threshold resq 1
    arr resq 1000      

section .text
    global main


main:
    push rbp
    mov rbp, rsp
    
    
    mov rdi, fmt_int2
    mov rsi, n
    mov rdx, threshold
    xor eax, eax
    call scanf
    
    
    mov rcx, [n]
    mov rbx, arr
.read_loop:
    push rcx
    push rbx
    mov rdi, format_int
    mov rsi, rbx
    xor eax, eax
    call scanf
    pop rbx
    pop rcx
    add rbx, 8
    loop .read_loop
    
    
    mov rdi, arr
    mov rsi, [n]
    mov rdx, [threshold]
    call averageAboveThreshold
    
    
    movsd xmm1, xmm0
    mov rdi, format_float
    mov eax, 1
    call printf
    
    
    mov rsp, rbp
    pop rbp
    ret


averageAboveThreshold:
    push rbp
    mov rbp, rsp
    
    mov r12, rdi      
    mov r13, rsi       
    mov r14, rdx       
    
    ; Initialize variables
    xorpd xmm0, xmm0   
    xor r15, r15      
    xor rbx, rbx       
    
.loop:
    cmp rbx, r13
    jge .end_loop
    
    mov rax, [r12 + rbx*8]  
    
    
    cmp rax, r14
    jle .skip
    
    
    add r15, 1         
    
    
    cvtsi2sd xmm1, rax
    addsd xmm0, xmm1
    
.skip:
    inc rbx
    jmp .loop

.end_loop:
   
    cmp r15, 0
    je .no_elements
    
    
    cvtsi2sd xmm1, r15
    divsd xmm0, xmm1
    jmp .done
    
.no_elements:
    ; Return 0.0
    xorpd xmm0, xmm0
    
.done:
    mov rsp, rbp
    pop rbp
    ret