
extern printf
extern scanf

SECTION .data
    int_in_fmt:    db "%ld", 0           
    int_out_fmt:   db "Max number is: %ld", 10, 0
    prompt1:       db "Enter first integer: ", 0
    prompt2:       db "Enter second integer: ", 0

SECTION .bss
    num1:   resq 1
    num2:   resq 1
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

    ; Read second integer
    mov rdi, int_in_fmt
    lea rsi, [num2]        
    xor rax, rax
    call scanf

    
    mov rdi, [num1]       
    mov rsi, [num2]    


    call max_of_two

    mov [result], rax


    mov rdi, int_out_fmt
    mov rsi, [result]
    xor rax, rax
    call printf


    mov rax, 0
    pop rbp
    ret


max_of_two:
    push rbp
    mov rbp, rsp

    
    cmp rdi, rsi
    jge first_is_max   ; if rdi >= rsi → jump

    ; else second is max
    mov rax, rsi
    jmp done

first_is_max:
    mov rax, rdi

done:
    pop rbp
    ret

