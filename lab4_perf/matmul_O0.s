	.file	"matmul.c"
	.text
	.local	A
	.comm	A,33554432,32
	.local	B
	.comm	B,33554432,32
	.local	C
	.comm	C,33554432,32
	.globl	init_matrices
	.type	init_matrices, @function
init_matrices:
.LFB6:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movl	$42, %edi
	call	srand@PLT
	movl	$0, -8(%rbp)
	jmp	.L2
.L5:
	movl	$0, -4(%rbp)
	jmp	.L3
.L4:
	call	rand@PLT
	pxor	%xmm0, %xmm0
	cvtsi2sdl	%eax, %xmm0
	movsd	.LC0(%rip), %xmm1
	divsd	%xmm1, %xmm0
	movl	-4(%rbp), %eax
	cltq
	movl	-8(%rbp), %edx
	movslq	%edx, %rdx
	salq	$11, %rdx
	addq	%rdx, %rax
	leaq	0(,%rax,8), %rdx
	leaq	A(%rip), %rax
	movsd	%xmm0, (%rdx,%rax)
	call	rand@PLT
	pxor	%xmm0, %xmm0
	cvtsi2sdl	%eax, %xmm0
	movsd	.LC0(%rip), %xmm1
	divsd	%xmm1, %xmm0
	movl	-4(%rbp), %eax
	cltq
	movl	-8(%rbp), %edx
	movslq	%edx, %rdx
	salq	$11, %rdx
	addq	%rdx, %rax
	leaq	0(,%rax,8), %rdx
	leaq	B(%rip), %rax
	movsd	%xmm0, (%rdx,%rax)
	movl	-4(%rbp), %eax
	cltq
	movl	-8(%rbp), %edx
	movslq	%edx, %rdx
	salq	$11, %rdx
	addq	%rdx, %rax
	leaq	0(,%rax,8), %rdx
	leaq	C(%rip), %rax
	pxor	%xmm0, %xmm0
	movsd	%xmm0, (%rdx,%rax)
	addl	$1, -4(%rbp)
.L3:
	cmpl	$2047, -4(%rbp)
	jle	.L4
	addl	$1, -8(%rbp)
.L2:
	cmpl	$2047, -8(%rbp)
	jle	.L5
	nop
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE6:
	.size	init_matrices, .-init_matrices
	.globl	matmul
	.type	matmul, @function
matmul:
.LFB7:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movl	$0, -20(%rbp)
	jmp	.L7
.L12:
	movl	$0, -16(%rbp)
	jmp	.L8
.L11:
	movl	-16(%rbp), %eax
	cltq
	movl	-20(%rbp), %edx
	movslq	%edx, %rdx
	salq	$11, %rdx
	addq	%rdx, %rax
	leaq	0(,%rax,8), %rdx
	leaq	A(%rip), %rax
	movsd	(%rdx,%rax), %xmm0
	movsd	%xmm0, -8(%rbp)
	movl	$0, -12(%rbp)
	jmp	.L9
.L10:
	movl	-12(%rbp), %eax
	cltq
	movl	-20(%rbp), %edx
	movslq	%edx, %rdx
	salq	$11, %rdx
	addq	%rdx, %rax
	leaq	0(,%rax,8), %rdx
	leaq	C(%rip), %rax
	movsd	(%rdx,%rax), %xmm1
	movl	-12(%rbp), %eax
	cltq
	movl	-16(%rbp), %edx
	movslq	%edx, %rdx
	salq	$11, %rdx
	addq	%rdx, %rax
	leaq	0(,%rax,8), %rdx
	leaq	B(%rip), %rax
	movsd	(%rdx,%rax), %xmm0
	mulsd	-8(%rbp), %xmm0
	addsd	%xmm1, %xmm0
	movl	-12(%rbp), %eax
	cltq
	movl	-20(%rbp), %edx
	movslq	%edx, %rdx
	salq	$11, %rdx
	addq	%rdx, %rax
	leaq	0(,%rax,8), %rdx
	leaq	C(%rip), %rax
	movsd	%xmm0, (%rdx,%rax)
	addl	$1, -12(%rbp)
.L9:
	cmpl	$2047, -12(%rbp)
	jle	.L10
	addl	$1, -16(%rbp)
.L8:
	cmpl	$2047, -16(%rbp)
	jle	.L11
	addl	$1, -20(%rbp)
.L7:
	cmpl	$2047, -20(%rbp)
	jle	.L12
	nop
	nop
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE7:
	.size	matmul, .-matmul
	.section	.rodata
	.align 8
.LC3:
	.string	"Elapsed (inside program): %.3f s\n"
.LC4:
	.string	"Checksum: %.6f\n"
	.text
	.globl	main
	.type	main, @function
main:
.LFB8:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$48, %rsp
	call	init_matrices
	call	clock@PLT
	movq	%rax, -24(%rbp)
	call	matmul
	call	clock@PLT
	movq	%rax, -16(%rbp)
	movq	-16(%rbp), %rax
	subq	-24(%rbp), %rax
	pxor	%xmm0, %xmm0
	cvtsi2sdq	%rax, %xmm0
	movsd	.LC2(%rip), %xmm1
	divsd	%xmm1, %xmm0
	movsd	%xmm0, -8(%rbp)
	movq	-8(%rbp), %rax
	movq	%rax, %xmm0
	leaq	.LC3(%rip), %rax
	movq	%rax, %rdi
	movl	$1, %eax
	call	printf@PLT
	pxor	%xmm0, %xmm0
	movsd	%xmm0, -32(%rbp)
	movl	$0, -40(%rbp)
	jmp	.L14
.L17:
	movl	$0, -36(%rbp)
	jmp	.L15
.L16:
	movl	-36(%rbp), %eax
	cltq
	movl	-40(%rbp), %edx
	movslq	%edx, %rdx
	salq	$11, %rdx
	addq	%rdx, %rax
	leaq	0(,%rax,8), %rdx
	leaq	C(%rip), %rax
	movsd	(%rdx,%rax), %xmm0
	movsd	-32(%rbp), %xmm1
	addsd	%xmm1, %xmm0
	movsd	%xmm0, -32(%rbp)
	addl	$1, -36(%rbp)
.L15:
	cmpl	$2047, -36(%rbp)
	jle	.L16
	addl	$1, -40(%rbp)
.L14:
	cmpl	$2047, -40(%rbp)
	jle	.L17
	movq	-32(%rbp), %rax
	movq	%rax, %xmm0
	leaq	.LC4(%rip), %rax
	movq	%rax, %rdi
	movl	$1, %eax
	call	printf@PLT
	movl	$0, %eax
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE8:
	.size	main, .-main
	.section	.rodata
	.align 8
.LC0:
	.long	-4194304
	.long	1105199103
	.align 8
.LC2:
	.long	0
	.long	1093567616
	.ident	"GCC: (Ubuntu 13.3.0-6ubuntu2~24.04) 13.3.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	1f - 0f
	.long	4f - 1f
	.long	5
0:
	.string	"GNU"
1:
	.align 8
	.long	0xc0000002
	.long	3f - 2f
2:
	.long	0x3
3:
	.align 8
4:
