extern printf
extern scanf

Section .data

a:	dq	0
b:	dq	0

enter: db "Enter two numbers: ", 0
out_fmt: db "GCD = %ld" ,10,0
out_fmt_2: db "%s",10,0
in_fmt: db "%ld",0

Section .text

global main
main:
	push rbp
	mov rax,0
	mov rdi,out_fmt_2
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
	
	mov rax,[a]
	mov rbx,[b]

gcd_lp:
	cmp rbx,0
	je lp_exit
	xor rdx, rdx
	div rbx
	mov rax,rbx
	mov rbx,rdx
	jmp gcd_lp
lp_exit:
	mov rdi,out_fmt
	mov rsi, rax
	xor rax,rax
	call printf
	pop  rbp
	mov rax,0
	ret

