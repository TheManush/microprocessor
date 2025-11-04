extern scanf
extern printf

section .data
    n:      dq 0
    in_fmt:  db "%ld",0
    out_fmt: db "%ld",0
    prompt:  db "Enter a number: ",0
    str_fmt: db "%s",0
    newline: db 10,0

section .text
global main
main:
    push rbp

    ; print prompt
    mov rdi, str_fmt
    mov rsi, prompt
    xor rax, rax
    call printf

    ; read n
    mov rdi, in_fmt
    mov rsi, n
    xor rax, rax
    call scanf

    mov rbx, [n]        

print_digits:
    cmp rbx, 0
    je done

    mov rdx, 0          
    mov rax, rbx
    mov rcx, 10
    div rcx             
    mov rbx,rax
    
    ; print remainder (digit)
    mov rdi, out_fmt
    mov rsi, rdx
    xor rax, rax
    call printf

    
    jmp print_digits

done:
    
    mov rdi, str_fmt
    mov rsi, newline
    xor rax, rax
    call printf
    
    pop rbp
    mov rax, 0
    ret

