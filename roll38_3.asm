extern scanf
extern printf

section .data
	n:        dq 0
	in_fmt:   db "%ld",0
	promt:    db "Divisors are: ",10,0
	st_fmt:   db "%s",0
    	out_fmt:  db "%ld",10,0
	


section .text
global main

main:
	push rbp
   
	mov rdi, in_fmt
	mov rsi, n
	xor rax, rax
	call scanf
	
	mov rdi, st_fmt    
	mov rsi, promt
	xor rax, rax
	call printf     
	mov rbx,1

divs:	
	mov rax, [n]   
	cmp rbx, rax
	jg done  
	xor rdx,rdx
	div rbx
	cmp rdx,0
	jne skips
	                     
	mov rdi,out_fmt		
	mov rsi,rbx    

	call printf

skips:
	inc rbx
	jmp divs

done:
	

	pop rbp
	mov rax, 0
	ret

