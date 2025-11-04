extern scanf
extern printf

Section .data
a:	dq	0
b:	dq	0
c:	dq	0

enter: db "Enter three numbers: ",0			
enter_fmt: db "%s",10, 0
out_fmt: db "%ld is the largest",10, 0
in_fmt: db "%ld" ,0  					;scanf format string
Section .text

global main
main:
	push rbp
	
	mov rax,0
	mov rdi,enter_fmt
	mov rsi,enter
	call printf
	
	mov rax,0
	mov rdi,in_fmt
	mov rsi,a
	call scanf
	
	mov rbx,0
	mov rdi,in_fmt
	mov rsi,b
	call scanf
	
	mov rcx,0
	mov rdi,in_fmt
	mov rsi,c
	call scanf
	
	mov rax,[a]
	mov rbx,[b]
	mov rcx,[c]
	cmp rbx,rax
	jle skip_b
	mov rax,rbx
skip_b:
	cmp rcx,rax
	jle skip_c
	mov rax,rcx
skip_c:
	mov rdi,out_fmt
	mov rsi,rax
	call printf
	
	pop rbp
	mov rax,0
	ret
		
	
