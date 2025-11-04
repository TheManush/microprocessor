extern printf
extern scanf

section .data
    name:        times 50 db 0                   
    score1:      dq 0
    score2:      dq 0
    score3:      dq 0
    sum:         dq 0
    avg_float:   dq 0
    gradeP:      db "P", 0
    gradeF:      db "F", 0

    prompt_name: db "Enter student name: ", 0
    prompt_scores: db "Enter three exam scores: ", 0
    scan_str:    db "%s", 0
    scan_int:    db "%ld", 0
    fmt_output:  db "Student: %s", 10, 0
    fmt_avg:     db "Average: %.2lf", 10, 0
    fmt_grade:   db "Grade: %s", 10, 0
    float_50:       dq 50.0  
section .text
global main

main:
    push rbp

    mov rdi, prompt_name
    xor rax, rax
    call printf

    mov rdi, scan_str
    mov rsi, name
    xor rax, rax
    call scanf

    mov rdi, prompt_scores
    xor rax, rax
    call printf

    mov rdi, scan_int
    mov rsi, score1
    xor rax, rax
    call scanf

    mov rdi, scan_int
    mov rsi, score2
    xor rax, rax
    call scanf

    mov rdi, scan_int
    mov rsi, score3
    xor rax, rax
    call scanf

    mov rax, [score1]
    add rax, [score2]
    add rax, [score3]
    mov [sum], rax


    cvtsi2sd xmm0, [sum]        ; sum → double
    mov rbx, 3
    cvtsi2sd xmm1, rbx          
    divsd xmm0, xmm1            
    movsd [avg_float], xmm0


    mov rdi, fmt_output
    mov rsi, name
    xor rax, rax
    call printf


    mov rdi, fmt_avg
    movsd xmm0, [avg_float]
    call printf

 
    movsd xmm0, [avg_float]   
    movsd xmm1, [float_50]    
    comisd xmm0, xmm1          
    jb fail

pass:
    mov rdi, fmt_grade
    mov rsi, gradeP
    xor rax, rax
    call printf
    jmp done

fail:
    mov rdi, fmt_grade
    mov rsi, gradeF
    xor rax, rax
    call printf

done:
    pop rbp
    mov rax, 0
    ret
