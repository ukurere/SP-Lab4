	.file	"matmul.c"
	.text
	.p2align 4
	.globl	init_matrices
	.type	init_matrices, @function
init_matrices:
.LFB39:
	.cfi_startproc
	endbr64
	pushq	%r14
	.cfi_def_cfa_offset 16
	.cfi_offset 14, -16
	movl	$42, %edi
	pushq	%r13
	.cfi_def_cfa_offset 24
	.cfi_offset 13, -24
	leaq	B(%rip), %r13
	pushq	%r12
	.cfi_def_cfa_offset 32
	.cfi_offset 12, -32
	leaq	C(%rip), %r12
	pushq	%rbp
	.cfi_def_cfa_offset 40
	.cfi_offset 6, -40
	leaq	A(%rip), %rbp
	leaq	33554432(%rbp), %r14
	pushq	%rbx
	.cfi_def_cfa_offset 48
	.cfi_offset 3, -48
	call	srand@PLT
	.p2align 4,,10
	.p2align 3
.L2:
	xorl	%ebx, %ebx
	.p2align 4,,10
	.p2align 3
.L3:
	call	rand@PLT
	vxorpd	%xmm1, %xmm1, %xmm1
	vcvtsi2sdl	%eax, %xmm1, %xmm0
	vdivsd	.LC0(%rip), %xmm0, %xmm0
	vmovsd	%xmm0, 0(%rbp,%rbx)
	call	rand@PLT
	vxorpd	%xmm1, %xmm1, %xmm1
	movq	$0x000000000, (%r12,%rbx)
	vcvtsi2sdl	%eax, %xmm1, %xmm0
	vdivsd	.LC0(%rip), %xmm0, %xmm0
	vmovsd	%xmm0, 0(%r13,%rbx)
	addq	$8, %rbx
	cmpq	$16384, %rbx
	jne	.L3
	addq	$16384, %rbp
	addq	$16384, %r13
	addq	$16384, %r12
	cmpq	%r14, %rbp
	jne	.L2
	popq	%rbx
	.cfi_def_cfa_offset 40
	popq	%rbp
	.cfi_def_cfa_offset 32
	popq	%r12
	.cfi_def_cfa_offset 24
	popq	%r13
	.cfi_def_cfa_offset 16
	popq	%r14
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE39:
	.size	init_matrices, .-init_matrices
	.p2align 4
	.globl	matmul
	.type	matmul, @function
matmul:
.LFB40:
	.cfi_startproc
	endbr64
	leaq	B(%rip), %r8
	xorl	%r9d, %r9d
	leaq	C(%rip), %r11
	leaq	A(%rip), %r10
	addq	$33554432, %r8
.L10:
	leaq	(%r10,%r9), %rdi
	leaq	B(%rip), %rcx
	leaq	(%r11,%r9), %rdx
.L15:
	vbroadcastsd	(%rdi), %ymm2
	vbroadcastsd	8(%rdi), %ymm1
	leaq	16384(%rcx), %rsi
	xorl	%eax, %eax
	.p2align 4,,10
	.p2align 3
.L12:
	vmovapd	(%rcx,%rax), %ymm0
	vfmadd213pd	(%rdx,%rax), %ymm2, %ymm0
	vfmadd231pd	(%rsi,%rax), %ymm1, %ymm0
	vmovapd	%ymm0, (%rdx,%rax)
	addq	$32, %rax
	cmpq	$16384, %rax
	jne	.L12
	addq	$32768, %rcx
	addq	$16, %rdi
	cmpq	%r8, %rcx
	jne	.L15
	addq	$16384, %r9
	cmpq	$33554432, %r9
	jne	.L10
	vzeroupper
	ret
	.cfi_endproc
.LFE40:
	.size	matmul, .-matmul
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align 8
.LC4:
	.string	"Elapsed (inside program): %.3f s\n"
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC5:
	.string	"Checksum: %.6f\n"
	.section	.text.startup,"ax",@progbits
	.p2align 4
	.globl	main
	.type	main, @function
main:
.LFB41:
	.cfi_startproc
	endbr64
	pushq	%rbx
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
	call	init_matrices
	call	clock@PLT
	movq	%rax, %rbx
	call	matmul
	call	clock@PLT
	vxorps	%xmm0, %xmm0, %xmm0
	leaq	.LC4(%rip), %rsi
	movl	$2, %edi
	subq	%rbx, %rax
	vcvtsi2sdq	%rax, %xmm0, %xmm0
	movl	$1, %eax
	vdivsd	.LC3(%rip), %xmm0, %xmm0
	call	__printf_chk@PLT
	leaq	C(%rip), %rcx
	vxorpd	%xmm0, %xmm0, %xmm0
	leaq	16384(%rcx), %rdx
	leaq	33570816(%rcx), %rsi
	.p2align 4,,10
	.p2align 3
.L20:
	movq	%rcx, %rax
	.p2align 4,,10
	.p2align 3
.L21:
	vaddsd	(%rax), %xmm0, %xmm0
	addq	$32, %rax
	vaddsd	-24(%rax), %xmm0, %xmm0
	vaddsd	-16(%rax), %xmm0, %xmm0
	vaddsd	-8(%rax), %xmm0, %xmm0
	cmpq	%rdx, %rax
	jne	.L21
	leaq	16384(%rax), %rdx
	addq	$16384, %rcx
	cmpq	%rsi, %rdx
	jne	.L20
	leaq	.LC5(%rip), %rsi
	movl	$2, %edi
	movl	$1, %eax
	call	__printf_chk@PLT
	xorl	%eax, %eax
	popq	%rbx
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE41:
	.size	main, .-main
	.local	C
	.comm	C,33554432,32
	.local	B
	.comm	B,33554432,32
	.local	A
	.comm	A,33554432,32
	.section	.rodata.cst8,"aM",@progbits,8
	.align 8
.LC0:
	.long	-4194304
	.long	1105199103
	.align 8
.LC3:
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
