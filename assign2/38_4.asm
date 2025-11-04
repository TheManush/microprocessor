
section .data
    prompt_rows   db "Enter number of rows: ",0
    prompt_cols   db "Enter number of columns: ",0
    prompt_elem   db "Enter element [%d][%d]: ",0
    result_msg    db "Result matrix:",10,0
    fmt_int       db "%d",0
    fmt_scan      db "%d",0
    space         db " ",0
    newline       db 10,0

section .bss
    rows   resq 1
    cols   resq 1
    size   resq 1         
    mat1   resq 1          
    mat2   resq 1
    result resq 1
    temp   resq 1

section .text
    extern printf, scanf, malloc, free
    global main

main:
    push rbp
    mov  rbp, rsp
    sub  rsp, 16          


    mov  rdi, prompt_rows
    call printf
    mov  rdi, fmt_scan
    mov  rsi, rows
    call scanf

    mov  rdi, prompt_cols
    call printf
    mov  rdi, fmt_scan
    mov  rsi, cols
    call scanf

; ---------- compute total size ----------
    mov  rax, [rows]
    mul  qword [cols]          ; rax = rows*cols
    mov  [size], rax

; ---------- allocate three matrices (4 bytes per element) ----------
    mov  rdi, rax
    shl  rdi, 2                ; bytes = elements*4
    call malloc
    mov  [mat1], rax

    mov  rdi, [size]
    shl  rdi, 2
    call malloc
    mov  [mat2], rax

    mov  rdi, [size]
    shl  rdi, 2
    call malloc
    mov  [result], rax

; ---------- input matrix 1 ----------
    xor  r12, r12               ; r12 = row
input1_row:
    cmp  r12, [rows]
    jge  input1_done

    xor  r13, r13               ; r13 = col
input1_col:
    cmp  r13, [cols]
    jge  input1_next_row

    mov  rdi, prompt_elem
    mov  rsi, r12
    mov  rdx, r13
    call printf

    ; index = row*cols + col
    mov  rax, r12
    mul  qword [cols]
    add  rax, r13
    shl  rax, 2
    add  rax, [mat1]

    mov  rdi, fmt_scan
    mov  rsi, rax
    call scanf

    inc  r13
    jmp  input1_col

input1_next_row:
    inc  r12
    jmp  input1_row
input1_done:

; ---------- input matrix 2 (same loop) ----------
    xor  r12, r12
input2_row:
    cmp  r12, [rows]
    jge  input2_done

    xor  r13, r13
input2_col:
    cmp  r13, [cols]
    jge  input2_next_row

    mov  rdi, prompt_elem
    mov  rsi, r12
    mov  rdx, r13
    call printf

    mov  rax, r12
    mul  qword [cols]
    add  rax, r13
    shl  rax, 2
    add  rax, [mat2]

    mov  rdi, fmt_scan
    mov  rsi, rax
    call scanf

    inc  r13
    jmp  input2_col

input2_next_row:
    inc  r12
    jmp  input2_row
input2_done:

; ---------- element-wise AND ----------
    xor  rcx, rcx               ; rcx = element index
and_loop:
    cmp  rcx, [size]
    jge  and_done

    ; mat1[i]
    mov  rax, rcx
    shl  rax, 2
    add  rax, [mat1]
    mov  eax, [rax]

    ; mat2[i]
    mov  rbx, rcx
    shl  rbx, 2
    add  rbx, [mat2]
    mov  ebx, [rbx]

    and  eax, ebx               ; AND

    ; store in result[i]
    mov  rbx, rcx
    shl  rbx, 2
    add  rbx, [result]
    mov  [rbx], eax

    inc  rcx
    jmp  and_loop
and_done:

; ---------- print result ----------
    mov  rdi, result_msg
    call printf

    xor  r12, r12
print_row:
    cmp  r12, [rows]
    jge  print_done

    xor  r13, r13
print_col:
    cmp  r13, [cols]
    jge  print_next_row

    mov  rax, r12
    mul  qword [cols]
    add  rax, r13
    shl  rax, 2
    add  rax, [result]
    mov  eax, [rax]

    mov  rdi, fmt_int
    mov  rsi, rax
    call printf

    mov  rdi, space
    call printf

    inc  r13
    jmp  print_col

print_next_row:
    mov  rdi, newline
    call printf
    inc  r12
    jmp  print_row
print_done:

; ---------- free memory ----------
    mov  rdi, [mat1]
    call free
    mov  rdi, [mat2]
    call free
    mov  rdi, [result]
    call free

; ---------- exit ----------
    xor  eax, eax
    leave
    ret