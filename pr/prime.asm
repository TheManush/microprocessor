extern printf
extern scanf

Section .data

a:	dq	0

enter: db "Enter number: ", 0
prm_fmt: db "%ld is a prime number" ,10,0
not_fmt: db "%ld is a non-prime number" ,10,0
out_fmt: db "%s",10,0
in_fmt: db "%ld",0

Section .text

global main
main:
	push rbp
	mov rax,0
	mov rdi,out_fmt
	mov rsi,enter
	call printf
	
	mov rax,0
	mov rdi,in_fmt
	mov rsi,a
	call scanf
		
	mov rax,[a]
	cmp rax,2
	jb not_prime
	
	mov rbx,2


prm_lp:
	cmp rbx,rax
	ja prime
	xor rdx,rdx
	mov rax,[a]
	idiv rbx
	cmp rdx, 0
	je not_prime
	inc rbx
	jmp prm_lp
	
	
prime:
	mov rdi,prm_fmt
	mov rsi, [a]
	xor rax,rax
	call printf
	jmp end
not_prime:
	mov rdi,not_fmt
	mov rsi, [a]
	xor rax,rax
	call printf
	jmp end
end:
	pop rbp
	mov rax,0
	ret
