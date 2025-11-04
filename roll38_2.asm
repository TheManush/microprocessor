extern scanf
extern printf

section .data
    n:        dq 0
    in_fmt:   db "%ld",0
    out_fmt:  db "%ld x %ld = %ld",10,0  


section .text
global main

main:
	push rbp

	mov rdi, in_fmt
	mov rsi, n
	xor rax, rax
	call scanf
     
	mov rbx,1

table_mul:
	cmp rbx, 11
	jge done
	mov rax, [n]   
	imul rax,rbx
	                     
	mov rdi,out_fmt		
	mov rsi,[n]      
	mov rdx, rbx        
	mov rcx,rax
	xor rax,rax
	call printf
	
	inc rbx
	jmp table_mul

done:
	

	pop rbp
	mov rax, 0
	ret

