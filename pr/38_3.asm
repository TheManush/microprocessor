extern printf
extern scanf

SECTION .data
    in_fmt: db "%s", 0
    out_fmt: db "Reversed string: %s", 10, 0
    prompt: db "Enter a string: ", 0

SECTION .bss
    str: resb 100
    rev_str: resb 100

SECTION .text
    global main

main:
    push rbp

    ; --- Prompt user ---
    mov rdi, prompt
    xor rax, rax
    call printf

    ; --- Read string ---
    mov rdi, in_fmt
    lea rsi, [str]
    xor rax, rax
    call scanf

    ; --- Reverse string ---
    lea rdi, [str]        ; source
    lea rsi, [rev_str]    ; destination
    call reverse_str

    ; --- Print reversed string ---
    mov rdi, out_fmt
    lea rsi, [rev_str]
    xor rax, rax
    call printf

    ; --- Exit ---
    mov rax, 0
    pop rbp
    ret


reverse_str:
    push rbp
    mov rbp, rsp

    ; rdi = source string
    ; rsi = destination string

    ; --- Get string length ---
    mov rdx, rdi        ; temporarily save source pointer
    mov rsi, rdi        ; rsi = source string for str_len
    call str_len        ; rcx = length
    mov rdx, rcx        ; save length

    ; --- Reverse string ---
    dec rdx             ; last index
    xor r8, r8          ; destination index

.rev_loop:
    cmp rdx, -1
    jl .done
    mov al, [rdi + rdx] ; read from source
    mov [rev_str + r8], al  ; write to destination buffer directly
    inc r8
    dec rdx
    jmp .rev_loop

.done:
    mov byte [rev_str + r8], 0  ; null-terminate
    pop rbp
    ret



str_len:
    push rax
    push rsi
    mov rcx,0

.lop_str_len:
    mov al,[rsi]
    cmp al,0
    je .dne_str_len
    add rsi,1
    add rcx,1
    jmp .lop_str_len

.dne_str_len:
    pop rsi
    pop rax
    ret

