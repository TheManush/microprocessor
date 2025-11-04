

extern  printf
extern  scanf

SECTION .data
    int_in_fmt:    db "%ld", 0          
    int_out_fmt:   db "Sum = %ld", 10, 0 
    prompt1:       db "Enter first integer: ", 0
    prompt2:       db "Enter second integer: ", 0

SECTION .bss
    num1:  resq 1
    num2:  resq 1
    result: resq 1

SECTION .text
    global main

main:
    push rbp


    mov rdi, prompt1
    xor rax, rax
    call printf


    mov rdi, int_in_fmt
    lea rsi, [num1]
    xor rax, rax
    call scanf


    mov rdi, prompt2
    xor rax, rax
    call printf


    mov rdi, int_in_fmt
    lea rsi, [num2]
    xor rax, rax
    call scanf

    mov rax, [num1]      
    mov rbx, [num2]       


    mov rdi, rax           
    mov rsi, rbx           
    call sum


    mov [result], rax

 
    mov rdi, int_out_fmt
    mov rsi, [result]
    xor rax, rax
    call printf


    mov rax, 0
    pop rbp
    ret



sum:
    push rbp
    mov rbp, rsp
    mov rax, rdi    
    add rax, rsi     
    pop rbp
    ret
