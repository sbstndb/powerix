	.file	"benchmark_asm_double.cpp"
	.text
#APP
	.globl _ZSt21ios_base_library_initv
#NO_APP
	.p2align 4
	.type	_ZL17pow_scalar_doubledj, @function
_ZL17pow_scalar_doubledj:
.LFB13337:
	.cfi_startproc
	testl	%edi, %edi
	je	.L5
	vmovsd	%xmm0, %xmm0, %xmm1
	cmpl	$1, %edi
	je	.L1
	vmovsd	.LC0(%rip), %xmm1
	.p2align 4,,10
	.p2align 3
.L4:
	testb	$1, %dil
	je	.L3
	vmulsd	%xmm0, %xmm1, %xmm1
.L3:
	vmulsd	%xmm0, %xmm0, %xmm0
	shrl	%edi
	jne	.L4
.L1:
	vmovsd	%xmm1, %xmm1, %xmm0
	ret
	.p2align 4,,10
	.p2align 3
.L5:
	vmovsd	.LC0(%rip), %xmm1
	vmovsd	%xmm1, %xmm1, %xmm0
	ret
	.cfi_endproc
.LFE13337:
	.size	_ZL17pow_scalar_doubledj, .-_ZL17pow_scalar_doubledj
	.p2align 4
	.type	_ZL21pow_branchless_doubledj, @function
_ZL21pow_branchless_doubledj:
.LFB13338:
	.cfi_startproc
	vmovsd	.LC0(%rip), %xmm1
	testl	%edi, %edi
	je	.L13
	.p2align 4,,10
	.p2align 3
.L16:
	testb	$1, %dil
	je	.L15
	vmulsd	%xmm0, %xmm1, %xmm1
.L15:
	vmulsd	%xmm0, %xmm0, %xmm0
	shrl	%edi
	jne	.L16
.L13:
	vmovsd	%xmm1, %xmm1, %xmm0
	ret
	.cfi_endproc
.LFE13338:
	.size	_ZL21pow_branchless_doubledj, .-_ZL21pow_branchless_doubledj
	.p2align 4
	.type	_ZL13pow_asm_blenddj, @function
_ZL13pow_asm_blenddj:
.LFB13339:
	.cfi_startproc
	subq	$56, %rsp
	.cfi_def_cfa_offset 64
	vmovsd	%xmm0, 8(%rsp)
	movq	%fs:40, %rax
	movq	%rax, 40(%rsp)
	xorl	%eax, %eax
	movq	.LC0(%rip), %rax
	movq	%rax, 32(%rsp)
#APP
# 139 "/tmp/powerix/benchmark/benchmark_asm_double.cpp" 1
	movsd 32(%rsp), %xmm0
	movsd 8(%rsp), %xmm1
	test %edi, %edi
	jz 2f
	.p2align 4
	1:
	movapd %xmm0, %xmm2
	mulsd %xmm1, %xmm2
	mov %edi, %eax
	and $1, %eax
	neg %eax
	movsx %eax, %rax
	movq %rax, %xmm3
	movapd %xmm2, %xmm4
	andpd %xmm3, %xmm4
	andnpd %xmm0, %xmm3
	orpd %xmm4, %xmm3
	movapd %xmm3, %xmm0
	mulsd %xmm1, %xmm1
	shr %edi
	jnz 1b
	2:
	movsd %xmm0, 24(%rsp)
	
# 0 "" 2
#NO_APP
	vmovsd	24(%rsp), %xmm0
	movq	40(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L25
	vzeroupper
	addq	$56, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	ret
.L25:
	.cfi_restore_state
	vzeroupper
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE13339:
	.size	_ZL13pow_asm_blenddj, .-_ZL13pow_asm_blenddj
	.p2align 4
	.type	_ZL12pow_asm_mul1dj, @function
_ZL12pow_asm_mul1dj:
.LFB13340:
	.cfi_startproc
	subq	$56, %rsp
	.cfi_def_cfa_offset 64
	vmovsd	%xmm0, 8(%rsp)
	movq	%fs:40, %rax
	movq	%rax, 40(%rsp)
	xorl	%eax, %eax
	movq	.LC0(%rip), %rax
	movq	%rax, 32(%rsp)
#APP
# 201 "/tmp/powerix/benchmark/benchmark_asm_double.cpp" 1
	movsd 32(%rsp), %xmm0
	movsd 8(%rsp), %xmm1
	movsd 32(%rsp), %xmm5
	test %edi, %edi
	jz 2f
	.p2align 4
	1:
	mov %edi, %eax
	and $1, %eax
	neg %eax
	movsx %eax, %rax
	movq %rax, %xmm3
	movapd %xmm1, %xmm4
	andpd %xmm3, %xmm4
	andnpd %xmm5, %xmm3
	orpd %xmm4, %xmm3
	mulsd %xmm3, %xmm0
	mulsd %xmm1, %xmm1
	shr %edi
	jnz 1b
	2:
	movsd %xmm0, 24(%rsp)
	
# 0 "" 2
#NO_APP
	vmovsd	24(%rsp), %xmm0
	movq	40(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L29
	vzeroupper
	addq	$56, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	ret
.L29:
	.cfi_restore_state
	vzeroupper
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE13340:
	.size	_ZL12pow_asm_mul1dj, .-_ZL12pow_asm_mul1dj
	.p2align 4
	.type	_ZL12wrap_std_powdj, @function
_ZL12wrap_std_powdj:
.LFB13343:
	.cfi_startproc
	movl	%edi, %edi
	vxorps	%xmm1, %xmm1, %xmm1
	vcvtsi2sdq	%rdi, %xmm1, %xmm1
	jmp	pow@PLT
	.cfi_endproc
.LFE13343:
	.size	_ZL12wrap_std_powdj, .-_ZL12wrap_std_powdj
	.p2align 4
	.type	_ZL15wrap_pow_binarydj, @function
_ZL15wrap_pow_binarydj:
.LFB13342:
	.cfi_startproc
	testl	%edi, %edi
	je	.L37
	vmovsd	%xmm0, %xmm0, %xmm1
	cmpl	$1, %edi
	je	.L33
	vmovsd	.LC0(%rip), %xmm1
	.p2align 4,,10
	.p2align 3
.L36:
	testb	$1, %dil
	je	.L35
	vmulsd	%xmm0, %xmm1, %xmm1
.L35:
	vmulsd	%xmm0, %xmm0, %xmm0
	shrl	%edi
	jne	.L36
.L33:
	vmovsd	%xmm1, %xmm1, %xmm0
	ret
	.p2align 4,,10
	.p2align 3
.L37:
	vmovsd	.LC0(%rip), %xmm1
	vmovsd	%xmm1, %xmm1, %xmm0
	ret
	.cfi_endproc
.LFE13342:
	.size	_ZL15wrap_pow_binarydj, .-_ZL15wrap_pow_binarydj
	.section	.text._ZNSt6vectorI8TestCaseSaIS0_EED2Ev,"axG",@progbits,_ZNSt6vectorI8TestCaseSaIS0_EED5Ev,comdat
	.align 2
	.p2align 4
	.weak	_ZNSt6vectorI8TestCaseSaIS0_EED2Ev
	.type	_ZNSt6vectorI8TestCaseSaIS0_EED2Ev, @function
_ZNSt6vectorI8TestCaseSaIS0_EED2Ev:
.LFB13953:
	.cfi_startproc
	endbr64
	movq	(%rdi), %rax
	testq	%rax, %rax
	je	.L46
	movq	16(%rdi), %rsi
	movq	%rax, %rdi
	subq	%rax, %rsi
	jmp	_ZdlPvm@PLT
	.p2align 4,,10
	.p2align 3
.L46:
	ret
	.cfi_endproc
.LFE13953:
	.size	_ZNSt6vectorI8TestCaseSaIS0_EED2Ev, .-_ZNSt6vectorI8TestCaseSaIS0_EED2Ev
	.weak	_ZNSt6vectorI8TestCaseSaIS0_EED1Ev
	.set	_ZNSt6vectorI8TestCaseSaIS0_EED1Ev,_ZNSt6vectorI8TestCaseSaIS0_EED2Ev
	.text
	.p2align 4
	.type	_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.isra.0, @function
_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.isra.0:
.LFB14978:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rdi, %rbp
	pushq	%rbx
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	subq	$8, %rsp
	.cfi_def_cfa_offset 32
	testq	%rsi, %rsi
	je	.L50
	movq	%rsi, %rdi
	movq	%rsi, %rbx
	call	strlen@PLT
	addq	$8, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	movq	%rbx, %rsi
	movq	%rbp, %rdi
	popq	%rbx
	.cfi_def_cfa_offset 16
	movq	%rax, %rdx
	popq	%rbp
	.cfi_def_cfa_offset 8
	jmp	_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l@PLT
.L50:
	.cfi_restore_state
	movq	(%rdi), %rax
	movq	-24(%rax), %rdi
	addq	%rbp, %rdi
	movl	32(%rdi), %esi
	popq	%rax
	.cfi_def_cfa_offset 24
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	orl	$1, %esi
	jmp	_ZNSt9basic_iosIcSt11char_traitsIcEE5clearESt12_Ios_Iostate@PLT
	.cfi_endproc
.LFE14978:
	.size	_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.isra.0, .-_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.isra.0
	.p2align 4
	.type	_ZN7powerix16pow_hierarchicalIdjEET_S1_T0_.part.0, @function
_ZN7powerix16pow_hierarchicalIdjEET_S1_T0_.part.0:
.LFB14974:
	.cfi_startproc
	pushq	%r12
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
	vmulsd	%xmm0, %xmm0, %xmm2
	vmovsd	%xmm0, %xmm0, %xmm1
	pushq	%rbp
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
	movl	%edi, %ebp
	pushq	%rbx
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
	shrl	%ebp
	movl	%edi, %ebx
	subq	$32, %rsp
	.cfi_def_cfa_offset 64
	cmpl	$1, %ebp
	je	.L52
	vmulsd	%xmm2, %xmm2, %xmm3
	movl	%edi, %r12d
	shrl	$2, %r12d
	cmpl	$1, %r12d
	je	.L53
	vmulsd	%xmm3, %xmm3, %xmm0
	shrl	$3, %edi
	cmpl	$1, %edi
	je	.L54
	vmovsd	%xmm1, 24(%rsp)
	vmovsd	%xmm2, 16(%rsp)
	vmovsd	%xmm3, 8(%rsp)
	call	_ZN7powerix16pow_hierarchicalIdjEET_S1_T0_.part.0
	vmovsd	24(%rsp), %xmm1
	vmovsd	16(%rsp), %xmm2
	vmovsd	8(%rsp), %xmm3
.L54:
	andl	$1, %r12d
	je	.L56
	vmulsd	%xmm0, %xmm3, %xmm3
.L53:
	andl	$1, %ebp
	je	.L57
	vmulsd	%xmm3, %xmm2, %xmm2
.L52:
	andl	$1, %ebx
	je	.L51
	vmulsd	%xmm1, %xmm2, %xmm2
.L51:
	addq	$32, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 32
	vmovsd	%xmm2, %xmm2, %xmm0
	popq	%rbx
	.cfi_def_cfa_offset 24
	popq	%rbp
	.cfi_def_cfa_offset 16
	popq	%r12
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L57:
	.cfi_restore_state
	vmovsd	%xmm3, %xmm3, %xmm2
	jmp	.L52
	.p2align 4,,10
	.p2align 3
.L56:
	vmovsd	%xmm0, %xmm0, %xmm3
	jmp	.L53
	.cfi_endproc
.LFE14974:
	.size	_ZN7powerix16pow_hierarchicalIdjEET_S1_T0_.part.0, .-_ZN7powerix16pow_hierarchicalIdjEET_S1_T0_.part.0
	.p2align 4
	.type	_ZL21wrap_pow_hierarchicaldj, @function
_ZL21wrap_pow_hierarchicaldj:
.LFB13341:
	.cfi_startproc
	testl	%edi, %edi
	je	.L82
	vmovsd	%xmm0, %xmm0, %xmm4
	movl	%edi, %eax
	vmovsd	%xmm0, %xmm0, %xmm5
	cmpl	$1, %edi
	je	.L126
	vmulsd	%xmm0, %xmm0, %xmm5
	movl	%edi, %edx
	shrl	%edx
	cmpl	$1, %edx
	je	.L127
	vmulsd	%xmm5, %xmm5, %xmm6
	movl	%edi, %ecx
	shrl	$2, %ecx
	cmpl	$1, %ecx
	je	.L128
	vmulsd	%xmm6, %xmm6, %xmm7
	movl	%edi, %esi
	shrl	$3, %esi
	cmpl	$1, %esi
	je	.L129
	vmulsd	%xmm7, %xmm7, %xmm8
	movl	%edi, %r8d
	shrl	$4, %r8d
	cmpl	$1, %r8d
	je	.L130
	vmulsd	%xmm8, %xmm8, %xmm9
	movl	%edi, %r9d
	shrl	$5, %r9d
	cmpl	$1, %r9d
	je	.L131
	vmulsd	%xmm9, %xmm9, %xmm10
	movl	%edi, %r10d
	shrl	$6, %r10d
	cmpl	$1, %r10d
	je	.L132
	vmulsd	%xmm10, %xmm10, %xmm11
	movl	%edi, %r11d
	shrl	$7, %r11d
	cmpl	$1, %r11d
	je	.L133
	vmulsd	%xmm11, %xmm11, %xmm12
	pushq	%rbx
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
	movl	%edi, %ebx
	shrl	$8, %ebx
	vmovsd	%xmm12, %xmm12, %xmm0
	cmpl	$1, %ebx
	je	.L80
	vmulsd	%xmm12, %xmm12, %xmm0
	shrl	$9, %edi
	cmpl	$1, %edi
	je	.L81
	call	_ZN7powerix16pow_hierarchicalIdjEET_S1_T0_.part.0
.L81:
	andb	$1, %bl
	je	.L80
	vmulsd	%xmm12, %xmm0, %xmm0
.L80:
	andl	$1, %r11d
	je	.L79
	vmulsd	%xmm11, %xmm0, %xmm0
.L79:
	vmulsd	%xmm0, %xmm10, %xmm10
	andl	$1, %r10d
	jne	.L78
	vmovsd	%xmm0, %xmm0, %xmm10
.L78:
	andl	$1, %r9d
	je	.L87
	vmulsd	%xmm10, %xmm9, %xmm9
.L77:
	andl	$1, %r8d
	je	.L88
	vmulsd	%xmm9, %xmm8, %xmm8
.L76:
	andl	$1, %esi
	je	.L89
	vmulsd	%xmm8, %xmm7, %xmm7
.L75:
	andl	$1, %ecx
	je	.L90
	vmulsd	%xmm7, %xmm6, %xmm6
.L74:
	andl	$1, %edx
	je	.L91
	vmulsd	%xmm6, %xmm5, %xmm5
.L73:
	testb	$1, %al
	je	.L71
	vmulsd	%xmm4, %xmm5, %xmm5
.L71:
	vmovsd	%xmm5, %xmm5, %xmm0
	popq	%rbx
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L82:
	.cfi_restore 3
	vmovsd	.LC0(%rip), %xmm5
.L126:
	vmovsd	%xmm5, %xmm5, %xmm0
	ret
	.p2align 4,,10
	.p2align 3
.L143:
	vmovsd	%xmm7, %xmm7, %xmm6
	.p2align 4,,10
	.p2align 3
.L128:
	andl	$1, %edx
	je	.L145
	vmulsd	%xmm6, %xmm5, %xmm5
	.p2align 4,,10
	.p2align 3
.L127:
	testb	$1, %al
	je	.L126
	vmulsd	%xmm4, %xmm5, %xmm5
	jmp	.L126
	.p2align 4,,10
	.p2align 3
.L145:
	vmovsd	%xmm6, %xmm6, %xmm5
	jmp	.L127
.L139:
	vmovsd	%xmm9, %xmm9, %xmm8
	.p2align 4,,10
	.p2align 3
.L130:
	andl	$1, %esi
	je	.L141
	vmulsd	%xmm8, %xmm7, %xmm7
	.p2align 4,,10
	.p2align 3
.L129:
	andl	$1, %ecx
	je	.L143
	vmulsd	%xmm7, %xmm6, %xmm6
	jmp	.L128
	.p2align 4,,10
	.p2align 3
.L91:
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
	vmovsd	%xmm6, %xmm6, %xmm5
	jmp	.L73
	.p2align 4,,10
	.p2align 3
.L90:
	vmovsd	%xmm7, %xmm7, %xmm6
	jmp	.L74
	.p2align 4,,10
	.p2align 3
.L89:
	vmovsd	%xmm8, %xmm8, %xmm7
	jmp	.L75
.L141:
	.cfi_def_cfa_offset 8
	.cfi_restore 3
	vmovsd	%xmm8, %xmm8, %xmm7
	jmp	.L129
.L137:
	vmovsd	%xmm10, %xmm10, %xmm9
.L131:
	andl	$1, %r8d
	je	.L139
	vmulsd	%xmm9, %xmm8, %xmm8
	jmp	.L130
.L88:
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
	vmovsd	%xmm9, %xmm9, %xmm8
	jmp	.L76
.L133:
	.cfi_def_cfa_offset 8
	.cfi_restore 3
	vmulsd	%xmm11, %xmm10, %xmm10
	andb	$1, %r10b
	jne	.L132
	vmovsd	%xmm11, %xmm11, %xmm10
.L132:
	andl	$1, %r9d
	je	.L137
	vmulsd	%xmm10, %xmm9, %xmm9
	jmp	.L131
.L87:
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
	vmovsd	%xmm10, %xmm10, %xmm9
	jmp	.L77
	.cfi_endproc
.LFE13341:
	.size	_ZL21wrap_pow_hierarchicaldj, .-_ZL21wrap_pow_hierarchicaldj
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align 8
.LC1:
	.string	"=== DOUBLE BASE x INTEGER EXPONENT: BRANCHLESS ASM BENCHMARK ===\n\n"
	.align 8
.LC2:
	.string	"=== CORRECTNESS VERIFICATION ===\n"
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC11:
	.string	"MISMATCH: base="
.LC12:
	.string	" exp="
.LC13:
	.string	" ref="
.LC14:
	.string	" branchless="
.LC15:
	.string	" asm_blend="
.LC16:
	.string	" asm_mul1="
.LC17:
	.string	" hier="
.LC18:
	.string	" binary="
.LC19:
	.string	"\n"
	.section	.rodata.str1.8
	.align 8
.LC20:
	.string	"CORRECTNESS CHECK FAILED -- aborting benchmarks.\n"
	.align 8
.LC21:
	.string	"All implementations produce identical results.\n\n"
	.section	.rodata.str1.1
.LC22:
	.string	"=== IMPLEMENTATION NOTES ===\n"
	.section	.rodata.str1.8
	.align 8
.LC23:
	.string	"ScalarLoop:    Standard binary exp with branch on exp&1\n"
	.align 8
.LC24:
	.string	"Branchless:    C++ ternary selecting current vs 1.0 (compiler decides cmov/branch)\n"
	.align 8
.LC25:
	.string	"AsmBlend:      Inline asm with andpd/andnpd/orpd mask blend (fully branchless)\n"
	.align 8
.LC26:
	.string	"AsmMul1:       Inline asm selecting current vs 1.0 via mask, then always multiply\n"
	.align 8
.LC27:
	.string	"Hierarchical:  powerix::pow_hierarchical (recursive divide & conquer)\n"
	.align 8
.LC28:
	.string	"Binary:        powerix::pow_binary (library binary exp)\n"
	.align 8
.LC29:
	.string	"StdPow:        std::pow(double, double) reference\n"
	.align 8
.LC30:
	.string	"Test data: 1024 random doubles in [0.5, 2.0] per exponent value\n"
	.section	.rodata.str1.1
.LC31:
	.string	"Exponents tested: 3, 7, 13\n\n"
	.section	.text.startup,"ax",@progbits
	.p2align 4
	.globl	main
	.type	main, @function
main:
.LFB13401:
	.cfi_startproc
	endbr64
	leaq	8(%rsp), %r10
	.cfi_def_cfa 10, 0
	andq	$-32, %rsp
	pushq	-8(%r10)
	pushq	%rbp
	movq	%rsp, %rbp
	.cfi_escape 0x10,0x6,0x2,0x76,0
	pushq	%r15
	pushq	%r14
	.cfi_escape 0x10,0xf,0x2,0x76,0x78
	.cfi_escape 0x10,0xe,0x2,0x76,0x70
	leaq	-144(%rbp), %r14
	pushq	%r13
	.cfi_escape 0x10,0xd,0x2,0x76,0x68
	movl	$1, %r13d
	pushq	%r12
	.cfi_escape 0x10,0xc,0x2,0x76,0x60
	leaq	-164(%rbp), %r12
	pushq	%r10
	.cfi_escape 0xf,0x3,0x76,0x58,0x6
	pushq	%rbx
	subq	$256, %rsp
	.cfi_escape 0x10,0x3,0x2,0x76,0x50
	movl	%edi, -212(%rbp)
	leaq	_ZSt4cout(%rip), %rdi
	movq	%rsi, -296(%rbp)
	leaq	.LC1(%rip), %rsi
	movq	%fs:40, %rax
	movq	%rax, -56(%rbp)
	xorl	%eax, %eax
	call	_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.isra.0
	leaq	.LC2(%rip), %rsi
	leaq	_ZSt4cout(%rip), %rdi
	call	_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.isra.0
	movq	.LC5(%rip), %rax
	vmovapd	.LC3(%rip), %ymm0
	movl	$20, -168(%rbp)
	movq	%rax, -80(%rbp)
	movq	.LC7(%rip), %rax
	vmovapd	%ymm0, -144(%rbp)
	vmovapd	.LC4(%rip), %ymm0
	movq	%rax, -176(%rbp)
	leaq	-72(%rbp), %rax
	movq	%rax, -280(%rbp)
	leaq	-208(%rbp), %rax
	vmovapd	%ymm0, -112(%rbp)
	vmovdqa	.LC6(%rip), %ymm0
	movq	%rax, -288(%rbp)
	vmovdqa	%ymm0, -208(%rbp)
	vzeroupper
	.p2align 4,,10
	.p2align 3
.L166:
	vmovsd	(%r14), %xmm3
	movq	-288(%rbp), %r15
	vmovsd	%xmm3, -224(%rbp)
	jmp	.L165
	.p2align 4,,10
	.p2align 3
.L182:
	vxorpd	%xmm5, %xmm5, %xmm5
	vcomisd	%xmm5, %xmm2
	jne	.L176
.L150:
	vmovsd	-232(%rbp), %xmm6
	vcomisd	%xmm6, %xmm1
	je	.L154
	vandpd	.LC8(%rip), %xmm1, %xmm4
	vandpd	.LC8(%rip), %xmm6, %xmm0
	vcomisd	%xmm0, %xmm4
	ja	.L155
	vxorpd	%xmm4, %xmm4, %xmm4
	vcomisd	%xmm4, %xmm6
	jne	.L177
.L154:
	vmovsd	-240(%rbp), %xmm7
	vcomisd	%xmm7, %xmm1
	je	.L157
	vandpd	.LC8(%rip), %xmm1, %xmm4
	vandpd	.LC8(%rip), %xmm7, %xmm0
	vcomisd	%xmm0, %xmm4
	ja	.L158
	vxorpd	%xmm4, %xmm4, %xmm4
	vcomisd	%xmm4, %xmm7
	jne	.L178
.L157:
	vmovsd	-248(%rbp), %xmm5
	vcomisd	%xmm5, %xmm1
	je	.L160
	vandpd	.LC8(%rip), %xmm1, %xmm4
	vandpd	.LC8(%rip), %xmm5, %xmm0
	vcomisd	%xmm0, %xmm4
	ja	.L161
	vxorpd	%xmm4, %xmm4, %xmm4
	vcomisd	%xmm4, %xmm5
	jne	.L179
.L160:
	vcomisd	%xmm3, %xmm1
	je	.L174
	vandpd	.LC8(%rip), %xmm1, %xmm4
	vandpd	.LC8(%rip), %xmm3, %xmm0
	vcomisd	%xmm0, %xmm4
	ja	.L164
	vxorpd	%xmm4, %xmm4, %xmm4
	vcomisd	%xmm4, %xmm3
	jne	.L180
.L174:
	vzeroupper
	addq	$4, %r15
	cmpq	%r15, %r12
	je	.L181
.L165:
	movl	(%r15), %ebx
	vmovsd	-224(%rbp), %xmm0
	movl	%ebx, %edi
	call	_ZL17pow_scalar_doubledj
	movl	%ebx, %edi
	vmovsd	%xmm0, -264(%rbp)
	vmovsd	-224(%rbp), %xmm0
	call	_ZL21pow_branchless_doubledj
	movl	%ebx, %edi
	vmovsd	%xmm0, -256(%rbp)
	vmovsd	-224(%rbp), %xmm0
	call	_ZL13pow_asm_blenddj
	movl	%ebx, %edi
	vmovsd	%xmm0, -232(%rbp)
	vmovsd	-224(%rbp), %xmm0
	call	_ZL12pow_asm_mul1dj
	movl	%ebx, %edi
	vmovsd	%xmm0, -240(%rbp)
	vmovsd	-224(%rbp), %xmm0
	call	_ZL21wrap_pow_hierarchicaldj
	movl	%ebx, %edi
	vmovsd	%xmm0, -248(%rbp)
	vmovsd	-224(%rbp), %xmm0
	call	_ZL15wrap_pow_binarydj
	vmovsd	-256(%rbp), %xmm2
	vmovsd	-264(%rbp), %xmm1
	vmovsd	%xmm0, %xmm0, %xmm3
	vcomisd	%xmm2, %xmm1
	je	.L150
	vmovq	.LC8(%rip), %xmm4
	vandpd	%xmm4, %xmm1, %xmm5
	vandpd	%xmm4, %xmm2, %xmm0
	vcomisd	%xmm0, %xmm5
	jbe	.L182
.L151:
	vsubsd	%xmm1, %xmm2, %xmm0
	vandpd	%xmm4, %xmm0, %xmm0
	vmovsd	.LC10(%rip), %xmm4
	vdivsd	%xmm5, %xmm0, %xmm0
	vcomisd	%xmm0, %xmm4
	ja	.L150
.L152:
	leaq	_ZSt4cerr(%rip), %r13
	vmovsd	%xmm3, -272(%rbp)
	movl	$15, %edx
	leaq	.LC11(%rip), %rsi
	vmovsd	%xmm2, -264(%rbp)
	movq	%r13, %rdi
	vmovsd	%xmm1, -256(%rbp)
	vzeroupper
	call	_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l@PLT
	movq	%r13, %rdi
	addq	$4, %r15
	vmovsd	-224(%rbp), %xmm0
	call	_ZNSo9_M_insertIdEERSoT_@PLT
	movl	$5, %edx
	leaq	.LC12(%rip), %rsi
	movq	%rax, %r13
	movq	%rax, %rdi
	call	_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l@PLT
	movl	%ebx, %esi
	movq	%r13, %rdi
	xorl	%r13d, %r13d
	call	_ZNSo9_M_insertImEERSoT_@PLT
	movl	$5, %edx
	leaq	.LC13(%rip), %rsi
	movq	%rax, %rdi
	movq	%rax, %rbx
	call	_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l@PLT
	vmovsd	-256(%rbp), %xmm1
	movq	%rbx, %rdi
	vmovsd	%xmm1, %xmm1, %xmm0
	call	_ZNSo9_M_insertIdEERSoT_@PLT
	movl	$12, %edx
	leaq	.LC14(%rip), %rsi
	movq	%rax, %rdi
	movq	%rax, %rbx
	call	_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l@PLT
	vmovsd	-264(%rbp), %xmm2
	movq	%rbx, %rdi
	vmovsd	%xmm2, %xmm2, %xmm0
	call	_ZNSo9_M_insertIdEERSoT_@PLT
	movl	$11, %edx
	leaq	.LC15(%rip), %rsi
	movq	%rax, %rdi
	movq	%rax, %rbx
	call	_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l@PLT
	vmovsd	-232(%rbp), %xmm0
	movq	%rbx, %rdi
	call	_ZNSo9_M_insertIdEERSoT_@PLT
	movl	$10, %edx
	leaq	.LC16(%rip), %rsi
	movq	%rax, %rdi
	movq	%rax, %rbx
	call	_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l@PLT
	vmovsd	-240(%rbp), %xmm0
	movq	%rbx, %rdi
	call	_ZNSo9_M_insertIdEERSoT_@PLT
	movl	$6, %edx
	leaq	.LC17(%rip), %rsi
	movq	%rax, %rdi
	movq	%rax, %rbx
	call	_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l@PLT
	vmovsd	-248(%rbp), %xmm0
	movq	%rbx, %rdi
	call	_ZNSo9_M_insertIdEERSoT_@PLT
	movl	$8, %edx
	leaq	.LC18(%rip), %rsi
	movq	%rax, %rdi
	movq	%rax, %rbx
	call	_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l@PLT
	vmovsd	-272(%rbp), %xmm3
	movq	%rbx, %rdi
	vmovsd	%xmm3, %xmm3, %xmm0
	call	_ZNSo9_M_insertIdEERSoT_@PLT
	movl	$1, %edx
	leaq	.LC19(%rip), %rsi
	movq	%rax, %rdi
	call	_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l@PLT
	cmpq	%r15, %r12
	jne	.L165
.L181:
	addq	$8, %r14
	cmpq	%r14, -280(%rbp)
	jne	.L166
	testb	%r13b, %r13b
	je	.L183
	leaq	.LC21(%rip), %rsi
	leaq	_ZSt4cout(%rip), %rdi
	call	_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.isra.0
	leaq	.LC22(%rip), %rsi
	leaq	_ZSt4cout(%rip), %rdi
	call	_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.isra.0
	leaq	.LC23(%rip), %rsi
	leaq	_ZSt4cout(%rip), %rdi
	call	_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.isra.0
	leaq	.LC24(%rip), %rsi
	leaq	_ZSt4cout(%rip), %rdi
	call	_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.isra.0
	leaq	.LC25(%rip), %rsi
	leaq	_ZSt4cout(%rip), %rdi
	call	_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.isra.0
	leaq	.LC26(%rip), %rsi
	leaq	_ZSt4cout(%rip), %rdi
	call	_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.isra.0
	leaq	.LC27(%rip), %rsi
	leaq	_ZSt4cout(%rip), %rdi
	call	_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.isra.0
	leaq	.LC28(%rip), %rsi
	leaq	_ZSt4cout(%rip), %rdi
	call	_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.isra.0
	leaq	.LC29(%rip), %rsi
	leaq	_ZSt4cout(%rip), %rdi
	call	_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.isra.0
	leaq	.LC19(%rip), %rsi
	leaq	_ZSt4cout(%rip), %rdi
	call	_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.isra.0
	leaq	.LC30(%rip), %rsi
	leaq	_ZSt4cout(%rip), %rdi
	call	_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.isra.0
	leaq	.LC31(%rip), %rsi
	leaq	_ZSt4cout(%rip), %rdi
	call	_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.isra.0
	movq	_ZN9benchmark16PrintDefaultHelpEv@GOTPCREL(%rip), %rdx
	movq	-296(%rbp), %rsi
	leaq	-212(%rbp), %rdi
	call	_ZN9benchmark10InitializeEPiPPcPFvvE@PLT
	call	_ZN9benchmark22RunSpecifiedBenchmarksEv@PLT
	call	_ZN9benchmark8ShutdownEv@PLT
	xorl	%eax, %eax
.L149:
	movq	-56(%rbp), %rdx
	subq	%fs:40, %rdx
	jne	.L184
	addq	$256, %rsp
	popq	%rbx
	popq	%r10
	.cfi_remember_state
	.cfi_def_cfa 10, 0
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	leaq	-8(%r10), %rsp
	.cfi_def_cfa 7, 8
	ret
	.p2align 4,,10
	.p2align 3
.L177:
	.cfi_restore_state
	vmovsd	%xmm0, %xmm0, %xmm4
.L155:
	vmovsd	-232(%rbp), %xmm7
	vsubsd	%xmm1, %xmm7, %xmm0
	vandpd	.LC8(%rip), %xmm0, %xmm0
	vdivsd	%xmm4, %xmm0, %xmm0
	vmovsd	.LC10(%rip), %xmm4
	vcomisd	%xmm0, %xmm4
	jbe	.L152
	jmp	.L154
	.p2align 4,,10
	.p2align 3
.L178:
	vmovsd	%xmm0, %xmm0, %xmm4
.L158:
	vmovsd	-240(%rbp), %xmm7
	vsubsd	%xmm1, %xmm7, %xmm0
	vandpd	.LC8(%rip), %xmm0, %xmm0
	vdivsd	%xmm4, %xmm0, %xmm0
	vmovsd	.LC10(%rip), %xmm4
	vcomisd	%xmm0, %xmm4
	jbe	.L152
	jmp	.L157
	.p2align 4,,10
	.p2align 3
.L179:
	vmovsd	%xmm0, %xmm0, %xmm4
.L161:
	vmovsd	-248(%rbp), %xmm7
	vsubsd	%xmm1, %xmm7, %xmm0
	vandpd	.LC8(%rip), %xmm0, %xmm0
	vdivsd	%xmm4, %xmm0, %xmm0
	vmovsd	.LC10(%rip), %xmm4
	vcomisd	%xmm0, %xmm4
	jbe	.L152
	jmp	.L160
	.p2align 4,,10
	.p2align 3
.L180:
	vmovsd	%xmm0, %xmm0, %xmm4
.L164:
	vsubsd	%xmm1, %xmm3, %xmm0
	vandpd	.LC8(%rip), %xmm0, %xmm0
	vdivsd	%xmm4, %xmm0, %xmm0
	vmovsd	.LC10(%rip), %xmm4
	vcomisd	%xmm0, %xmm4
	ja	.L174
	jmp	.L152
	.p2align 4,,10
	.p2align 3
.L176:
	vmovsd	%xmm0, %xmm0, %xmm5
	jmp	.L151
.L183:
	leaq	.LC20(%rip), %rsi
	leaq	_ZSt4cerr(%rip), %rdi
	call	_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.isra.0
	movl	$1, %eax
	jmp	.L149
.L184:
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE13401:
	.size	main, .-main
	.section	.text._ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_disposeEv,"axG",@progbits,_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_disposeEv,comdat
	.align 2
	.p2align 4
	.weak	_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_disposeEv
	.type	_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_disposeEv, @function
_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_disposeEv:
.LFB14018:
	.cfi_startproc
	endbr64
	movq	(%rdi), %rax
	leaq	16(%rdi), %rdx
	cmpq	%rdx, %rax
	je	.L187
	movq	16(%rdi), %rsi
	movq	%rax, %rdi
	addq	$1, %rsi
	jmp	_ZdlPvm@PLT
	.p2align 4,,10
	.p2align 3
.L187:
	ret
	.cfi_endproc
.LFE14018:
	.size	_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_disposeEv, .-_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_disposeEv
	.section	.text._ZSt11make_uniqueIN9benchmark8internal17FunctionBenchmarkEJRA19_KcPFvRNS0_5StateEEEENSt8__detail9_MakeUniqIT_E15__single_objectEDpOT0_,"axG",@progbits,_ZSt11make_uniqueIN9benchmark8internal17FunctionBenchmarkEJRA19_KcPFvRNS0_5StateEEEENSt8__detail9_MakeUniqIT_E15__single_objectEDpOT0_,comdat
	.p2align 4
	.weak	_ZSt11make_uniqueIN9benchmark8internal17FunctionBenchmarkEJRA19_KcPFvRNS0_5StateEEEENSt8__detail9_MakeUniqIT_E15__single_objectEDpOT0_
	.type	_ZSt11make_uniqueIN9benchmark8internal17FunctionBenchmarkEJRA19_KcPFvRNS0_5StateEEEENSt8__detail9_MakeUniqIT_E15__single_objectEDpOT0_, @function
_ZSt11make_uniqueIN9benchmark8internal17FunctionBenchmarkEJRA19_KcPFvRNS0_5StateEEEENSt8__detail9_MakeUniqIT_E15__single_objectEDpOT0_:
.LFB13981:
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gxx_personality_v0
	.cfi_lsda 0x1b,.LLSDA13981
	endbr64
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	movq	%rsi, %r13
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	movq	%rdi, %r12
	movl	$312, %edi
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	movq	%rdx, %rbx
	subq	$56, %rsp
	.cfi_def_cfa_offset 112
	movq	%fs:40, %rax
	movq	%rax, 40(%rsp)
	xorl	%eax, %eax
	leaq	16(%rsp), %r14
.LEHB0:
	call	_Znwm@PLT
.LEHE0:
	movq	%r13, %rdi
	movq	%r14, (%rsp)
	movq	(%rbx), %r15
	movq	%rax, %rbp
	call	strlen@PLT
	movq	%rax, %rbx
	cmpq	$15, %rax
	ja	.L206
	cmpq	$1, %rax
	je	.L207
	testq	%rax, %rax
	jne	.L208
.L193:
	movq	%r14, %rax
.L192:
	movq	%rbx, 8(%rsp)
	movq	%rbp, %rdi
	movb	$0, (%rax,%rbx)
	movq	%rsp, %rbx
	movq	%rbx, %rsi
.LEHB1:
	call	_ZN9benchmark9BenchmarkC2ERKNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEE@PLT
.LEHE1:
	movq	(%rsp), %rdi
	leaq	16+_ZTVN9benchmark8internal17FunctionBenchmarkE(%rip), %rax
	movq	%r15, 304(%rbp)
	movq	%rax, 0(%rbp)
	movq	%rbp, (%r12)
	cmpq	%r14, %rdi
	je	.L188
	movq	16(%rsp), %rax
	leaq	1(%rax), %rsi
	call	_ZdlPvm@PLT
.L188:
	movq	40(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L205
	addq	$56, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	movq	%r12, %rax
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%rbp
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L207:
	.cfi_restore_state
	movzbl	0(%r13), %eax
	movb	%al, 16(%rsp)
	jmp	.L193
	.p2align 4,,10
	.p2align 3
.L206:
	leaq	1(%rax), %rdi
.LEHB2:
	call	_Znwm@PLT
.LEHE2:
	movq	%rax, (%rsp)
	movq	%rax, %rdi
	movq	%rbx, 16(%rsp)
.L190:
	movq	%rbx, %rdx
	movq	%r13, %rsi
	call	memcpy@PLT
	movq	(%rsp), %rax
	jmp	.L192
	.p2align 4,,10
	.p2align 3
.L208:
	movq	%r14, %rdi
	jmp	.L190
.L195:
	movq	%rbx, %rdi
	vzeroupper
	call	_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_disposeEv
.L196:
	movl	$312, %esi
	movq	%rbp, %rdi
	vzeroupper
	call	_ZdlPvm@PLT
	movq	40(%rsp), %rax
	subq	%fs:40, %rax
	je	.L197
.L205:
	call	__stack_chk_fail@PLT
.L200:
	endbr64
	movq	%rax, %r12
	jmp	.L195
.L199:
	endbr64
	movq	%rax, %r12
	jmp	.L196
.L197:
	movq	%r12, %rdi
.LEHB3:
	call	_Unwind_Resume@PLT
.LEHE3:
	.cfi_endproc
.LFE13981:
	.globl	__gxx_personality_v0
	.section	.gcc_except_table._ZSt11make_uniqueIN9benchmark8internal17FunctionBenchmarkEJRA19_KcPFvRNS0_5StateEEEENSt8__detail9_MakeUniqIT_E15__single_objectEDpOT0_,"aG",@progbits,_ZSt11make_uniqueIN9benchmark8internal17FunctionBenchmarkEJRA19_KcPFvRNS0_5StateEEEENSt8__detail9_MakeUniqIT_E15__single_objectEDpOT0_,comdat
.LLSDA13981:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSE13981-.LLSDACSB13981
.LLSDACSB13981:
	.uleb128 .LEHB0-.LFB13981
	.uleb128 .LEHE0-.LEHB0
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB1-.LFB13981
	.uleb128 .LEHE1-.LEHB1
	.uleb128 .L200-.LFB13981
	.uleb128 0
	.uleb128 .LEHB2-.LFB13981
	.uleb128 .LEHE2-.LEHB2
	.uleb128 .L199-.LFB13981
	.uleb128 0
	.uleb128 .LEHB3-.LFB13981
	.uleb128 .LEHE3-.LEHB3
	.uleb128 0
	.uleb128 0
.LLSDACSE13981:
	.section	.text._ZSt11make_uniqueIN9benchmark8internal17FunctionBenchmarkEJRA19_KcPFvRNS0_5StateEEEENSt8__detail9_MakeUniqIT_E15__single_objectEDpOT0_,"axG",@progbits,_ZSt11make_uniqueIN9benchmark8internal17FunctionBenchmarkEJRA19_KcPFvRNS0_5StateEEEENSt8__detail9_MakeUniqIT_E15__single_objectEDpOT0_,comdat
	.size	_ZSt11make_uniqueIN9benchmark8internal17FunctionBenchmarkEJRA19_KcPFvRNS0_5StateEEEENSt8__detail9_MakeUniqIT_E15__single_objectEDpOT0_, .-_ZSt11make_uniqueIN9benchmark8internal17FunctionBenchmarkEJRA19_KcPFvRNS0_5StateEEEENSt8__detail9_MakeUniqIT_E15__single_objectEDpOT0_
	.section	.text._ZSt11make_uniqueIN9benchmark8internal17FunctionBenchmarkEJRA21_KcPFvRNS0_5StateEEEENSt8__detail9_MakeUniqIT_E15__single_objectEDpOT0_,"axG",@progbits,_ZSt11make_uniqueIN9benchmark8internal17FunctionBenchmarkEJRA21_KcPFvRNS0_5StateEEEENSt8__detail9_MakeUniqIT_E15__single_objectEDpOT0_,comdat
	.p2align 4
	.weak	_ZSt11make_uniqueIN9benchmark8internal17FunctionBenchmarkEJRA21_KcPFvRNS0_5StateEEEENSt8__detail9_MakeUniqIT_E15__single_objectEDpOT0_
	.type	_ZSt11make_uniqueIN9benchmark8internal17FunctionBenchmarkEJRA21_KcPFvRNS0_5StateEEEENSt8__detail9_MakeUniqIT_E15__single_objectEDpOT0_, @function
_ZSt11make_uniqueIN9benchmark8internal17FunctionBenchmarkEJRA21_KcPFvRNS0_5StateEEEENSt8__detail9_MakeUniqIT_E15__single_objectEDpOT0_:
.LFB13984:
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gxx_personality_v0
	.cfi_lsda 0x1b,.LLSDA13984
	endbr64
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	movq	%rsi, %r13
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	movq	%rdi, %r12
	movl	$312, %edi
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	movq	%rdx, %rbx
	subq	$56, %rsp
	.cfi_def_cfa_offset 112
	movq	%fs:40, %rax
	movq	%rax, 40(%rsp)
	xorl	%eax, %eax
	leaq	16(%rsp), %r14
.LEHB4:
	call	_Znwm@PLT
.LEHE4:
	movq	%r13, %rdi
	movq	%r14, (%rsp)
	movq	(%rbx), %r15
	movq	%rax, %rbp
	call	strlen@PLT
	movq	%rax, %rbx
	cmpq	$15, %rax
	ja	.L227
	cmpq	$1, %rax
	je	.L228
	testq	%rax, %rax
	jne	.L229
.L214:
	movq	%r14, %rax
.L213:
	movq	%rbx, 8(%rsp)
	movq	%rbp, %rdi
	movb	$0, (%rax,%rbx)
	movq	%rsp, %rbx
	movq	%rbx, %rsi
.LEHB5:
	call	_ZN9benchmark9BenchmarkC2ERKNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEE@PLT
.LEHE5:
	movq	(%rsp), %rdi
	leaq	16+_ZTVN9benchmark8internal17FunctionBenchmarkE(%rip), %rax
	movq	%r15, 304(%rbp)
	movq	%rax, 0(%rbp)
	movq	%rbp, (%r12)
	cmpq	%r14, %rdi
	je	.L209
	movq	16(%rsp), %rax
	leaq	1(%rax), %rsi
	call	_ZdlPvm@PLT
.L209:
	movq	40(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L226
	addq	$56, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	movq	%r12, %rax
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%rbp
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L228:
	.cfi_restore_state
	movzbl	0(%r13), %eax
	movb	%al, 16(%rsp)
	jmp	.L214
	.p2align 4,,10
	.p2align 3
.L227:
	leaq	1(%rax), %rdi
.LEHB6:
	call	_Znwm@PLT
.LEHE6:
	movq	%rax, (%rsp)
	movq	%rax, %rdi
	movq	%rbx, 16(%rsp)
.L211:
	movq	%rbx, %rdx
	movq	%r13, %rsi
	call	memcpy@PLT
	movq	(%rsp), %rax
	jmp	.L213
	.p2align 4,,10
	.p2align 3
.L229:
	movq	%r14, %rdi
	jmp	.L211
.L216:
	movq	%rbx, %rdi
	vzeroupper
	call	_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_disposeEv
.L217:
	movl	$312, %esi
	movq	%rbp, %rdi
	vzeroupper
	call	_ZdlPvm@PLT
	movq	40(%rsp), %rax
	subq	%fs:40, %rax
	je	.L218
.L226:
	call	__stack_chk_fail@PLT
.L221:
	endbr64
	movq	%rax, %r12
	jmp	.L216
.L220:
	endbr64
	movq	%rax, %r12
	jmp	.L217
.L218:
	movq	%r12, %rdi
.LEHB7:
	call	_Unwind_Resume@PLT
.LEHE7:
	.cfi_endproc
.LFE13984:
	.section	.gcc_except_table._ZSt11make_uniqueIN9benchmark8internal17FunctionBenchmarkEJRA21_KcPFvRNS0_5StateEEEENSt8__detail9_MakeUniqIT_E15__single_objectEDpOT0_,"aG",@progbits,_ZSt11make_uniqueIN9benchmark8internal17FunctionBenchmarkEJRA21_KcPFvRNS0_5StateEEEENSt8__detail9_MakeUniqIT_E15__single_objectEDpOT0_,comdat
.LLSDA13984:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSE13984-.LLSDACSB13984
.LLSDACSB13984:
	.uleb128 .LEHB4-.LFB13984
	.uleb128 .LEHE4-.LEHB4
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB5-.LFB13984
	.uleb128 .LEHE5-.LEHB5
	.uleb128 .L221-.LFB13984
	.uleb128 0
	.uleb128 .LEHB6-.LFB13984
	.uleb128 .LEHE6-.LEHB6
	.uleb128 .L220-.LFB13984
	.uleb128 0
	.uleb128 .LEHB7-.LFB13984
	.uleb128 .LEHE7-.LEHB7
	.uleb128 0
	.uleb128 0
.LLSDACSE13984:
	.section	.text._ZSt11make_uniqueIN9benchmark8internal17FunctionBenchmarkEJRA21_KcPFvRNS0_5StateEEEENSt8__detail9_MakeUniqIT_E15__single_objectEDpOT0_,"axG",@progbits,_ZSt11make_uniqueIN9benchmark8internal17FunctionBenchmarkEJRA21_KcPFvRNS0_5StateEEEENSt8__detail9_MakeUniqIT_E15__single_objectEDpOT0_,comdat
	.size	_ZSt11make_uniqueIN9benchmark8internal17FunctionBenchmarkEJRA21_KcPFvRNS0_5StateEEEENSt8__detail9_MakeUniqIT_E15__single_objectEDpOT0_, .-_ZSt11make_uniqueIN9benchmark8internal17FunctionBenchmarkEJRA21_KcPFvRNS0_5StateEEEENSt8__detail9_MakeUniqIT_E15__single_objectEDpOT0_
	.section	.text._ZSt11make_uniqueIN9benchmark8internal17FunctionBenchmarkEJRA15_KcPFvRNS0_5StateEEEENSt8__detail9_MakeUniqIT_E15__single_objectEDpOT0_,"axG",@progbits,_ZSt11make_uniqueIN9benchmark8internal17FunctionBenchmarkEJRA15_KcPFvRNS0_5StateEEEENSt8__detail9_MakeUniqIT_E15__single_objectEDpOT0_,comdat
	.p2align 4
	.weak	_ZSt11make_uniqueIN9benchmark8internal17FunctionBenchmarkEJRA15_KcPFvRNS0_5StateEEEENSt8__detail9_MakeUniqIT_E15__single_objectEDpOT0_
	.type	_ZSt11make_uniqueIN9benchmark8internal17FunctionBenchmarkEJRA15_KcPFvRNS0_5StateEEEENSt8__detail9_MakeUniqIT_E15__single_objectEDpOT0_, @function
_ZSt11make_uniqueIN9benchmark8internal17FunctionBenchmarkEJRA15_KcPFvRNS0_5StateEEEENSt8__detail9_MakeUniqIT_E15__single_objectEDpOT0_:
.LFB13985:
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gxx_personality_v0
	.cfi_lsda 0x1b,.LLSDA13985
	endbr64
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	movq	%rsi, %r13
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	movq	%rdi, %r12
	movl	$312, %edi
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	movq	%rdx, %rbx
	subq	$56, %rsp
	.cfi_def_cfa_offset 112
	movq	%fs:40, %rax
	movq	%rax, 40(%rsp)
	xorl	%eax, %eax
	leaq	16(%rsp), %r14
.LEHB8:
	call	_Znwm@PLT
.LEHE8:
	movq	%r13, %rdi
	movq	%r14, (%rsp)
	movq	(%rbx), %r15
	movq	%rax, %rbp
	call	strlen@PLT
	movq	%rax, %rbx
	cmpq	$15, %rax
	ja	.L248
	cmpq	$1, %rax
	je	.L249
	testq	%rax, %rax
	jne	.L250
.L235:
	movq	%r14, %rax
.L234:
	movq	%rbx, 8(%rsp)
	movq	%rbp, %rdi
	movb	$0, (%rax,%rbx)
	movq	%rsp, %rbx
	movq	%rbx, %rsi
.LEHB9:
	call	_ZN9benchmark9BenchmarkC2ERKNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEE@PLT
.LEHE9:
	movq	(%rsp), %rdi
	leaq	16+_ZTVN9benchmark8internal17FunctionBenchmarkE(%rip), %rax
	movq	%r15, 304(%rbp)
	movq	%rax, 0(%rbp)
	movq	%rbp, (%r12)
	cmpq	%r14, %rdi
	je	.L230
	movq	16(%rsp), %rax
	leaq	1(%rax), %rsi
	call	_ZdlPvm@PLT
.L230:
	movq	40(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L247
	addq	$56, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	movq	%r12, %rax
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%rbp
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L249:
	.cfi_restore_state
	movzbl	0(%r13), %eax
	movb	%al, 16(%rsp)
	jmp	.L235
	.p2align 4,,10
	.p2align 3
.L248:
	leaq	1(%rax), %rdi
.LEHB10:
	call	_Znwm@PLT
.LEHE10:
	movq	%rax, (%rsp)
	movq	%rax, %rdi
	movq	%rbx, 16(%rsp)
.L232:
	movq	%rbx, %rdx
	movq	%r13, %rsi
	call	memcpy@PLT
	movq	(%rsp), %rax
	jmp	.L234
	.p2align 4,,10
	.p2align 3
.L250:
	movq	%r14, %rdi
	jmp	.L232
.L237:
	movq	%rbx, %rdi
	vzeroupper
	call	_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_disposeEv
.L238:
	movl	$312, %esi
	movq	%rbp, %rdi
	vzeroupper
	call	_ZdlPvm@PLT
	movq	40(%rsp), %rax
	subq	%fs:40, %rax
	je	.L239
.L247:
	call	__stack_chk_fail@PLT
.L242:
	endbr64
	movq	%rax, %r12
	jmp	.L237
.L241:
	endbr64
	movq	%rax, %r12
	jmp	.L238
.L239:
	movq	%r12, %rdi
.LEHB11:
	call	_Unwind_Resume@PLT
.LEHE11:
	.cfi_endproc
.LFE13985:
	.section	.gcc_except_table._ZSt11make_uniqueIN9benchmark8internal17FunctionBenchmarkEJRA15_KcPFvRNS0_5StateEEEENSt8__detail9_MakeUniqIT_E15__single_objectEDpOT0_,"aG",@progbits,_ZSt11make_uniqueIN9benchmark8internal17FunctionBenchmarkEJRA15_KcPFvRNS0_5StateEEEENSt8__detail9_MakeUniqIT_E15__single_objectEDpOT0_,comdat
.LLSDA13985:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSE13985-.LLSDACSB13985
.LLSDACSB13985:
	.uleb128 .LEHB8-.LFB13985
	.uleb128 .LEHE8-.LEHB8
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB9-.LFB13985
	.uleb128 .LEHE9-.LEHB9
	.uleb128 .L242-.LFB13985
	.uleb128 0
	.uleb128 .LEHB10-.LFB13985
	.uleb128 .LEHE10-.LEHB10
	.uleb128 .L241-.LFB13985
	.uleb128 0
	.uleb128 .LEHB11-.LFB13985
	.uleb128 .LEHE11-.LEHB11
	.uleb128 0
	.uleb128 0
.LLSDACSE13985:
	.section	.text._ZSt11make_uniqueIN9benchmark8internal17FunctionBenchmarkEJRA15_KcPFvRNS0_5StateEEEENSt8__detail9_MakeUniqIT_E15__single_objectEDpOT0_,"axG",@progbits,_ZSt11make_uniqueIN9benchmark8internal17FunctionBenchmarkEJRA15_KcPFvRNS0_5StateEEEENSt8__detail9_MakeUniqIT_E15__single_objectEDpOT0_,comdat
	.size	_ZSt11make_uniqueIN9benchmark8internal17FunctionBenchmarkEJRA15_KcPFvRNS0_5StateEEEENSt8__detail9_MakeUniqIT_E15__single_objectEDpOT0_, .-_ZSt11make_uniqueIN9benchmark8internal17FunctionBenchmarkEJRA15_KcPFvRNS0_5StateEEEENSt8__detail9_MakeUniqIT_E15__single_objectEDpOT0_
	.section	.text._ZSt11make_uniqueIN9benchmark8internal17FunctionBenchmarkEJRA20_KcPFvRNS0_5StateEEEENSt8__detail9_MakeUniqIT_E15__single_objectEDpOT0_,"axG",@progbits,_ZSt11make_uniqueIN9benchmark8internal17FunctionBenchmarkEJRA20_KcPFvRNS0_5StateEEEENSt8__detail9_MakeUniqIT_E15__single_objectEDpOT0_,comdat
	.p2align 4
	.weak	_ZSt11make_uniqueIN9benchmark8internal17FunctionBenchmarkEJRA20_KcPFvRNS0_5StateEEEENSt8__detail9_MakeUniqIT_E15__single_objectEDpOT0_
	.type	_ZSt11make_uniqueIN9benchmark8internal17FunctionBenchmarkEJRA20_KcPFvRNS0_5StateEEEENSt8__detail9_MakeUniqIT_E15__single_objectEDpOT0_, @function
_ZSt11make_uniqueIN9benchmark8internal17FunctionBenchmarkEJRA20_KcPFvRNS0_5StateEEEENSt8__detail9_MakeUniqIT_E15__single_objectEDpOT0_:
.LFB13986:
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gxx_personality_v0
	.cfi_lsda 0x1b,.LLSDA13986
	endbr64
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	movq	%rsi, %r13
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	movq	%rdi, %r12
	movl	$312, %edi
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	movq	%rdx, %rbx
	subq	$56, %rsp
	.cfi_def_cfa_offset 112
	movq	%fs:40, %rax
	movq	%rax, 40(%rsp)
	xorl	%eax, %eax
	leaq	16(%rsp), %r14
.LEHB12:
	call	_Znwm@PLT
.LEHE12:
	movq	%r13, %rdi
	movq	%r14, (%rsp)
	movq	(%rbx), %r15
	movq	%rax, %rbp
	call	strlen@PLT
	movq	%rax, %rbx
	cmpq	$15, %rax
	ja	.L269
	cmpq	$1, %rax
	je	.L270
	testq	%rax, %rax
	jne	.L271
.L256:
	movq	%r14, %rax
.L255:
	movq	%rbx, 8(%rsp)
	movq	%rbp, %rdi
	movb	$0, (%rax,%rbx)
	movq	%rsp, %rbx
	movq	%rbx, %rsi
.LEHB13:
	call	_ZN9benchmark9BenchmarkC2ERKNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEE@PLT
.LEHE13:
	movq	(%rsp), %rdi
	leaq	16+_ZTVN9benchmark8internal17FunctionBenchmarkE(%rip), %rax
	movq	%r15, 304(%rbp)
	movq	%rax, 0(%rbp)
	movq	%rbp, (%r12)
	cmpq	%r14, %rdi
	je	.L251
	movq	16(%rsp), %rax
	leaq	1(%rax), %rsi
	call	_ZdlPvm@PLT
.L251:
	movq	40(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L268
	addq	$56, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	movq	%r12, %rax
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%rbp
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L270:
	.cfi_restore_state
	movzbl	0(%r13), %eax
	movb	%al, 16(%rsp)
	jmp	.L256
	.p2align 4,,10
	.p2align 3
.L269:
	leaq	1(%rax), %rdi
.LEHB14:
	call	_Znwm@PLT
.LEHE14:
	movq	%rax, (%rsp)
	movq	%rax, %rdi
	movq	%rbx, 16(%rsp)
.L253:
	movq	%rbx, %rdx
	movq	%r13, %rsi
	call	memcpy@PLT
	movq	(%rsp), %rax
	jmp	.L255
	.p2align 4,,10
	.p2align 3
.L271:
	movq	%r14, %rdi
	jmp	.L253
.L258:
	movq	%rbx, %rdi
	vzeroupper
	call	_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_disposeEv
.L259:
	movl	$312, %esi
	movq	%rbp, %rdi
	vzeroupper
	call	_ZdlPvm@PLT
	movq	40(%rsp), %rax
	subq	%fs:40, %rax
	je	.L260
.L268:
	call	__stack_chk_fail@PLT
.L263:
	endbr64
	movq	%rax, %r12
	jmp	.L258
.L262:
	endbr64
	movq	%rax, %r12
	jmp	.L259
.L260:
	movq	%r12, %rdi
.LEHB15:
	call	_Unwind_Resume@PLT
.LEHE15:
	.cfi_endproc
.LFE13986:
	.section	.gcc_except_table._ZSt11make_uniqueIN9benchmark8internal17FunctionBenchmarkEJRA20_KcPFvRNS0_5StateEEEENSt8__detail9_MakeUniqIT_E15__single_objectEDpOT0_,"aG",@progbits,_ZSt11make_uniqueIN9benchmark8internal17FunctionBenchmarkEJRA20_KcPFvRNS0_5StateEEEENSt8__detail9_MakeUniqIT_E15__single_objectEDpOT0_,comdat
.LLSDA13986:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSE13986-.LLSDACSB13986
.LLSDACSB13986:
	.uleb128 .LEHB12-.LFB13986
	.uleb128 .LEHE12-.LEHB12
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB13-.LFB13986
	.uleb128 .LEHE13-.LEHB13
	.uleb128 .L263-.LFB13986
	.uleb128 0
	.uleb128 .LEHB14-.LFB13986
	.uleb128 .LEHE14-.LEHB14
	.uleb128 .L262-.LFB13986
	.uleb128 0
	.uleb128 .LEHB15-.LFB13986
	.uleb128 .LEHE15-.LEHB15
	.uleb128 0
	.uleb128 0
.LLSDACSE13986:
	.section	.text._ZSt11make_uniqueIN9benchmark8internal17FunctionBenchmarkEJRA20_KcPFvRNS0_5StateEEEENSt8__detail9_MakeUniqIT_E15__single_objectEDpOT0_,"axG",@progbits,_ZSt11make_uniqueIN9benchmark8internal17FunctionBenchmarkEJRA20_KcPFvRNS0_5StateEEEENSt8__detail9_MakeUniqIT_E15__single_objectEDpOT0_,comdat
	.size	_ZSt11make_uniqueIN9benchmark8internal17FunctionBenchmarkEJRA20_KcPFvRNS0_5StateEEEENSt8__detail9_MakeUniqIT_E15__single_objectEDpOT0_, .-_ZSt11make_uniqueIN9benchmark8internal17FunctionBenchmarkEJRA20_KcPFvRNS0_5StateEEEENSt8__detail9_MakeUniqIT_E15__single_objectEDpOT0_
	.section	.text._ZSt11make_uniqueIN9benchmark8internal17FunctionBenchmarkEJRA17_KcPFvRNS0_5StateEEEENSt8__detail9_MakeUniqIT_E15__single_objectEDpOT0_,"axG",@progbits,_ZSt11make_uniqueIN9benchmark8internal17FunctionBenchmarkEJRA17_KcPFvRNS0_5StateEEEENSt8__detail9_MakeUniqIT_E15__single_objectEDpOT0_,comdat
	.p2align 4
	.weak	_ZSt11make_uniqueIN9benchmark8internal17FunctionBenchmarkEJRA17_KcPFvRNS0_5StateEEEENSt8__detail9_MakeUniqIT_E15__single_objectEDpOT0_
	.type	_ZSt11make_uniqueIN9benchmark8internal17FunctionBenchmarkEJRA17_KcPFvRNS0_5StateEEEENSt8__detail9_MakeUniqIT_E15__single_objectEDpOT0_, @function
_ZSt11make_uniqueIN9benchmark8internal17FunctionBenchmarkEJRA17_KcPFvRNS0_5StateEEEENSt8__detail9_MakeUniqIT_E15__single_objectEDpOT0_:
.LFB13982:
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gxx_personality_v0
	.cfi_lsda 0x1b,.LLSDA13982
	endbr64
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	movq	%rsi, %r13
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	movq	%rdi, %r12
	movl	$312, %edi
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	movq	%rdx, %rbx
	subq	$56, %rsp
	.cfi_def_cfa_offset 112
	movq	%fs:40, %rax
	movq	%rax, 40(%rsp)
	xorl	%eax, %eax
	leaq	16(%rsp), %r14
.LEHB16:
	call	_Znwm@PLT
.LEHE16:
	movq	%r13, %rdi
	movq	%r14, (%rsp)
	movq	(%rbx), %r15
	movq	%rax, %rbp
	call	strlen@PLT
	movq	%rax, %rbx
	cmpq	$15, %rax
	ja	.L290
	cmpq	$1, %rax
	je	.L291
	testq	%rax, %rax
	jne	.L292
.L277:
	movq	%r14, %rax
.L276:
	movq	%rbx, 8(%rsp)
	movq	%rbp, %rdi
	movb	$0, (%rax,%rbx)
	movq	%rsp, %rbx
	movq	%rbx, %rsi
.LEHB17:
	call	_ZN9benchmark9BenchmarkC2ERKNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEE@PLT
.LEHE17:
	movq	(%rsp), %rdi
	leaq	16+_ZTVN9benchmark8internal17FunctionBenchmarkE(%rip), %rax
	movq	%r15, 304(%rbp)
	movq	%rax, 0(%rbp)
	movq	%rbp, (%r12)
	cmpq	%r14, %rdi
	je	.L272
	movq	16(%rsp), %rax
	leaq	1(%rax), %rsi
	call	_ZdlPvm@PLT
.L272:
	movq	40(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L289
	addq	$56, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	movq	%r12, %rax
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%rbp
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L291:
	.cfi_restore_state
	movzbl	0(%r13), %eax
	movb	%al, 16(%rsp)
	jmp	.L277
	.p2align 4,,10
	.p2align 3
.L290:
	leaq	1(%rax), %rdi
.LEHB18:
	call	_Znwm@PLT
.LEHE18:
	movq	%rax, (%rsp)
	movq	%rax, %rdi
	movq	%rbx, 16(%rsp)
.L274:
	movq	%rbx, %rdx
	movq	%r13, %rsi
	call	memcpy@PLT
	movq	(%rsp), %rax
	jmp	.L276
	.p2align 4,,10
	.p2align 3
.L292:
	movq	%r14, %rdi
	jmp	.L274
.L279:
	movq	%rbx, %rdi
	vzeroupper
	call	_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_disposeEv
.L280:
	movl	$312, %esi
	movq	%rbp, %rdi
	vzeroupper
	call	_ZdlPvm@PLT
	movq	40(%rsp), %rax
	subq	%fs:40, %rax
	je	.L281
.L289:
	call	__stack_chk_fail@PLT
.L284:
	endbr64
	movq	%rax, %r12
	jmp	.L279
.L283:
	endbr64
	movq	%rax, %r12
	jmp	.L280
.L281:
	movq	%r12, %rdi
.LEHB19:
	call	_Unwind_Resume@PLT
.LEHE19:
	.cfi_endproc
.LFE13982:
	.section	.gcc_except_table._ZSt11make_uniqueIN9benchmark8internal17FunctionBenchmarkEJRA17_KcPFvRNS0_5StateEEEENSt8__detail9_MakeUniqIT_E15__single_objectEDpOT0_,"aG",@progbits,_ZSt11make_uniqueIN9benchmark8internal17FunctionBenchmarkEJRA17_KcPFvRNS0_5StateEEEENSt8__detail9_MakeUniqIT_E15__single_objectEDpOT0_,comdat
.LLSDA13982:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSE13982-.LLSDACSB13982
.LLSDACSB13982:
	.uleb128 .LEHB16-.LFB13982
	.uleb128 .LEHE16-.LEHB16
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB17-.LFB13982
	.uleb128 .LEHE17-.LEHB17
	.uleb128 .L284-.LFB13982
	.uleb128 0
	.uleb128 .LEHB18-.LFB13982
	.uleb128 .LEHE18-.LEHB18
	.uleb128 .L283-.LFB13982
	.uleb128 0
	.uleb128 .LEHB19-.LFB13982
	.uleb128 .LEHE19-.LEHB19
	.uleb128 0
	.uleb128 0
.LLSDACSE13982:
	.section	.text._ZSt11make_uniqueIN9benchmark8internal17FunctionBenchmarkEJRA17_KcPFvRNS0_5StateEEEENSt8__detail9_MakeUniqIT_E15__single_objectEDpOT0_,"axG",@progbits,_ZSt11make_uniqueIN9benchmark8internal17FunctionBenchmarkEJRA17_KcPFvRNS0_5StateEEEENSt8__detail9_MakeUniqIT_E15__single_objectEDpOT0_,comdat
	.size	_ZSt11make_uniqueIN9benchmark8internal17FunctionBenchmarkEJRA17_KcPFvRNS0_5StateEEEENSt8__detail9_MakeUniqIT_E15__single_objectEDpOT0_, .-_ZSt11make_uniqueIN9benchmark8internal17FunctionBenchmarkEJRA17_KcPFvRNS0_5StateEEEENSt8__detail9_MakeUniqIT_E15__single_objectEDpOT0_
	.section	.text._ZSt11make_uniqueIN9benchmark8internal17FunctionBenchmarkEJRA16_KcPFvRNS0_5StateEEEENSt8__detail9_MakeUniqIT_E15__single_objectEDpOT0_,"axG",@progbits,_ZSt11make_uniqueIN9benchmark8internal17FunctionBenchmarkEJRA16_KcPFvRNS0_5StateEEEENSt8__detail9_MakeUniqIT_E15__single_objectEDpOT0_,comdat
	.p2align 4
	.weak	_ZSt11make_uniqueIN9benchmark8internal17FunctionBenchmarkEJRA16_KcPFvRNS0_5StateEEEENSt8__detail9_MakeUniqIT_E15__single_objectEDpOT0_
	.type	_ZSt11make_uniqueIN9benchmark8internal17FunctionBenchmarkEJRA16_KcPFvRNS0_5StateEEEENSt8__detail9_MakeUniqIT_E15__single_objectEDpOT0_, @function
_ZSt11make_uniqueIN9benchmark8internal17FunctionBenchmarkEJRA16_KcPFvRNS0_5StateEEEENSt8__detail9_MakeUniqIT_E15__single_objectEDpOT0_:
.LFB13983:
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gxx_personality_v0
	.cfi_lsda 0x1b,.LLSDA13983
	endbr64
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	movq	%rsi, %r13
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	movq	%rdi, %r12
	movl	$312, %edi
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	movq	%rdx, %rbx
	subq	$56, %rsp
	.cfi_def_cfa_offset 112
	movq	%fs:40, %rax
	movq	%rax, 40(%rsp)
	xorl	%eax, %eax
	leaq	16(%rsp), %r14
.LEHB20:
	call	_Znwm@PLT
.LEHE20:
	movq	%r13, %rdi
	movq	%r14, (%rsp)
	movq	(%rbx), %r15
	movq	%rax, %rbp
	call	strlen@PLT
	movq	%rax, %rbx
	cmpq	$15, %rax
	ja	.L311
	cmpq	$1, %rax
	je	.L312
	testq	%rax, %rax
	jne	.L313
.L298:
	movq	%r14, %rax
.L297:
	movq	%rbx, 8(%rsp)
	movq	%rbp, %rdi
	movb	$0, (%rax,%rbx)
	movq	%rsp, %rbx
	movq	%rbx, %rsi
.LEHB21:
	call	_ZN9benchmark9BenchmarkC2ERKNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEE@PLT
.LEHE21:
	movq	(%rsp), %rdi
	leaq	16+_ZTVN9benchmark8internal17FunctionBenchmarkE(%rip), %rax
	movq	%r15, 304(%rbp)
	movq	%rax, 0(%rbp)
	movq	%rbp, (%r12)
	cmpq	%r14, %rdi
	je	.L293
	movq	16(%rsp), %rax
	leaq	1(%rax), %rsi
	call	_ZdlPvm@PLT
.L293:
	movq	40(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L310
	addq	$56, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	movq	%r12, %rax
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%rbp
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L312:
	.cfi_restore_state
	movzbl	0(%r13), %eax
	movb	%al, 16(%rsp)
	jmp	.L298
	.p2align 4,,10
	.p2align 3
.L311:
	leaq	1(%rax), %rdi
.LEHB22:
	call	_Znwm@PLT
.LEHE22:
	movq	%rax, (%rsp)
	movq	%rax, %rdi
	movq	%rbx, 16(%rsp)
.L295:
	movq	%rbx, %rdx
	movq	%r13, %rsi
	call	memcpy@PLT
	movq	(%rsp), %rax
	jmp	.L297
	.p2align 4,,10
	.p2align 3
.L313:
	movq	%r14, %rdi
	jmp	.L295
.L300:
	movq	%rbx, %rdi
	vzeroupper
	call	_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_disposeEv
.L301:
	movl	$312, %esi
	movq	%rbp, %rdi
	vzeroupper
	call	_ZdlPvm@PLT
	movq	40(%rsp), %rax
	subq	%fs:40, %rax
	je	.L302
.L310:
	call	__stack_chk_fail@PLT
.L305:
	endbr64
	movq	%rax, %r12
	jmp	.L300
.L304:
	endbr64
	movq	%rax, %r12
	jmp	.L301
.L302:
	movq	%r12, %rdi
.LEHB23:
	call	_Unwind_Resume@PLT
.LEHE23:
	.cfi_endproc
.LFE13983:
	.section	.gcc_except_table._ZSt11make_uniqueIN9benchmark8internal17FunctionBenchmarkEJRA16_KcPFvRNS0_5StateEEEENSt8__detail9_MakeUniqIT_E15__single_objectEDpOT0_,"aG",@progbits,_ZSt11make_uniqueIN9benchmark8internal17FunctionBenchmarkEJRA16_KcPFvRNS0_5StateEEEENSt8__detail9_MakeUniqIT_E15__single_objectEDpOT0_,comdat
.LLSDA13983:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSE13983-.LLSDACSB13983
.LLSDACSB13983:
	.uleb128 .LEHB20-.LFB13983
	.uleb128 .LEHE20-.LEHB20
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB21-.LFB13983
	.uleb128 .LEHE21-.LEHB21
	.uleb128 .L305-.LFB13983
	.uleb128 0
	.uleb128 .LEHB22-.LFB13983
	.uleb128 .LEHE22-.LEHB22
	.uleb128 .L304-.LFB13983
	.uleb128 0
	.uleb128 .LEHB23-.LFB13983
	.uleb128 .LEHE23-.LEHB23
	.uleb128 0
	.uleb128 0
.LLSDACSE13983:
	.section	.text._ZSt11make_uniqueIN9benchmark8internal17FunctionBenchmarkEJRA16_KcPFvRNS0_5StateEEEENSt8__detail9_MakeUniqIT_E15__single_objectEDpOT0_,"axG",@progbits,_ZSt11make_uniqueIN9benchmark8internal17FunctionBenchmarkEJRA16_KcPFvRNS0_5StateEEEENSt8__detail9_MakeUniqIT_E15__single_objectEDpOT0_,comdat
	.size	_ZSt11make_uniqueIN9benchmark8internal17FunctionBenchmarkEJRA16_KcPFvRNS0_5StateEEEENSt8__detail9_MakeUniqIT_E15__single_objectEDpOT0_, .-_ZSt11make_uniqueIN9benchmark8internal17FunctionBenchmarkEJRA16_KcPFvRNS0_5StateEEEENSt8__detail9_MakeUniqIT_E15__single_objectEDpOT0_
	.section	.text._ZNSt8_Rb_treeINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESt4pairIKS5_N9benchmark7CounterEESt10_Select1stISA_ESt4lessIS5_ESaISA_EE24_M_get_insert_unique_posERS7_,"axG",@progbits,_ZNSt8_Rb_treeINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESt4pairIKS5_N9benchmark7CounterEESt10_Select1stISA_ESt4lessIS5_ESaISA_EE24_M_get_insert_unique_posERS7_,comdat
	.align 2
	.p2align 4
	.weak	_ZNSt8_Rb_treeINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESt4pairIKS5_N9benchmark7CounterEESt10_Select1stISA_ESt4lessIS5_ESaISA_EE24_M_get_insert_unique_posERS7_
	.type	_ZNSt8_Rb_treeINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESt4pairIKS5_N9benchmark7CounterEESt10_Select1stISA_ESt4lessIS5_ESaISA_EE24_M_get_insert_unique_posERS7_, @function
_ZNSt8_Rb_treeINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESt4pairIKS5_N9benchmark7CounterEESt10_Select1stISA_ESt4lessIS5_ESaISA_EE24_M_get_insert_unique_posERS7_:
.LFB14658:
	.cfi_startproc
	endbr64
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	subq	$40, %rsp
	.cfi_def_cfa_offset 96
	movq	16(%rdi), %r15
	movq	%rdi, 24(%rsp)
	movq	%rsi, 16(%rsp)
	testq	%r15, %r15
	je	.L341
	movq	(%rsi), %rdx
	movq	8(%rsi), %r14
	movl	$2147483648, %ebp
	movq	%rdx, 8(%rsp)
	jmp	.L322
	.p2align 4,,10
	.p2align 3
.L320:
	movq	16(%r15), %rax
	movl	$1, %esi
	testq	%rax, %rax
	je	.L342
.L327:
	movq	%rax, %r15
.L322:
	movq	40(%r15), %r12
	movq	32(%r15), %r13
	cmpq	%r12, %r14
	movq	%r12, %rbx
	cmovbe	%r14, %rbx
	testq	%rbx, %rbx
	je	.L317
	movq	8(%rsp), %rdi
	movq	%rbx, %rdx
	movq	%r13, %rsi
	call	memcmp@PLT
	testl	%eax, %eax
	jne	.L318
.L317:
	movq	%r14, %rax
	subq	%r12, %rax
	cmpq	%rbp, %rax
	jge	.L319
	movabsq	$-2147483649, %rcx
	cmpq	%rcx, %rax
	jle	.L320
.L318:
	testl	%eax, %eax
	js	.L320
.L319:
	movq	24(%r15), %rax
	xorl	%esi, %esi
	testq	%rax, %rax
	jne	.L327
.L342:
	movq	%r15, %rbp
	testb	%sil, %sil
	jne	.L316
.L323:
	testq	%rbx, %rbx
	je	.L325
	movq	8(%rsp), %rsi
	movq	%rbx, %rdx
	movq	%r13, %rdi
	call	memcmp@PLT
	testl	%eax, %eax
	je	.L325
.L326:
	xorl	%edx, %edx
	testl	%eax, %eax
	cmovns	%rdx, %rbp
	cmovs	%rdx, %r15
.L324:
	addq	$40, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	movq	%r15, %rax
	popq	%rbx
	.cfi_def_cfa_offset 48
	movq	%rbp, %rdx
	popq	%rbp
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L325:
	.cfi_restore_state
	movq	%r12, %rcx
	subq	%r14, %rcx
	cmpq	$2147483647, %rcx
	jg	.L330
	cmpq	$-2147483648, %rcx
	jl	.L331
	movl	%ecx, %eax
	jmp	.L326
	.p2align 4,,10
	.p2align 3
.L341:
	leaq	8(%rdi), %r15
.L316:
	movq	24(%rsp), %rax
	cmpq	%r15, 24(%rax)
	je	.L329
	movq	%r15, %rdi
	movq	%r15, %rbp
	call	_ZSt18_Rb_tree_decrementPSt18_Rb_tree_node_base@PLT
	movq	16(%rsp), %rdx
	movq	40(%rax), %r12
	movq	32(%rax), %r13
	movq	%rax, %r15
	movq	8(%rdx), %r14
	movq	(%rdx), %rcx
	movq	%r12, %rbx
	cmpq	%r12, %r14
	movq	%rcx, 8(%rsp)
	cmovbe	%r14, %rbx
	jmp	.L323
	.p2align 4,,10
	.p2align 3
.L329:
	movq	%r15, %rbp
	xorl	%r15d, %r15d
	jmp	.L324
	.p2align 4,,10
	.p2align 3
.L330:
	xorl	%ebp, %ebp
	jmp	.L324
.L331:
	xorl	%r15d, %r15d
	jmp	.L324
	.cfi_endproc
.LFE14658:
	.size	_ZNSt8_Rb_treeINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESt4pairIKS5_N9benchmark7CounterEESt10_Select1stISA_ESt4lessIS5_ESaISA_EE24_M_get_insert_unique_posERS7_, .-_ZNSt8_Rb_treeINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESt4pairIKS5_N9benchmark7CounterEESt10_Select1stISA_ESt4lessIS5_ESaISA_EE24_M_get_insert_unique_posERS7_
	.section	.text._ZNSt8_Rb_treeINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESt4pairIKS5_N9benchmark7CounterEESt10_Select1stISA_ESt4lessIS5_ESaISA_EE22_M_emplace_hint_uniqueIJRKSt21piecewise_construct_tSt5tupleIJOS5_EESL_IJEEEEESt17_Rb_tree_iteratorISA_ESt23_Rb_tree_const_iteratorISA_EDpOT_,"axG",@progbits,_ZNSt8_Rb_treeINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESt4pairIKS5_N9benchmark7CounterEESt10_Select1stISA_ESt4lessIS5_ESaISA_EE22_M_emplace_hint_uniqueIJRKSt21piecewise_construct_tSt5tupleIJOS5_EESL_IJEEEEESt17_Rb_tree_iteratorISA_ESt23_Rb_tree_const_iteratorISA_EDpOT_,comdat
	.align 2
	.p2align 4
	.weak	_ZNSt8_Rb_treeINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESt4pairIKS5_N9benchmark7CounterEESt10_Select1stISA_ESt4lessIS5_ESaISA_EE22_M_emplace_hint_uniqueIJRKSt21piecewise_construct_tSt5tupleIJOS5_EESL_IJEEEEESt17_Rb_tree_iteratorISA_ESt23_Rb_tree_const_iteratorISA_EDpOT_
	.type	_ZNSt8_Rb_treeINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESt4pairIKS5_N9benchmark7CounterEESt10_Select1stISA_ESt4lessIS5_ESaISA_EE22_M_emplace_hint_uniqueIJRKSt21piecewise_construct_tSt5tupleIJOS5_EESL_IJEEEEESt17_Rb_tree_iteratorISA_ESt23_Rb_tree_const_iteratorISA_EDpOT_, @function
_ZNSt8_Rb_treeINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESt4pairIKS5_N9benchmark7CounterEESt10_Select1stISA_ESt4lessIS5_ESaISA_EE22_M_emplace_hint_uniqueIJRKSt21piecewise_construct_tSt5tupleIJOS5_EESL_IJEEEEESt17_Rb_tree_iteratorISA_ESt23_Rb_tree_const_iteratorISA_EDpOT_:
.LFB14162:
	.cfi_startproc
	endbr64
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	movq	%rcx, %r13
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	movq	%rdi, %r12
	movl	$80, %edi
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	movq	%rsi, %rbp
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	subq	$72, %rsp
	.cfi_def_cfa_offset 128
	call	_Znwm@PLT
	movq	%rax, %rbx
	movq	0(%r13), %rax
	leaq	48(%rbx), %r13
	movq	%r13, 32(%rbx)
	movq	(%rax), %rcx
	leaq	16(%rax), %rdx
	cmpq	%rdx, %rcx
	je	.L421
	movq	%rcx, 32(%rbx)
	movq	16(%rax), %rcx
	movq	%rcx, 48(%rbx)
.L418:
	movq	8(%rax), %rcx
.L351:
	movq	%rdx, (%rax)
	movq	$0, 8(%rax)
	movq	%rcx, 40(%rbx)
	movq	%rbp, %rcx
	movb	$0, 16(%rax)
	movabsq	$4294967296000, %rax
	movq	%rax, 72(%rbx)
	leaq	32(%rbx), %rax
	movq	%rax, 16(%rsp)
	leaq	8(%r12), %rax
	movq	$0x000000000, 64(%rbx)
	movq	%rax, 8(%rsp)
	cmpq	%rbp, %rax
	je	.L422
	movq	40(%rbx), %r14
	movq	40(%rbp), %r15
	movq	32(%rbx), %rdi
	movq	32(%rbp), %rsi
	cmpq	%r15, %r14
	movq	%r15, %r11
	cmovbe	%r14, %r11
	movq	%rdi, 24(%rsp)
	movq	%rsi, 32(%rsp)
	testq	%r11, %r11
	je	.L359
	movq	%r11, %rdx
	movq	%r11, 40(%rsp)
	movq	%rbp, 48(%rsp)
	call	memcmp@PLT
	movq	40(%rsp), %r11
	movq	48(%rsp), %rcx
	testl	%eax, %eax
	jne	.L420
	movq	%r14, %rax
	subq	%r15, %rax
	cmpq	$2147483647, %rax
	jg	.L364
	cmpq	$-2147483648, %rax
	jl	.L362
	testl	%eax, %eax
.L420:
	js	.L362
.L364:
	movq	24(%rsp), %rsi
	movq	32(%rsp), %rdi
	movq	%r11, %rdx
	movq	%rcx, 48(%rsp)
	movq	%r11, 40(%rsp)
	call	memcmp@PLT
	movq	40(%rsp), %r11
	movq	48(%rsp), %rcx
	testl	%eax, %eax
	jne	.L370
.L363:
	movq	%r15, %rax
	subq	%r14, %rax
	cmpq	$2147483647, %rax
	jg	.L371
	cmpq	$-2147483648, %rax
	jl	.L372
.L370:
	testl	%eax, %eax
	js	.L372
.L371:
	movq	32(%rbx), %rdi
	movq	%rcx, %rbp
	cmpq	%rdi, %r13
	je	.L382
	movq	48(%rbx), %rax
	leaq	1(%rax), %rsi
	call	_ZdlPvm@PLT
.L382:
	movl	$80, %esi
	movq	%rbx, %rdi
	call	_ZdlPvm@PLT
.L414:
	addq	$72, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	movq	%rbp, %rax
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%rbp
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L359:
	.cfi_restore_state
	movq	%r14, %rax
	subq	%r15, %rax
	cmpq	$2147483647, %rax
	jg	.L363
	cmpq	$-2147483648, %rax
	jl	.L362
	testl	%eax, %eax
	jns	.L363
.L362:
	cmpq	%rbp, 24(%r12)
	je	.L388
	movq	%rbp, %rdi
	call	_ZSt18_Rb_tree_decrementPSt18_Rb_tree_node_base@PLT
	movq	40(%rax), %r15
	movq	32(%rax), %rdi
	movq	%rax, %r8
	cmpq	%r15, %r14
	movq	%r15, %rdx
	cmovbe	%r14, %rdx
	testq	%rdx, %rdx
	je	.L366
	movq	24(%rsp), %rsi
	movq	%rax, 32(%rsp)
	call	memcmp@PLT
	movq	32(%rsp), %r8
	testl	%eax, %eax
	jne	.L367
.L366:
	movq	%r15, %rcx
	subq	%r14, %rcx
	cmpq	$2147483647, %rcx
	jg	.L376
	cmpq	$-2147483648, %rcx
	jl	.L369
	movl	%ecx, %eax
.L367:
	testl	%eax, %eax
	jns	.L376
.L369:
	cmpq	$0, 24(%r8)
	je	.L389
.L388:
	movq	%rbp, %r8
	movl	$1, %edi
	jmp	.L365
	.p2align 4,,10
	.p2align 3
.L422:
	cmpq	$0, 40(%r12)
	jne	.L423
.L376:
	movq	16(%rsp), %rsi
	movq	%r12, %rdi
	call	_ZNSt8_Rb_treeINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESt4pairIKS5_N9benchmark7CounterEESt10_Select1stISA_ESt4lessIS5_ESaISA_EE24_M_get_insert_unique_posERS7_
	movq	%rax, %rcx
	movq	%rdx, %r8
.L358:
	testq	%r8, %r8
	je	.L371
.L373:
	testq	%rcx, %rcx
	setne	%al
.L355:
	cmpq	%r8, 8(%rsp)
	je	.L394
	testb	%al, %al
	je	.L424
.L394:
	movl	$1, %edi
.L365:
	movq	8(%rsp), %rcx
	movq	%r8, %rdx
	movq	%rbx, %rsi
	movq	%rbx, %rbp
	call	_ZSt29_Rb_tree_insert_and_rebalancebPSt18_Rb_tree_node_baseS0_RS_@PLT
	addq	$1, 40(%r12)
	jmp	.L414
	.p2align 4,,10
	.p2align 3
.L372:
	movq	%r11, 40(%rsp)
	cmpq	%rbp, 32(%r12)
	je	.L390
	movq	%rbp, %rdi
	call	_ZSt18_Rb_tree_incrementPSt18_Rb_tree_node_base@PLT
	movq	40(%rsp), %r11
	movq	40(%rax), %rcx
	movq	32(%rax), %rsi
	movq	%rax, %r8
	cmpq	%rcx, %r14
	movq	%rcx, %rdx
	cmovbe	%r14, %rdx
	testq	%rdx, %rdx
	je	.L374
	movq	24(%rsp), %rdi
	movq	%r11, 48(%rsp)
	movq	%rcx, 40(%rsp)
	movq	%rax, 56(%rsp)
	call	memcmp@PLT
	movq	40(%rsp), %rcx
	movq	48(%rsp), %r11
	testl	%eax, %eax
	movq	56(%rsp), %r8
	jne	.L375
.L374:
	movq	%r14, %rax
	subq	%rcx, %rax
	cmpq	$2147483647, %rax
	jg	.L376
	cmpq	$-2147483648, %rax
	jl	.L377
.L375:
	testl	%eax, %eax
	jns	.L376
.L377:
	cmpq	$0, 24(%rbp)
	movq	%r8, %rcx
	jne	.L358
	movq	%rbp, %r8
	jmp	.L378
	.p2align 4,,10
	.p2align 3
.L423:
	movq	32(%r12), %r8
	movq	40(%rbx), %r15
	movq	32(%rbx), %rsi
	movq	40(%r8), %rbp
	movq	%r15, %rdx
	movq	32(%r8), %rdi
	cmpq	%r15, %rbp
	cmovbe	%rbp, %rdx
	testq	%rdx, %rdx
	je	.L425
	movq	%r8, 24(%rsp)
	call	memcmp@PLT
	movq	24(%rsp), %r8
	testl	%eax, %eax
	jne	.L357
	subq	%r15, %rbp
	cmpq	$2147483647, %rbp
	jg	.L376
	cmpq	$-2147483648, %rbp
	jl	.L386
.L356:
	movl	%ebp, %eax
.L357:
	xorl	%ecx, %ecx
	testl	%eax, %eax
	jns	.L376
	jmp	.L358
	.p2align 4,,10
	.p2align 3
.L424:
	movq	32(%rbx), %rax
	movq	40(%rbx), %r14
	movq	40(%r8), %r15
	movq	%rax, 24(%rsp)
	movq	32(%r8), %rax
	cmpq	%r15, %r14
	movq	%r15, %r11
	movq	%rax, 32(%rsp)
	cmovbe	%r14, %r11
.L378:
	testq	%r11, %r11
	je	.L379
	movq	24(%rsp), %rdi
	movq	32(%rsp), %rsi
	movq	%r11, %rdx
	movq	%r8, 16(%rsp)
	call	memcmp@PLT
	movq	16(%rsp), %r8
	testl	%eax, %eax
	movl	%eax, %edi
	jne	.L380
.L379:
	movq	%r14, %r9
	xorl	%edi, %edi
	subq	%r15, %r9
	cmpq	$2147483647, %r9
	jg	.L365
	cmpq	$-2147483648, %r9
	jl	.L394
	movl	%r9d, %edi
.L380:
	shrl	$31, %edi
	jmp	.L365
	.p2align 4,,10
	.p2align 3
.L421:
	movq	8(%rax), %rcx
	leaq	1(%rcx), %rsi
	cmpl	$8, %esi
	jnb	.L345
	testb	$4, %sil
	jne	.L426
	testl	%esi, %esi
	je	.L351
	movzbl	16(%rax), %ecx
	movb	%cl, 48(%rbx)
	testb	$2, %sil
	je	.L418
	movl	%esi, %esi
	movzwl	-2(%rdx,%rsi), %ecx
	movw	%cx, -2(%r13,%rsi)
	movq	8(%rax), %rcx
	jmp	.L351
	.p2align 4,,10
	.p2align 3
.L345:
	movq	16(%rax), %rcx
	leaq	56(%rbx), %r8
	movq	%rdx, %r10
	andq	$-8, %r8
	movq	%rcx, 48(%rbx)
	movl	%esi, %ecx
	movq	-8(%rdx,%rcx), %rdi
	movq	%rdi, -8(%r13,%rcx)
	movq	%r13, %rcx
	subq	%r8, %rcx
	addl	%ecx, %esi
	subq	%rcx, %r10
	andl	$-8, %esi
	cmpl	$8, %esi
	jb	.L418
	andl	$-8, %esi
	xorl	%ecx, %ecx
.L349:
	movl	%ecx, %edi
	addl	$8, %ecx
	movq	(%r10,%rdi), %r9
	movq	%r9, (%r8,%rdi)
	cmpl	%esi, %ecx
	jb	.L349
	jmp	.L418
.L386:
	xorl	%ecx, %ecx
	jmp	.L358
	.p2align 4,,10
	.p2align 3
.L425:
	subq	%r15, %rbp
	cmpq	$2147483647, %rbp
	jg	.L376
	cmpq	$-2147483648, %rbp
	jge	.L356
	.p2align 4,,10
	.p2align 3
.L389:
	xorl	%eax, %eax
	jmp	.L355
	.p2align 4,,10
	.p2align 3
.L390:
	movq	%rbp, %r8
	xorl	%ecx, %ecx
	jmp	.L373
.L426:
	movl	16(%rax), %ecx
	movl	%esi, %esi
	movl	%ecx, 48(%rbx)
	movl	-4(%rdx,%rsi), %ecx
	movl	%ecx, -4(%r13,%rsi)
	movq	8(%rax), %rcx
	jmp	.L351
	.cfi_endproc
.LFE14162:
	.size	_ZNSt8_Rb_treeINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESt4pairIKS5_N9benchmark7CounterEESt10_Select1stISA_ESt4lessIS5_ESaISA_EE22_M_emplace_hint_uniqueIJRKSt21piecewise_construct_tSt5tupleIJOS5_EESL_IJEEEEESt17_Rb_tree_iteratorISA_ESt23_Rb_tree_const_iteratorISA_EDpOT_, .-_ZNSt8_Rb_treeINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESt4pairIKS5_N9benchmark7CounterEESt10_Select1stISA_ESt4lessIS5_ESaISA_EE22_M_emplace_hint_uniqueIJRKSt21piecewise_construct_tSt5tupleIJOS5_EESL_IJEEEEESt17_Rb_tree_iteratorISA_ESt23_Rb_tree_const_iteratorISA_EDpOT_
	.section	.rodata.str1.8
	.align 8
.LC32:
	.string	"benchmark::State::StateIterator& benchmark::State::StateIterator::operator++()"
	.align 8
.LC33:
	.string	"/home/sbstndbs/.local/include/benchmark/state.h"
	.section	.rodata.str1.1
.LC34:
	.string	"cached_ > 0"
	.section	.text.unlikely,"ax",@progbits
.LCOLDB36:
	.text
.LHOTB36:
	.p2align 4
	.type	_Z9BM_DoubleIXadL_ZL12pow_asm_mul1djEEEvRN9benchmark5StateERKSt6vectorI8TestCaseSaIS4_EE, @function
_Z9BM_DoubleIXadL_ZL12pow_asm_mul1djEEEvRN9benchmark5StateERKSt6vectorI8TestCaseSaIS4_EE:
.LFB13977:
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gxx_personality_v0
	.cfi_lsda 0x1b,.LLSDA13977
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	movq	%rdi, %r13
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	movq	%rsi, %r12
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	subq	$88, %rsp
	.cfi_def_cfa_offset 144
	movq	%fs:40, %rax
	movq	%rax, 72(%rsp)
	xorl	%eax, %eax
	movl	28(%rdi), %eax
	testl	%eax, %eax
	je	.L428
.LEHB24:
	call	_ZN9benchmark5State16StartKeepRunningEv@PLT
.L429:
	movq	%r13, %rdi
	call	_ZN9benchmark5State17FinishKeepRunningEv@PLT
	cmpb	$0, 24(%r13)
	je	.L456
	movq	16(%r13), %rdx
	subq	0(%r13), %rdx
	addq	8(%r13), %rdx
.L435:
	movq	8(%r12), %rax
	subq	(%r12), %rax
	vxorps	%xmm0, %xmm0, %xmm0
	leaq	48(%rsp), %r15
	sarq	$4, %rax
	movl	$17, %edi
	movq	%r15, 32(%rsp)
	imulq	%rdx, %rax
	vcvtsi2sdq	%rax, %xmm0, %xmm0
	vmovsd	%xmm0, 8(%rsp)
	call	_Znwm@PLT
.LEHE24:
	vmovdqa	.LC35(%rip), %xmm0
	movq	80(%r13), %r12
	movq	$16, 48(%rsp)
	movq	%rax, 32(%rsp)
	movq	%rax, %rbx
	movb	$0, 16(%rax)
	vmovdqu	%xmm0, (%rax)
	leaq	72(%r13), %rax
	movq	$16, 40(%rsp)
	movq	%rax, %rbp
	movq	%rax, (%rsp)
	testq	%r12, %r12
	jne	.L443
	jmp	.L436
	.p2align 4,,10
	.p2align 3
.L483:
	testq	%r14, %r14
	jne	.L481
.L438:
	movq	24(%r12), %r12
	testq	%r12, %r12
	je	.L482
.L443:
	movq	40(%r12), %r14
	movq	32(%r12), %rdi
	cmpq	$16, %r14
	jbe	.L483
	movl	$16, %edx
	movq	%rbx, %rsi
	call	memcmp@PLT
	testl	%eax, %eax
	jne	.L440
	leaq	-16(%r14), %rax
	cmpq	$2147483647, %rax
	jg	.L441
	cmpq	$-2147483648, %rax
	jl	.L438
	.p2align 4,,10
	.p2align 3
.L440:
	testl	%eax, %eax
	js	.L438
.L441:
	movq	%r12, %rbp
	movq	16(%r12), %r12
	testq	%r12, %r12
	jne	.L443
.L482:
	cmpq	%rbp, (%rsp)
	je	.L436
	movq	40(%rbp), %r14
	movq	32(%rbp), %rsi
	cmpq	$15, %r14
	jbe	.L484
	movl	$16, %edx
	movq	%rbx, %rdi
	call	memcmp@PLT
	testl	%eax, %eax
	je	.L485
.L447:
	testl	%eax, %eax
	jns	.L445
.L436:
	leaq	32(%rsp), %rbx
	leaq	24(%rsp), %rcx
	movq	%rbp, %rsi
	leaq	64(%r13), %rdi
	leaq	23(%rsp), %r8
	movq	%rbx, 24(%rsp)
	leaq	_ZSt19piecewise_construct(%rip), %rdx
.LEHB25:
	call	_ZNSt8_Rb_treeINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESt4pairIKS5_N9benchmark7CounterEESt10_Select1stISA_ESt4lessIS5_ESaISA_EE22_M_emplace_hint_uniqueIJRKSt21piecewise_construct_tSt5tupleIJOS5_EESL_IJEEEEESt17_Rb_tree_iteratorISA_ESt23_Rb_tree_const_iteratorISA_EDpOT_
.LEHE25:
	vmovsd	8(%rsp), %xmm3
	movq	32(%rsp), %rbx
	movabsq	$4294967296001, %rcx
	movq	%rcx, 72(%rax)
	vmovsd	%xmm3, 64(%rax)
	cmpq	%r15, %rbx
	je	.L427
.L453:
	movq	48(%rsp), %rax
	movq	%rbx, %rdi
	leaq	1(%rax), %rsi
	call	_ZdlPvm@PLT
.L427:
	movq	72(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L486
	addq	$88, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%rbp
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L481:
	.cfi_restore_state
	movq	%r14, %rdx
	movq	%rbx, %rsi
	call	memcmp@PLT
	testl	%eax, %eax
	jne	.L440
	leaq	-16(%r14), %rax
	testl	%eax, %eax
	jns	.L441
	jmp	.L438
.L428:
	movq	16(%rdi), %rbp
.LEHB26:
	call	_ZN9benchmark5State16StartKeepRunningEv@PLT
.LEHE26:
	testq	%rbp, %rbp
	je	.L429
	movq	(%r12), %rbx
	movq	8(%r12), %r14
	cmpq	%rbx, %r14
	je	.L455
	.p2align 4,,10
	.p2align 3
.L434:
	movq	$0x000000000, (%rsp)
	.p2align 4,,10
	.p2align 3
.L432:
	movl	8(%rbx), %edi
	vmovsd	(%rbx), %xmm0
	addq	$16, %rbx
	call	_ZL12pow_asm_mul1dj
	vaddsd	(%rsp), %xmm0, %xmm1
	vmovsd	%xmm1, (%rsp)
	cmpq	%rbx, %r14
	jne	.L432
	vmovq	%xmm1, %rax
.L431:
	testq	%rbp, %rbp
	jle	.L487
.L433:
	subq	$1, %rbp
	je	.L429
	movq	(%r12), %rbx
	movq	8(%r12), %r14
	cmpq	%rbx, %r14
	jne	.L434
	xorl	%eax, %eax
	jmp	.L433
.L485:
	movl	$16, %eax
	subq	%r14, %rax
	cmpq	$2147483647, %rax
	jg	.L445
	cmpq	$-2147483648, %rax
	jl	.L436
	testl	%eax, %eax
	js	.L436
.L445:
	movabsq	$4294967296001, %rax
	vmovsd	8(%rsp), %xmm4
	movq	%rax, 72(%rbp)
	vmovsd	%xmm4, 64(%rbp)
	jmp	.L453
.L484:
	testq	%r14, %r14
	je	.L445
	movq	%r14, %rdx
	movq	%rbx, %rdi
	call	memcmp@PLT
	testl	%eax, %eax
	je	.L445
	jmp	.L447
.L456:
	xorl	%edx, %edx
	jmp	.L435
.L455:
	movq	$0x000000000, (%rsp)
	movq	(%rsp), %rax
	jmp	.L431
.L486:
	call	__stack_chk_fail@PLT
.L487:
	leaq	.LC32(%rip), %rcx
	movl	$234, %edx
	leaq	.LC33(%rip), %rsi
	leaq	.LC34(%rip), %rdi
	call	__assert_fail@PLT
.L458:
	endbr64
	movq	%rax, %rbp
	jmp	.L449
	.section	.gcc_except_table,"a",@progbits
.LLSDA13977:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSE13977-.LLSDACSB13977
.LLSDACSB13977:
	.uleb128 .LEHB24-.LFB13977
	.uleb128 .LEHE24-.LEHB24
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB25-.LFB13977
	.uleb128 .LEHE25-.LEHB25
	.uleb128 .L458-.LFB13977
	.uleb128 0
	.uleb128 .LEHB26-.LFB13977
	.uleb128 .LEHE26-.LEHB26
	.uleb128 0
	.uleb128 0
.LLSDACSE13977:
	.text
	.cfi_endproc
	.section	.text.unlikely
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gxx_personality_v0
	.cfi_lsda 0x1b,.LLSDAC13977
	.type	_Z9BM_DoubleIXadL_ZL12pow_asm_mul1djEEEvRN9benchmark5StateERKSt6vectorI8TestCaseSaIS4_EE.cold, @function
_Z9BM_DoubleIXadL_ZL12pow_asm_mul1djEEEvRN9benchmark5StateERKSt6vectorI8TestCaseSaIS4_EE.cold:
.LFSB13977:
.L449:
	.cfi_def_cfa_offset 144
	.cfi_offset 3, -56
	.cfi_offset 6, -48
	.cfi_offset 12, -40
	.cfi_offset 13, -32
	.cfi_offset 14, -24
	.cfi_offset 15, -16
	movq	%rbx, %rdi
	vzeroupper
	call	_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_disposeEv
	movq	72(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L488
	movq	%rbp, %rdi
.LEHB27:
	call	_Unwind_Resume@PLT
.LEHE27:
.L488:
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE13977:
	.section	.gcc_except_table
.LLSDAC13977:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSEC13977-.LLSDACSBC13977
.LLSDACSBC13977:
	.uleb128 .LEHB27-.LCOLDB36
	.uleb128 .LEHE27-.LEHB27
	.uleb128 0
	.uleb128 0
.LLSDACSEC13977:
	.section	.text.unlikely
	.text
	.size	_Z9BM_DoubleIXadL_ZL12pow_asm_mul1djEEEvRN9benchmark5StateERKSt6vectorI8TestCaseSaIS4_EE, .-_Z9BM_DoubleIXadL_ZL12pow_asm_mul1djEEEvRN9benchmark5StateERKSt6vectorI8TestCaseSaIS4_EE
	.section	.text.unlikely
	.size	_Z9BM_DoubleIXadL_ZL12pow_asm_mul1djEEEvRN9benchmark5StateERKSt6vectorI8TestCaseSaIS4_EE.cold, .-_Z9BM_DoubleIXadL_ZL12pow_asm_mul1djEEEvRN9benchmark5StateERKSt6vectorI8TestCaseSaIS4_EE.cold
.LCOLDE36:
	.text
.LHOTE36:
	.p2align 4
	.type	_ZL16BM_AsmMul1_Exp13RN9benchmark5StateE, @function
_ZL16BM_AsmMul1_Exp13RN9benchmark5StateE:
.LFB13397:
	.cfi_startproc
	endbr64
	leaq	_ZL10kTestExp13(%rip), %rsi
	jmp	_Z9BM_DoubleIXadL_ZL12pow_asm_mul1djEEEvRN9benchmark5StateERKSt6vectorI8TestCaseSaIS4_EE
	.cfi_endproc
.LFE13397:
	.size	_ZL16BM_AsmMul1_Exp13RN9benchmark5StateE, .-_ZL16BM_AsmMul1_Exp13RN9benchmark5StateE
	.p2align 4
	.type	_ZL15BM_AsmMul1_Exp7RN9benchmark5StateE, @function
_ZL15BM_AsmMul1_Exp7RN9benchmark5StateE:
.LFB13390:
	.cfi_startproc
	endbr64
	leaq	_ZL9kTestExp7(%rip), %rsi
	jmp	_Z9BM_DoubleIXadL_ZL12pow_asm_mul1djEEEvRN9benchmark5StateERKSt6vectorI8TestCaseSaIS4_EE
	.cfi_endproc
.LFE13390:
	.size	_ZL15BM_AsmMul1_Exp7RN9benchmark5StateE, .-_ZL15BM_AsmMul1_Exp7RN9benchmark5StateE
	.p2align 4
	.type	_ZL15BM_AsmMul1_Exp3RN9benchmark5StateE, @function
_ZL15BM_AsmMul1_Exp3RN9benchmark5StateE:
.LFB13383:
	.cfi_startproc
	endbr64
	leaq	_ZL9kTestExp3(%rip), %rsi
	jmp	_Z9BM_DoubleIXadL_ZL12pow_asm_mul1djEEEvRN9benchmark5StateERKSt6vectorI8TestCaseSaIS4_EE
	.cfi_endproc
.LFE13383:
	.size	_ZL15BM_AsmMul1_Exp3RN9benchmark5StateE, .-_ZL15BM_AsmMul1_Exp3RN9benchmark5StateE
	.section	.text.unlikely
.LCOLDB37:
	.text
.LHOTB37:
	.p2align 4
	.type	_Z9BM_DoubleIXadL_ZL12wrap_std_powdjEEEvRN9benchmark5StateERKSt6vectorI8TestCaseSaIS4_EE, @function
_Z9BM_DoubleIXadL_ZL12wrap_std_powdjEEEvRN9benchmark5StateERKSt6vectorI8TestCaseSaIS4_EE:
.LFB13980:
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gxx_personality_v0
	.cfi_lsda 0x1b,.LLSDA13980
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	movq	%rdi, %r13
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	movq	%rsi, %r12
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	subq	$88, %rsp
	.cfi_def_cfa_offset 144
	movq	%fs:40, %rax
	movq	%rax, 72(%rsp)
	xorl	%eax, %eax
	movl	28(%rdi), %eax
	testl	%eax, %eax
	je	.L493
.LEHB28:
	call	_ZN9benchmark5State16StartKeepRunningEv@PLT
.L494:
	movq	%r13, %rdi
	call	_ZN9benchmark5State17FinishKeepRunningEv@PLT
	cmpb	$0, 24(%r13)
	je	.L521
	movq	16(%r13), %rdx
	subq	0(%r13), %rdx
	addq	8(%r13), %rdx
.L500:
	movq	8(%r12), %rax
	subq	(%r12), %rax
	vxorps	%xmm0, %xmm0, %xmm0
	leaq	48(%rsp), %r15
	sarq	$4, %rax
	movl	$17, %edi
	movq	%r15, 32(%rsp)
	imulq	%rdx, %rax
	vcvtsi2sdq	%rax, %xmm0, %xmm0
	vmovsd	%xmm0, 8(%rsp)
	call	_Znwm@PLT
.LEHE28:
	vmovdqa	.LC35(%rip), %xmm0
	movq	80(%r13), %r12
	movq	$16, 48(%rsp)
	movq	%rax, 32(%rsp)
	movq	%rax, %rbx
	movb	$0, 16(%rax)
	vmovdqu	%xmm0, (%rax)
	leaq	72(%r13), %rax
	movq	$16, 40(%rsp)
	movq	%rax, %rbp
	movq	%rax, (%rsp)
	testq	%r12, %r12
	jne	.L508
	jmp	.L501
	.p2align 4,,10
	.p2align 3
.L548:
	testq	%r14, %r14
	jne	.L546
.L503:
	movq	24(%r12), %r12
	testq	%r12, %r12
	je	.L547
.L508:
	movq	40(%r12), %r14
	movq	32(%r12), %rdi
	cmpq	$16, %r14
	jbe	.L548
	movl	$16, %edx
	movq	%rbx, %rsi
	call	memcmp@PLT
	testl	%eax, %eax
	jne	.L505
	leaq	-16(%r14), %rax
	cmpq	$2147483647, %rax
	jg	.L506
	cmpq	$-2147483648, %rax
	jl	.L503
	.p2align 4,,10
	.p2align 3
.L505:
	testl	%eax, %eax
	js	.L503
.L506:
	movq	%r12, %rbp
	movq	16(%r12), %r12
	testq	%r12, %r12
	jne	.L508
.L547:
	cmpq	%rbp, (%rsp)
	je	.L501
	movq	40(%rbp), %r14
	movq	32(%rbp), %rsi
	cmpq	$15, %r14
	jbe	.L549
	movl	$16, %edx
	movq	%rbx, %rdi
	call	memcmp@PLT
	testl	%eax, %eax
	je	.L550
.L512:
	testl	%eax, %eax
	jns	.L510
.L501:
	leaq	32(%rsp), %rbx
	leaq	24(%rsp), %rcx
	movq	%rbp, %rsi
	leaq	64(%r13), %rdi
	leaq	23(%rsp), %r8
	movq	%rbx, 24(%rsp)
	leaq	_ZSt19piecewise_construct(%rip), %rdx
.LEHB29:
	call	_ZNSt8_Rb_treeINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESt4pairIKS5_N9benchmark7CounterEESt10_Select1stISA_ESt4lessIS5_ESaISA_EE22_M_emplace_hint_uniqueIJRKSt21piecewise_construct_tSt5tupleIJOS5_EESL_IJEEEEESt17_Rb_tree_iteratorISA_ESt23_Rb_tree_const_iteratorISA_EDpOT_
.LEHE29:
	vmovsd	8(%rsp), %xmm3
	movq	32(%rsp), %rbx
	movabsq	$4294967296001, %rcx
	movq	%rcx, 72(%rax)
	vmovsd	%xmm3, 64(%rax)
	cmpq	%r15, %rbx
	je	.L492
.L518:
	movq	48(%rsp), %rax
	movq	%rbx, %rdi
	leaq	1(%rax), %rsi
	call	_ZdlPvm@PLT
.L492:
	movq	72(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L551
	addq	$88, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%rbp
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L546:
	.cfi_restore_state
	movq	%r14, %rdx
	movq	%rbx, %rsi
	call	memcmp@PLT
	testl	%eax, %eax
	jne	.L505
	leaq	-16(%r14), %rax
	testl	%eax, %eax
	jns	.L506
	jmp	.L503
.L493:
	movq	16(%rdi), %rbp
.LEHB30:
	call	_ZN9benchmark5State16StartKeepRunningEv@PLT
.LEHE30:
	testq	%rbp, %rbp
	je	.L494
	movq	(%r12), %rbx
	movq	8(%r12), %r14
	cmpq	%rbx, %r14
	je	.L520
	.p2align 4,,10
	.p2align 3
.L499:
	movq	$0x000000000, (%rsp)
	.p2align 4,,10
	.p2align 3
.L497:
	movl	8(%rbx), %edi
	vmovsd	(%rbx), %xmm0
	addq	$16, %rbx
	call	_ZL12wrap_std_powdj
	vaddsd	(%rsp), %xmm0, %xmm1
	vmovsd	%xmm1, (%rsp)
	cmpq	%r14, %rbx
	jne	.L497
	vmovq	%xmm1, %rax
.L496:
	testq	%rbp, %rbp
	jle	.L552
.L498:
	subq	$1, %rbp
	je	.L494
	movq	(%r12), %rbx
	movq	8(%r12), %r14
	cmpq	%rbx, %r14
	jne	.L499
	xorl	%eax, %eax
	jmp	.L498
.L550:
	movl	$16, %eax
	subq	%r14, %rax
	cmpq	$2147483647, %rax
	jg	.L510
	cmpq	$-2147483648, %rax
	jl	.L501
	testl	%eax, %eax
	js	.L501
.L510:
	movabsq	$4294967296001, %rax
	vmovsd	8(%rsp), %xmm4
	movq	%rax, 72(%rbp)
	vmovsd	%xmm4, 64(%rbp)
	jmp	.L518
.L549:
	testq	%r14, %r14
	je	.L510
	movq	%r14, %rdx
	movq	%rbx, %rdi
	call	memcmp@PLT
	testl	%eax, %eax
	je	.L510
	jmp	.L512
.L521:
	xorl	%edx, %edx
	jmp	.L500
.L520:
	movq	$0x000000000, (%rsp)
	movq	(%rsp), %rax
	jmp	.L496
.L551:
	call	__stack_chk_fail@PLT
.L552:
	leaq	.LC32(%rip), %rcx
	movl	$234, %edx
	leaq	.LC33(%rip), %rsi
	leaq	.LC34(%rip), %rdi
	call	__assert_fail@PLT
.L523:
	endbr64
	movq	%rax, %rbp
	jmp	.L514
	.section	.gcc_except_table
.LLSDA13980:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSE13980-.LLSDACSB13980
.LLSDACSB13980:
	.uleb128 .LEHB28-.LFB13980
	.uleb128 .LEHE28-.LEHB28
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB29-.LFB13980
	.uleb128 .LEHE29-.LEHB29
	.uleb128 .L523-.LFB13980
	.uleb128 0
	.uleb128 .LEHB30-.LFB13980
	.uleb128 .LEHE30-.LEHB30
	.uleb128 0
	.uleb128 0
.LLSDACSE13980:
	.text
	.cfi_endproc
	.section	.text.unlikely
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gxx_personality_v0
	.cfi_lsda 0x1b,.LLSDAC13980
	.type	_Z9BM_DoubleIXadL_ZL12wrap_std_powdjEEEvRN9benchmark5StateERKSt6vectorI8TestCaseSaIS4_EE.cold, @function
_Z9BM_DoubleIXadL_ZL12wrap_std_powdjEEEvRN9benchmark5StateERKSt6vectorI8TestCaseSaIS4_EE.cold:
.LFSB13980:
.L514:
	.cfi_def_cfa_offset 144
	.cfi_offset 3, -56
	.cfi_offset 6, -48
	.cfi_offset 12, -40
	.cfi_offset 13, -32
	.cfi_offset 14, -24
	.cfi_offset 15, -16
	movq	%rbx, %rdi
	vzeroupper
	call	_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_disposeEv
	movq	72(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L553
	movq	%rbp, %rdi
.LEHB31:
	call	_Unwind_Resume@PLT
.LEHE31:
.L553:
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE13980:
	.section	.gcc_except_table
.LLSDAC13980:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSEC13980-.LLSDACSBC13980
.LLSDACSBC13980:
	.uleb128 .LEHB31-.LCOLDB37
	.uleb128 .LEHE31-.LEHB31
	.uleb128 0
	.uleb128 0
.LLSDACSEC13980:
	.section	.text.unlikely
	.text
	.size	_Z9BM_DoubleIXadL_ZL12wrap_std_powdjEEEvRN9benchmark5StateERKSt6vectorI8TestCaseSaIS4_EE, .-_Z9BM_DoubleIXadL_ZL12wrap_std_powdjEEEvRN9benchmark5StateERKSt6vectorI8TestCaseSaIS4_EE
	.section	.text.unlikely
	.size	_Z9BM_DoubleIXadL_ZL12wrap_std_powdjEEEvRN9benchmark5StateERKSt6vectorI8TestCaseSaIS4_EE.cold, .-_Z9BM_DoubleIXadL_ZL12wrap_std_powdjEEEvRN9benchmark5StateERKSt6vectorI8TestCaseSaIS4_EE.cold
.LCOLDE37:
	.text
.LHOTE37:
	.p2align 4
	.type	_ZL15BM_StdPow_Exp13RN9benchmark5StateE, @function
_ZL15BM_StdPow_Exp13RN9benchmark5StateE:
.LFB13400:
	.cfi_startproc
	endbr64
	leaq	_ZL10kTestExp13(%rip), %rsi
	jmp	_Z9BM_DoubleIXadL_ZL12wrap_std_powdjEEEvRN9benchmark5StateERKSt6vectorI8TestCaseSaIS4_EE
	.cfi_endproc
.LFE13400:
	.size	_ZL15BM_StdPow_Exp13RN9benchmark5StateE, .-_ZL15BM_StdPow_Exp13RN9benchmark5StateE
	.p2align 4
	.type	_ZL14BM_StdPow_Exp7RN9benchmark5StateE, @function
_ZL14BM_StdPow_Exp7RN9benchmark5StateE:
.LFB13393:
	.cfi_startproc
	endbr64
	leaq	_ZL9kTestExp7(%rip), %rsi
	jmp	_Z9BM_DoubleIXadL_ZL12wrap_std_powdjEEEvRN9benchmark5StateERKSt6vectorI8TestCaseSaIS4_EE
	.cfi_endproc
.LFE13393:
	.size	_ZL14BM_StdPow_Exp7RN9benchmark5StateE, .-_ZL14BM_StdPow_Exp7RN9benchmark5StateE
	.p2align 4
	.type	_ZL14BM_StdPow_Exp3RN9benchmark5StateE, @function
_ZL14BM_StdPow_Exp3RN9benchmark5StateE:
.LFB13386:
	.cfi_startproc
	endbr64
	leaq	_ZL9kTestExp3(%rip), %rsi
	jmp	_Z9BM_DoubleIXadL_ZL12wrap_std_powdjEEEvRN9benchmark5StateERKSt6vectorI8TestCaseSaIS4_EE
	.cfi_endproc
.LFE13386:
	.size	_ZL14BM_StdPow_Exp3RN9benchmark5StateE, .-_ZL14BM_StdPow_Exp3RN9benchmark5StateE
	.section	.text.unlikely
.LCOLDB38:
	.text
.LHOTB38:
	.p2align 4
	.type	_Z9BM_DoubleIXadL_ZL17pow_scalar_doubledjEEEvRN9benchmark5StateERKSt6vectorI8TestCaseSaIS4_EE, @function
_Z9BM_DoubleIXadL_ZL17pow_scalar_doubledjEEEvRN9benchmark5StateERKSt6vectorI8TestCaseSaIS4_EE:
.LFB13970:
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gxx_personality_v0
	.cfi_lsda 0x1b,.LLSDA13970
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	movq	%rsi, %rbp
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	movq	%rdi, %rbx
	subq	$88, %rsp
	.cfi_def_cfa_offset 144
	movq	%fs:40, %rax
	movq	%rax, 72(%rsp)
	xorl	%eax, %eax
	movl	28(%rdi), %eax
	testl	%eax, %eax
	je	.L558
.LEHB32:
	call	_ZN9benchmark5State16StartKeepRunningEv@PLT
.L559:
	movq	%rbx, %rdi
	call	_ZN9benchmark5State17FinishKeepRunningEv@PLT
	cmpb	$0, 24(%rbx)
	je	.L586
	movq	16(%rbx), %rdx
	subq	(%rbx), %rdx
	addq	8(%rbx), %rdx
.L565:
	movq	8(%rbp), %rax
	subq	0(%rbp), %rax
	vxorps	%xmm0, %xmm0, %xmm0
	leaq	48(%rsp), %r14
	sarq	$4, %rax
	movl	$17, %edi
	movq	%r14, 32(%rsp)
	imulq	%rdx, %rax
	vcvtsi2sdq	%rax, %xmm0, %xmm0
	vmovsd	%xmm0, 8(%rsp)
	call	_Znwm@PLT
.LEHE32:
	vmovdqa	.LC35(%rip), %xmm0
	movq	80(%rbx), %r15
	movq	$16, 48(%rsp)
	movq	%rax, 32(%rsp)
	movq	%rax, %rbp
	movb	$0, 16(%rax)
	vmovdqu	%xmm0, (%rax)
	leaq	72(%rbx), %rax
	movq	$16, 40(%rsp)
	movq	%rax, %r12
	movq	%rax, (%rsp)
	testq	%r15, %r15
	jne	.L573
	jmp	.L566
	.p2align 4,,10
	.p2align 3
.L613:
	testq	%r13, %r13
	jne	.L611
.L568:
	movq	24(%r15), %r15
	testq	%r15, %r15
	je	.L612
.L573:
	movq	40(%r15), %r13
	movq	32(%r15), %rdi
	cmpq	$16, %r13
	jbe	.L613
	movl	$16, %edx
	movq	%rbp, %rsi
	call	memcmp@PLT
	testl	%eax, %eax
	jne	.L570
	leaq	-16(%r13), %rax
	cmpq	$2147483647, %rax
	jg	.L571
	cmpq	$-2147483648, %rax
	jl	.L568
	.p2align 4,,10
	.p2align 3
.L570:
	testl	%eax, %eax
	js	.L568
.L571:
	movq	%r15, %r12
	movq	16(%r15), %r15
	testq	%r15, %r15
	jne	.L573
.L612:
	cmpq	%r12, (%rsp)
	je	.L566
	movq	40(%r12), %r13
	movq	32(%r12), %rsi
	cmpq	$15, %r13
	jbe	.L614
	movl	$16, %edx
	movq	%rbp, %rdi
	call	memcmp@PLT
	testl	%eax, %eax
	je	.L615
.L577:
	testl	%eax, %eax
	jns	.L575
.L566:
	leaq	32(%rsp), %rbp
	leaq	24(%rsp), %rcx
	movq	%r12, %rsi
	leaq	64(%rbx), %rdi
	leaq	23(%rsp), %r8
	movq	%rbp, 24(%rsp)
	leaq	_ZSt19piecewise_construct(%rip), %rdx
.LEHB33:
	call	_ZNSt8_Rb_treeINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESt4pairIKS5_N9benchmark7CounterEESt10_Select1stISA_ESt4lessIS5_ESaISA_EE22_M_emplace_hint_uniqueIJRKSt21piecewise_construct_tSt5tupleIJOS5_EESL_IJEEEEESt17_Rb_tree_iteratorISA_ESt23_Rb_tree_const_iteratorISA_EDpOT_
.LEHE33:
	vmovsd	8(%rsp), %xmm1
	movq	32(%rsp), %rbp
	movabsq	$4294967296001, %rcx
	movq	%rcx, 72(%rax)
	vmovsd	%xmm1, 64(%rax)
	cmpq	%r14, %rbp
	je	.L557
.L583:
	movq	48(%rsp), %rax
	movq	%rbp, %rdi
	leaq	1(%rax), %rsi
	call	_ZdlPvm@PLT
.L557:
	movq	72(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L616
	addq	$88, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%rbp
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L611:
	.cfi_restore_state
	movq	%r13, %rdx
	movq	%rbp, %rsi
	call	memcmp@PLT
	testl	%eax, %eax
	jne	.L570
	leaq	-16(%r13), %rax
	testl	%eax, %eax
	jns	.L571
	jmp	.L568
.L558:
	movq	16(%rdi), %r12
.LEHB34:
	call	_ZN9benchmark5State16StartKeepRunningEv@PLT
.LEHE34:
	testq	%r12, %r12
	je	.L559
	movq	0(%rbp), %rax
	movq	8(%rbp), %rdx
	cmpq	%rax, %rdx
	je	.L585
	.p2align 4,,10
	.p2align 3
.L564:
	vxorpd	%xmm2, %xmm2, %xmm2
	.p2align 4,,10
	.p2align 3
.L562:
	movl	8(%rax), %edi
	vmovsd	(%rax), %xmm0
	addq	$16, %rax
	call	_ZL17pow_scalar_doubledj
	vaddsd	%xmm0, %xmm2, %xmm2
	cmpq	%rdx, %rax
	jne	.L562
.L561:
	vmovq	%xmm2, %rax
	testq	%r12, %r12
	jle	.L617
.L563:
	subq	$1, %r12
	je	.L559
	movq	0(%rbp), %rax
	movq	8(%rbp), %rdx
	cmpq	%rax, %rdx
	jne	.L564
	xorl	%eax, %eax
	jmp	.L563
.L615:
	movl	$16, %eax
	subq	%r13, %rax
	cmpq	$2147483647, %rax
	jg	.L575
	cmpq	$-2147483648, %rax
	jl	.L566
	testl	%eax, %eax
	js	.L566
.L575:
	movabsq	$4294967296001, %rax
	vmovsd	8(%rsp), %xmm3
	movq	%rax, 72(%r12)
	vmovsd	%xmm3, 64(%r12)
	jmp	.L583
.L614:
	testq	%r13, %r13
	je	.L575
	movq	%r13, %rdx
	movq	%rbp, %rdi
	call	memcmp@PLT
	testl	%eax, %eax
	je	.L575
	jmp	.L577
.L586:
	xorl	%edx, %edx
	jmp	.L565
.L585:
	vxorpd	%xmm2, %xmm2, %xmm2
	jmp	.L561
.L616:
	call	__stack_chk_fail@PLT
.L617:
	leaq	.LC32(%rip), %rcx
	movl	$234, %edx
	leaq	.LC33(%rip), %rsi
	leaq	.LC34(%rip), %rdi
	call	__assert_fail@PLT
.L588:
	endbr64
	movq	%rax, %rbx
	jmp	.L579
	.section	.gcc_except_table
.LLSDA13970:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSE13970-.LLSDACSB13970
.LLSDACSB13970:
	.uleb128 .LEHB32-.LFB13970
	.uleb128 .LEHE32-.LEHB32
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB33-.LFB13970
	.uleb128 .LEHE33-.LEHB33
	.uleb128 .L588-.LFB13970
	.uleb128 0
	.uleb128 .LEHB34-.LFB13970
	.uleb128 .LEHE34-.LEHB34
	.uleb128 0
	.uleb128 0
.LLSDACSE13970:
	.text
	.cfi_endproc
	.section	.text.unlikely
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gxx_personality_v0
	.cfi_lsda 0x1b,.LLSDAC13970
	.type	_Z9BM_DoubleIXadL_ZL17pow_scalar_doubledjEEEvRN9benchmark5StateERKSt6vectorI8TestCaseSaIS4_EE.cold, @function
_Z9BM_DoubleIXadL_ZL17pow_scalar_doubledjEEEvRN9benchmark5StateERKSt6vectorI8TestCaseSaIS4_EE.cold:
.LFSB13970:
.L579:
	.cfi_def_cfa_offset 144
	.cfi_offset 3, -56
	.cfi_offset 6, -48
	.cfi_offset 12, -40
	.cfi_offset 13, -32
	.cfi_offset 14, -24
	.cfi_offset 15, -16
	movq	%rbp, %rdi
	vzeroupper
	call	_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_disposeEv
	movq	72(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L618
	movq	%rbx, %rdi
.LEHB35:
	call	_Unwind_Resume@PLT
.LEHE35:
.L618:
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE13970:
	.section	.gcc_except_table
.LLSDAC13970:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSEC13970-.LLSDACSBC13970
.LLSDACSBC13970:
	.uleb128 .LEHB35-.LCOLDB38
	.uleb128 .LEHE35-.LEHB35
	.uleb128 0
	.uleb128 0
.LLSDACSEC13970:
	.section	.text.unlikely
	.text
	.size	_Z9BM_DoubleIXadL_ZL17pow_scalar_doubledjEEEvRN9benchmark5StateERKSt6vectorI8TestCaseSaIS4_EE, .-_Z9BM_DoubleIXadL_ZL17pow_scalar_doubledjEEEvRN9benchmark5StateERKSt6vectorI8TestCaseSaIS4_EE
	.section	.text.unlikely
	.size	_Z9BM_DoubleIXadL_ZL17pow_scalar_doubledjEEEvRN9benchmark5StateERKSt6vectorI8TestCaseSaIS4_EE.cold, .-_Z9BM_DoubleIXadL_ZL17pow_scalar_doubledjEEEvRN9benchmark5StateERKSt6vectorI8TestCaseSaIS4_EE.cold
.LCOLDE38:
	.text
.LHOTE38:
	.p2align 4
	.type	_ZL19BM_ScalarLoop_Exp13RN9benchmark5StateE, @function
_ZL19BM_ScalarLoop_Exp13RN9benchmark5StateE:
.LFB13394:
	.cfi_startproc
	endbr64
	leaq	_ZL10kTestExp13(%rip), %rsi
	jmp	_Z9BM_DoubleIXadL_ZL17pow_scalar_doubledjEEEvRN9benchmark5StateERKSt6vectorI8TestCaseSaIS4_EE
	.cfi_endproc
.LFE13394:
	.size	_ZL19BM_ScalarLoop_Exp13RN9benchmark5StateE, .-_ZL19BM_ScalarLoop_Exp13RN9benchmark5StateE
	.p2align 4
	.type	_ZL18BM_ScalarLoop_Exp7RN9benchmark5StateE, @function
_ZL18BM_ScalarLoop_Exp7RN9benchmark5StateE:
.LFB13387:
	.cfi_startproc
	endbr64
	leaq	_ZL9kTestExp7(%rip), %rsi
	jmp	_Z9BM_DoubleIXadL_ZL17pow_scalar_doubledjEEEvRN9benchmark5StateERKSt6vectorI8TestCaseSaIS4_EE
	.cfi_endproc
.LFE13387:
	.size	_ZL18BM_ScalarLoop_Exp7RN9benchmark5StateE, .-_ZL18BM_ScalarLoop_Exp7RN9benchmark5StateE
	.p2align 4
	.type	_ZL18BM_ScalarLoop_Exp3RN9benchmark5StateE, @function
_ZL18BM_ScalarLoop_Exp3RN9benchmark5StateE:
.LFB13380:
	.cfi_startproc
	endbr64
	leaq	_ZL9kTestExp3(%rip), %rsi
	jmp	_Z9BM_DoubleIXadL_ZL17pow_scalar_doubledjEEEvRN9benchmark5StateERKSt6vectorI8TestCaseSaIS4_EE
	.cfi_endproc
.LFE13380:
	.size	_ZL18BM_ScalarLoop_Exp3RN9benchmark5StateE, .-_ZL18BM_ScalarLoop_Exp3RN9benchmark5StateE
	.section	.text.unlikely
.LCOLDB39:
	.text
.LHOTB39:
	.p2align 4
	.type	_Z9BM_DoubleIXadL_ZL15wrap_pow_binarydjEEEvRN9benchmark5StateERKSt6vectorI8TestCaseSaIS4_EE, @function
_Z9BM_DoubleIXadL_ZL15wrap_pow_binarydjEEEvRN9benchmark5StateERKSt6vectorI8TestCaseSaIS4_EE:
.LFB13979:
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gxx_personality_v0
	.cfi_lsda 0x1b,.LLSDA13979
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	movq	%rsi, %rbp
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	movq	%rdi, %rbx
	subq	$88, %rsp
	.cfi_def_cfa_offset 144
	movq	%fs:40, %rax
	movq	%rax, 72(%rsp)
	xorl	%eax, %eax
	movl	28(%rdi), %eax
	testl	%eax, %eax
	je	.L623
.LEHB36:
	call	_ZN9benchmark5State16StartKeepRunningEv@PLT
.L624:
	movq	%rbx, %rdi
	call	_ZN9benchmark5State17FinishKeepRunningEv@PLT
	cmpb	$0, 24(%rbx)
	je	.L651
	movq	16(%rbx), %rdx
	subq	(%rbx), %rdx
	addq	8(%rbx), %rdx
.L630:
	movq	8(%rbp), %rax
	subq	0(%rbp), %rax
	vxorps	%xmm0, %xmm0, %xmm0
	leaq	48(%rsp), %r14
	sarq	$4, %rax
	movl	$17, %edi
	movq	%r14, 32(%rsp)
	imulq	%rdx, %rax
	vcvtsi2sdq	%rax, %xmm0, %xmm0
	vmovsd	%xmm0, 8(%rsp)
	call	_Znwm@PLT
.LEHE36:
	vmovdqa	.LC35(%rip), %xmm0
	movq	80(%rbx), %r15
	movq	$16, 48(%rsp)
	movq	%rax, 32(%rsp)
	movq	%rax, %rbp
	movb	$0, 16(%rax)
	vmovdqu	%xmm0, (%rax)
	leaq	72(%rbx), %rax
	movq	$16, 40(%rsp)
	movq	%rax, %r12
	movq	%rax, (%rsp)
	testq	%r15, %r15
	jne	.L638
	jmp	.L631
	.p2align 4,,10
	.p2align 3
.L678:
	testq	%r13, %r13
	jne	.L676
.L633:
	movq	24(%r15), %r15
	testq	%r15, %r15
	je	.L677
.L638:
	movq	40(%r15), %r13
	movq	32(%r15), %rdi
	cmpq	$16, %r13
	jbe	.L678
	movl	$16, %edx
	movq	%rbp, %rsi
	call	memcmp@PLT
	testl	%eax, %eax
	jne	.L635
	leaq	-16(%r13), %rax
	cmpq	$2147483647, %rax
	jg	.L636
	cmpq	$-2147483648, %rax
	jl	.L633
	.p2align 4,,10
	.p2align 3
.L635:
	testl	%eax, %eax
	js	.L633
.L636:
	movq	%r15, %r12
	movq	16(%r15), %r15
	testq	%r15, %r15
	jne	.L638
.L677:
	cmpq	%r12, (%rsp)
	je	.L631
	movq	40(%r12), %r13
	movq	32(%r12), %rsi
	cmpq	$15, %r13
	jbe	.L679
	movl	$16, %edx
	movq	%rbp, %rdi
	call	memcmp@PLT
	testl	%eax, %eax
	je	.L680
.L642:
	testl	%eax, %eax
	jns	.L640
.L631:
	leaq	32(%rsp), %rbp
	leaq	24(%rsp), %rcx
	movq	%r12, %rsi
	leaq	64(%rbx), %rdi
	leaq	23(%rsp), %r8
	movq	%rbp, 24(%rsp)
	leaq	_ZSt19piecewise_construct(%rip), %rdx
.LEHB37:
	call	_ZNSt8_Rb_treeINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESt4pairIKS5_N9benchmark7CounterEESt10_Select1stISA_ESt4lessIS5_ESaISA_EE22_M_emplace_hint_uniqueIJRKSt21piecewise_construct_tSt5tupleIJOS5_EESL_IJEEEEESt17_Rb_tree_iteratorISA_ESt23_Rb_tree_const_iteratorISA_EDpOT_
.LEHE37:
	vmovsd	8(%rsp), %xmm1
	movq	32(%rsp), %rbp
	movabsq	$4294967296001, %rcx
	movq	%rcx, 72(%rax)
	vmovsd	%xmm1, 64(%rax)
	cmpq	%r14, %rbp
	je	.L622
.L648:
	movq	48(%rsp), %rax
	movq	%rbp, %rdi
	leaq	1(%rax), %rsi
	call	_ZdlPvm@PLT
.L622:
	movq	72(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L681
	addq	$88, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%rbp
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L676:
	.cfi_restore_state
	movq	%r13, %rdx
	movq	%rbp, %rsi
	call	memcmp@PLT
	testl	%eax, %eax
	jne	.L635
	leaq	-16(%r13), %rax
	testl	%eax, %eax
	jns	.L636
	jmp	.L633
.L623:
	movq	16(%rdi), %r12
.LEHB38:
	call	_ZN9benchmark5State16StartKeepRunningEv@PLT
.LEHE38:
	testq	%r12, %r12
	je	.L624
	movq	0(%rbp), %rax
	movq	8(%rbp), %rdx
	cmpq	%rax, %rdx
	je	.L650
	.p2align 4,,10
	.p2align 3
.L629:
	vxorpd	%xmm2, %xmm2, %xmm2
	.p2align 4,,10
	.p2align 3
.L627:
	movl	8(%rax), %edi
	vmovsd	(%rax), %xmm0
	addq	$16, %rax
	call	_ZL15wrap_pow_binarydj
	vaddsd	%xmm0, %xmm2, %xmm2
	cmpq	%rdx, %rax
	jne	.L627
.L626:
	vmovq	%xmm2, %rax
	testq	%r12, %r12
	jle	.L682
.L628:
	subq	$1, %r12
	je	.L624
	movq	0(%rbp), %rax
	movq	8(%rbp), %rdx
	cmpq	%rax, %rdx
	jne	.L629
	xorl	%eax, %eax
	jmp	.L628
.L680:
	movl	$16, %eax
	subq	%r13, %rax
	cmpq	$2147483647, %rax
	jg	.L640
	cmpq	$-2147483648, %rax
	jl	.L631
	testl	%eax, %eax
	js	.L631
.L640:
	movabsq	$4294967296001, %rax
	vmovsd	8(%rsp), %xmm3
	movq	%rax, 72(%r12)
	vmovsd	%xmm3, 64(%r12)
	jmp	.L648
.L679:
	testq	%r13, %r13
	je	.L640
	movq	%r13, %rdx
	movq	%rbp, %rdi
	call	memcmp@PLT
	testl	%eax, %eax
	je	.L640
	jmp	.L642
.L651:
	xorl	%edx, %edx
	jmp	.L630
.L650:
	vxorpd	%xmm2, %xmm2, %xmm2
	jmp	.L626
.L681:
	call	__stack_chk_fail@PLT
.L682:
	leaq	.LC32(%rip), %rcx
	movl	$234, %edx
	leaq	.LC33(%rip), %rsi
	leaq	.LC34(%rip), %rdi
	call	__assert_fail@PLT
.L653:
	endbr64
	movq	%rax, %rbx
	jmp	.L644
	.section	.gcc_except_table
.LLSDA13979:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSE13979-.LLSDACSB13979
.LLSDACSB13979:
	.uleb128 .LEHB36-.LFB13979
	.uleb128 .LEHE36-.LEHB36
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB37-.LFB13979
	.uleb128 .LEHE37-.LEHB37
	.uleb128 .L653-.LFB13979
	.uleb128 0
	.uleb128 .LEHB38-.LFB13979
	.uleb128 .LEHE38-.LEHB38
	.uleb128 0
	.uleb128 0
.LLSDACSE13979:
	.text
	.cfi_endproc
	.section	.text.unlikely
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gxx_personality_v0
	.cfi_lsda 0x1b,.LLSDAC13979
	.type	_Z9BM_DoubleIXadL_ZL15wrap_pow_binarydjEEEvRN9benchmark5StateERKSt6vectorI8TestCaseSaIS4_EE.cold, @function
_Z9BM_DoubleIXadL_ZL15wrap_pow_binarydjEEEvRN9benchmark5StateERKSt6vectorI8TestCaseSaIS4_EE.cold:
.LFSB13979:
.L644:
	.cfi_def_cfa_offset 144
	.cfi_offset 3, -56
	.cfi_offset 6, -48
	.cfi_offset 12, -40
	.cfi_offset 13, -32
	.cfi_offset 14, -24
	.cfi_offset 15, -16
	movq	%rbp, %rdi
	vzeroupper
	call	_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_disposeEv
	movq	72(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L683
	movq	%rbx, %rdi
.LEHB39:
	call	_Unwind_Resume@PLT
.LEHE39:
.L683:
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE13979:
	.section	.gcc_except_table
.LLSDAC13979:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSEC13979-.LLSDACSBC13979
.LLSDACSBC13979:
	.uleb128 .LEHB39-.LCOLDB39
	.uleb128 .LEHE39-.LEHB39
	.uleb128 0
	.uleb128 0
.LLSDACSEC13979:
	.section	.text.unlikely
	.text
	.size	_Z9BM_DoubleIXadL_ZL15wrap_pow_binarydjEEEvRN9benchmark5StateERKSt6vectorI8TestCaseSaIS4_EE, .-_Z9BM_DoubleIXadL_ZL15wrap_pow_binarydjEEEvRN9benchmark5StateERKSt6vectorI8TestCaseSaIS4_EE
	.section	.text.unlikely
	.size	_Z9BM_DoubleIXadL_ZL15wrap_pow_binarydjEEEvRN9benchmark5StateERKSt6vectorI8TestCaseSaIS4_EE.cold, .-_Z9BM_DoubleIXadL_ZL15wrap_pow_binarydjEEEvRN9benchmark5StateERKSt6vectorI8TestCaseSaIS4_EE.cold
.LCOLDE39:
	.text
.LHOTE39:
	.p2align 4
	.type	_ZL15BM_Binary_Exp13RN9benchmark5StateE, @function
_ZL15BM_Binary_Exp13RN9benchmark5StateE:
.LFB13399:
	.cfi_startproc
	endbr64
	leaq	_ZL10kTestExp13(%rip), %rsi
	jmp	_Z9BM_DoubleIXadL_ZL15wrap_pow_binarydjEEEvRN9benchmark5StateERKSt6vectorI8TestCaseSaIS4_EE
	.cfi_endproc
.LFE13399:
	.size	_ZL15BM_Binary_Exp13RN9benchmark5StateE, .-_ZL15BM_Binary_Exp13RN9benchmark5StateE
	.p2align 4
	.type	_ZL14BM_Binary_Exp7RN9benchmark5StateE, @function
_ZL14BM_Binary_Exp7RN9benchmark5StateE:
.LFB13392:
	.cfi_startproc
	endbr64
	leaq	_ZL9kTestExp7(%rip), %rsi
	jmp	_Z9BM_DoubleIXadL_ZL15wrap_pow_binarydjEEEvRN9benchmark5StateERKSt6vectorI8TestCaseSaIS4_EE
	.cfi_endproc
.LFE13392:
	.size	_ZL14BM_Binary_Exp7RN9benchmark5StateE, .-_ZL14BM_Binary_Exp7RN9benchmark5StateE
	.p2align 4
	.type	_ZL14BM_Binary_Exp3RN9benchmark5StateE, @function
_ZL14BM_Binary_Exp3RN9benchmark5StateE:
.LFB13385:
	.cfi_startproc
	endbr64
	leaq	_ZL9kTestExp3(%rip), %rsi
	jmp	_Z9BM_DoubleIXadL_ZL15wrap_pow_binarydjEEEvRN9benchmark5StateERKSt6vectorI8TestCaseSaIS4_EE
	.cfi_endproc
.LFE13385:
	.size	_ZL14BM_Binary_Exp3RN9benchmark5StateE, .-_ZL14BM_Binary_Exp3RN9benchmark5StateE
	.section	.text.unlikely
.LCOLDB40:
	.text
.LHOTB40:
	.p2align 4
	.type	_Z9BM_DoubleIXadL_ZL21pow_branchless_doubledjEEEvRN9benchmark5StateERKSt6vectorI8TestCaseSaIS4_EE, @function
_Z9BM_DoubleIXadL_ZL21pow_branchless_doubledjEEEvRN9benchmark5StateERKSt6vectorI8TestCaseSaIS4_EE:
.LFB13975:
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gxx_personality_v0
	.cfi_lsda 0x1b,.LLSDA13975
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	movq	%rsi, %rbp
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	movq	%rdi, %rbx
	subq	$88, %rsp
	.cfi_def_cfa_offset 144
	movq	%fs:40, %rax
	movq	%rax, 72(%rsp)
	xorl	%eax, %eax
	movl	28(%rdi), %eax
	testl	%eax, %eax
	je	.L688
.LEHB40:
	call	_ZN9benchmark5State16StartKeepRunningEv@PLT
.L689:
	movq	%rbx, %rdi
	call	_ZN9benchmark5State17FinishKeepRunningEv@PLT
	cmpb	$0, 24(%rbx)
	je	.L716
	movq	16(%rbx), %rdx
	subq	(%rbx), %rdx
	addq	8(%rbx), %rdx
.L695:
	movq	8(%rbp), %rax
	subq	0(%rbp), %rax
	vxorps	%xmm0, %xmm0, %xmm0
	leaq	48(%rsp), %r14
	sarq	$4, %rax
	movl	$17, %edi
	movq	%r14, 32(%rsp)
	imulq	%rdx, %rax
	vcvtsi2sdq	%rax, %xmm0, %xmm0
	vmovsd	%xmm0, 8(%rsp)
	call	_Znwm@PLT
.LEHE40:
	vmovdqa	.LC35(%rip), %xmm0
	movq	80(%rbx), %r15
	movq	$16, 48(%rsp)
	movq	%rax, 32(%rsp)
	movq	%rax, %rbp
	movb	$0, 16(%rax)
	vmovdqu	%xmm0, (%rax)
	leaq	72(%rbx), %rax
	movq	$16, 40(%rsp)
	movq	%rax, %r12
	movq	%rax, (%rsp)
	testq	%r15, %r15
	jne	.L703
	jmp	.L696
	.p2align 4,,10
	.p2align 3
.L743:
	testq	%r13, %r13
	jne	.L741
.L698:
	movq	24(%r15), %r15
	testq	%r15, %r15
	je	.L742
.L703:
	movq	40(%r15), %r13
	movq	32(%r15), %rdi
	cmpq	$16, %r13
	jbe	.L743
	movl	$16, %edx
	movq	%rbp, %rsi
	call	memcmp@PLT
	testl	%eax, %eax
	jne	.L700
	leaq	-16(%r13), %rax
	cmpq	$2147483647, %rax
	jg	.L701
	cmpq	$-2147483648, %rax
	jl	.L698
	.p2align 4,,10
	.p2align 3
.L700:
	testl	%eax, %eax
	js	.L698
.L701:
	movq	%r15, %r12
	movq	16(%r15), %r15
	testq	%r15, %r15
	jne	.L703
.L742:
	cmpq	%r12, (%rsp)
	je	.L696
	movq	40(%r12), %r13
	movq	32(%r12), %rsi
	cmpq	$15, %r13
	jbe	.L744
	movl	$16, %edx
	movq	%rbp, %rdi
	call	memcmp@PLT
	testl	%eax, %eax
	je	.L745
.L707:
	testl	%eax, %eax
	jns	.L705
.L696:
	leaq	32(%rsp), %rbp
	leaq	24(%rsp), %rcx
	movq	%r12, %rsi
	leaq	64(%rbx), %rdi
	leaq	23(%rsp), %r8
	movq	%rbp, 24(%rsp)
	leaq	_ZSt19piecewise_construct(%rip), %rdx
.LEHB41:
	call	_ZNSt8_Rb_treeINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESt4pairIKS5_N9benchmark7CounterEESt10_Select1stISA_ESt4lessIS5_ESaISA_EE22_M_emplace_hint_uniqueIJRKSt21piecewise_construct_tSt5tupleIJOS5_EESL_IJEEEEESt17_Rb_tree_iteratorISA_ESt23_Rb_tree_const_iteratorISA_EDpOT_
.LEHE41:
	vmovsd	8(%rsp), %xmm1
	movq	32(%rsp), %rbp
	movabsq	$4294967296001, %rcx
	movq	%rcx, 72(%rax)
	vmovsd	%xmm1, 64(%rax)
	cmpq	%r14, %rbp
	je	.L687
.L713:
	movq	48(%rsp), %rax
	movq	%rbp, %rdi
	leaq	1(%rax), %rsi
	call	_ZdlPvm@PLT
.L687:
	movq	72(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L746
	addq	$88, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%rbp
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L741:
	.cfi_restore_state
	movq	%r13, %rdx
	movq	%rbp, %rsi
	call	memcmp@PLT
	testl	%eax, %eax
	jne	.L700
	leaq	-16(%r13), %rax
	testl	%eax, %eax
	jns	.L701
	jmp	.L698
.L688:
	movq	16(%rdi), %r12
.LEHB42:
	call	_ZN9benchmark5State16StartKeepRunningEv@PLT
.LEHE42:
	testq	%r12, %r12
	je	.L689
	movq	0(%rbp), %rax
	movq	8(%rbp), %rdx
	cmpq	%rax, %rdx
	je	.L715
	.p2align 4,,10
	.p2align 3
.L694:
	vxorpd	%xmm2, %xmm2, %xmm2
	.p2align 4,,10
	.p2align 3
.L692:
	movl	8(%rax), %edi
	vmovsd	(%rax), %xmm0
	addq	$16, %rax
	call	_ZL21pow_branchless_doubledj
	vaddsd	%xmm0, %xmm2, %xmm2
	cmpq	%rdx, %rax
	jne	.L692
.L691:
	vmovq	%xmm2, %rax
	testq	%r12, %r12
	jle	.L747
.L693:
	subq	$1, %r12
	je	.L689
	movq	0(%rbp), %rax
	movq	8(%rbp), %rdx
	cmpq	%rax, %rdx
	jne	.L694
	xorl	%eax, %eax
	jmp	.L693
.L745:
	movl	$16, %eax
	subq	%r13, %rax
	cmpq	$2147483647, %rax
	jg	.L705
	cmpq	$-2147483648, %rax
	jl	.L696
	testl	%eax, %eax
	js	.L696
.L705:
	movabsq	$4294967296001, %rax
	vmovsd	8(%rsp), %xmm3
	movq	%rax, 72(%r12)
	vmovsd	%xmm3, 64(%r12)
	jmp	.L713
.L744:
	testq	%r13, %r13
	je	.L705
	movq	%r13, %rdx
	movq	%rbp, %rdi
	call	memcmp@PLT
	testl	%eax, %eax
	je	.L705
	jmp	.L707
.L716:
	xorl	%edx, %edx
	jmp	.L695
.L715:
	vxorpd	%xmm2, %xmm2, %xmm2
	jmp	.L691
.L746:
	call	__stack_chk_fail@PLT
.L747:
	leaq	.LC32(%rip), %rcx
	movl	$234, %edx
	leaq	.LC33(%rip), %rsi
	leaq	.LC34(%rip), %rdi
	call	__assert_fail@PLT
.L718:
	endbr64
	movq	%rax, %rbx
	jmp	.L709
	.section	.gcc_except_table
.LLSDA13975:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSE13975-.LLSDACSB13975
.LLSDACSB13975:
	.uleb128 .LEHB40-.LFB13975
	.uleb128 .LEHE40-.LEHB40
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB41-.LFB13975
	.uleb128 .LEHE41-.LEHB41
	.uleb128 .L718-.LFB13975
	.uleb128 0
	.uleb128 .LEHB42-.LFB13975
	.uleb128 .LEHE42-.LEHB42
	.uleb128 0
	.uleb128 0
.LLSDACSE13975:
	.text
	.cfi_endproc
	.section	.text.unlikely
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gxx_personality_v0
	.cfi_lsda 0x1b,.LLSDAC13975
	.type	_Z9BM_DoubleIXadL_ZL21pow_branchless_doubledjEEEvRN9benchmark5StateERKSt6vectorI8TestCaseSaIS4_EE.cold, @function
_Z9BM_DoubleIXadL_ZL21pow_branchless_doubledjEEEvRN9benchmark5StateERKSt6vectorI8TestCaseSaIS4_EE.cold:
.LFSB13975:
.L709:
	.cfi_def_cfa_offset 144
	.cfi_offset 3, -56
	.cfi_offset 6, -48
	.cfi_offset 12, -40
	.cfi_offset 13, -32
	.cfi_offset 14, -24
	.cfi_offset 15, -16
	movq	%rbp, %rdi
	vzeroupper
	call	_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_disposeEv
	movq	72(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L748
	movq	%rbx, %rdi
.LEHB43:
	call	_Unwind_Resume@PLT
.LEHE43:
.L748:
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE13975:
	.section	.gcc_except_table
.LLSDAC13975:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSEC13975-.LLSDACSBC13975
.LLSDACSBC13975:
	.uleb128 .LEHB43-.LCOLDB40
	.uleb128 .LEHE43-.LEHB43
	.uleb128 0
	.uleb128 0
.LLSDACSEC13975:
	.section	.text.unlikely
	.text
	.size	_Z9BM_DoubleIXadL_ZL21pow_branchless_doubledjEEEvRN9benchmark5StateERKSt6vectorI8TestCaseSaIS4_EE, .-_Z9BM_DoubleIXadL_ZL21pow_branchless_doubledjEEEvRN9benchmark5StateERKSt6vectorI8TestCaseSaIS4_EE
	.section	.text.unlikely
	.size	_Z9BM_DoubleIXadL_ZL21pow_branchless_doubledjEEEvRN9benchmark5StateERKSt6vectorI8TestCaseSaIS4_EE.cold, .-_Z9BM_DoubleIXadL_ZL21pow_branchless_doubledjEEEvRN9benchmark5StateERKSt6vectorI8TestCaseSaIS4_EE.cold
.LCOLDE40:
	.text
.LHOTE40:
	.p2align 4
	.type	_ZL19BM_Branchless_Exp13RN9benchmark5StateE, @function
_ZL19BM_Branchless_Exp13RN9benchmark5StateE:
.LFB13395:
	.cfi_startproc
	endbr64
	leaq	_ZL10kTestExp13(%rip), %rsi
	jmp	_Z9BM_DoubleIXadL_ZL21pow_branchless_doubledjEEEvRN9benchmark5StateERKSt6vectorI8TestCaseSaIS4_EE
	.cfi_endproc
.LFE13395:
	.size	_ZL19BM_Branchless_Exp13RN9benchmark5StateE, .-_ZL19BM_Branchless_Exp13RN9benchmark5StateE
	.p2align 4
	.type	_ZL18BM_Branchless_Exp7RN9benchmark5StateE, @function
_ZL18BM_Branchless_Exp7RN9benchmark5StateE:
.LFB13388:
	.cfi_startproc
	endbr64
	leaq	_ZL9kTestExp7(%rip), %rsi
	jmp	_Z9BM_DoubleIXadL_ZL21pow_branchless_doubledjEEEvRN9benchmark5StateERKSt6vectorI8TestCaseSaIS4_EE
	.cfi_endproc
.LFE13388:
	.size	_ZL18BM_Branchless_Exp7RN9benchmark5StateE, .-_ZL18BM_Branchless_Exp7RN9benchmark5StateE
	.p2align 4
	.type	_ZL18BM_Branchless_Exp3RN9benchmark5StateE, @function
_ZL18BM_Branchless_Exp3RN9benchmark5StateE:
.LFB13381:
	.cfi_startproc
	endbr64
	leaq	_ZL9kTestExp3(%rip), %rsi
	jmp	_Z9BM_DoubleIXadL_ZL21pow_branchless_doubledjEEEvRN9benchmark5StateERKSt6vectorI8TestCaseSaIS4_EE
	.cfi_endproc
.LFE13381:
	.size	_ZL18BM_Branchless_Exp3RN9benchmark5StateE, .-_ZL18BM_Branchless_Exp3RN9benchmark5StateE
	.section	.text.unlikely
.LCOLDB41:
	.text
.LHOTB41:
	.p2align 4
	.type	_Z9BM_DoubleIXadL_ZL21wrap_pow_hierarchicaldjEEEvRN9benchmark5StateERKSt6vectorI8TestCaseSaIS4_EE, @function
_Z9BM_DoubleIXadL_ZL21wrap_pow_hierarchicaldjEEEvRN9benchmark5StateERKSt6vectorI8TestCaseSaIS4_EE:
.LFB13978:
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gxx_personality_v0
	.cfi_lsda 0x1b,.LLSDA13978
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	movq	%rdi, %r13
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	movq	%rsi, %r12
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	subq	$88, %rsp
	.cfi_def_cfa_offset 144
	movq	%fs:40, %rax
	movq	%rax, 72(%rsp)
	xorl	%eax, %eax
	movl	28(%rdi), %eax
	testl	%eax, %eax
	je	.L753
.LEHB44:
	call	_ZN9benchmark5State16StartKeepRunningEv@PLT
.L754:
	movq	%r13, %rdi
	call	_ZN9benchmark5State17FinishKeepRunningEv@PLT
	cmpb	$0, 24(%r13)
	je	.L781
	movq	16(%r13), %rdx
	subq	0(%r13), %rdx
	addq	8(%r13), %rdx
.L760:
	movq	8(%r12), %rax
	subq	(%r12), %rax
	vxorps	%xmm0, %xmm0, %xmm0
	leaq	48(%rsp), %r15
	sarq	$4, %rax
	movl	$17, %edi
	movq	%r15, 32(%rsp)
	imulq	%rdx, %rax
	vcvtsi2sdq	%rax, %xmm0, %xmm0
	vmovsd	%xmm0, 8(%rsp)
	call	_Znwm@PLT
.LEHE44:
	vmovdqa	.LC35(%rip), %xmm0
	movq	80(%r13), %r12
	movq	$16, 48(%rsp)
	movq	%rax, 32(%rsp)
	movq	%rax, %rbx
	movb	$0, 16(%rax)
	vmovdqu	%xmm0, (%rax)
	leaq	72(%r13), %rax
	movq	$16, 40(%rsp)
	movq	%rax, %rbp
	movq	%rax, (%rsp)
	testq	%r12, %r12
	jne	.L768
	jmp	.L761
	.p2align 4,,10
	.p2align 3
.L808:
	testq	%r14, %r14
	jne	.L806
.L763:
	movq	24(%r12), %r12
	testq	%r12, %r12
	je	.L807
.L768:
	movq	40(%r12), %r14
	movq	32(%r12), %rdi
	cmpq	$16, %r14
	jbe	.L808
	movl	$16, %edx
	movq	%rbx, %rsi
	call	memcmp@PLT
	testl	%eax, %eax
	jne	.L765
	leaq	-16(%r14), %rax
	cmpq	$2147483647, %rax
	jg	.L766
	cmpq	$-2147483648, %rax
	jl	.L763
	.p2align 4,,10
	.p2align 3
.L765:
	testl	%eax, %eax
	js	.L763
.L766:
	movq	%r12, %rbp
	movq	16(%r12), %r12
	testq	%r12, %r12
	jne	.L768
.L807:
	cmpq	%rbp, (%rsp)
	je	.L761
	movq	40(%rbp), %r14
	movq	32(%rbp), %rsi
	cmpq	$15, %r14
	jbe	.L809
	movl	$16, %edx
	movq	%rbx, %rdi
	call	memcmp@PLT
	testl	%eax, %eax
	je	.L810
.L772:
	testl	%eax, %eax
	jns	.L770
.L761:
	leaq	32(%rsp), %rbx
	leaq	24(%rsp), %rcx
	movq	%rbp, %rsi
	leaq	64(%r13), %rdi
	leaq	23(%rsp), %r8
	movq	%rbx, 24(%rsp)
	leaq	_ZSt19piecewise_construct(%rip), %rdx
.LEHB45:
	call	_ZNSt8_Rb_treeINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESt4pairIKS5_N9benchmark7CounterEESt10_Select1stISA_ESt4lessIS5_ESaISA_EE22_M_emplace_hint_uniqueIJRKSt21piecewise_construct_tSt5tupleIJOS5_EESL_IJEEEEESt17_Rb_tree_iteratorISA_ESt23_Rb_tree_const_iteratorISA_EDpOT_
.LEHE45:
	vmovsd	8(%rsp), %xmm1
	movq	32(%rsp), %rbx
	movabsq	$4294967296001, %rcx
	movq	%rcx, 72(%rax)
	vmovsd	%xmm1, 64(%rax)
	cmpq	%r15, %rbx
	je	.L752
.L778:
	movq	48(%rsp), %rax
	movq	%rbx, %rdi
	leaq	1(%rax), %rsi
	call	_ZdlPvm@PLT
.L752:
	movq	72(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L811
	addq	$88, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%rbp
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L806:
	.cfi_restore_state
	movq	%r14, %rdx
	movq	%rbx, %rsi
	call	memcmp@PLT
	testl	%eax, %eax
	jne	.L765
	leaq	-16(%r14), %rax
	testl	%eax, %eax
	jns	.L766
	jmp	.L763
.L753:
	movq	16(%rdi), %rbp
.LEHB46:
	call	_ZN9benchmark5State16StartKeepRunningEv@PLT
.LEHE46:
	testq	%rbp, %rbp
	je	.L754
	movq	(%r12), %rbx
	movq	8(%r12), %r14
	cmpq	%rbx, %r14
	je	.L780
	.p2align 4,,10
	.p2align 3
.L759:
	vxorpd	%xmm13, %xmm13, %xmm13
	.p2align 4,,10
	.p2align 3
.L757:
	movl	8(%rbx), %edi
	vmovsd	(%rbx), %xmm0
	addq	$16, %rbx
	call	_ZL21wrap_pow_hierarchicaldj
	vaddsd	%xmm0, %xmm13, %xmm13
	cmpq	%rbx, %r14
	jne	.L757
.L756:
	vmovq	%xmm13, %rax
	testq	%rbp, %rbp
	jle	.L812
.L758:
	subq	$1, %rbp
	je	.L754
	movq	(%r12), %rbx
	movq	8(%r12), %r14
	cmpq	%rbx, %r14
	jne	.L759
	xorl	%eax, %eax
	jmp	.L758
.L810:
	movl	$16, %eax
	subq	%r14, %rax
	cmpq	$2147483647, %rax
	jg	.L770
	cmpq	$-2147483648, %rax
	jl	.L761
	testl	%eax, %eax
	js	.L761
.L770:
	movabsq	$4294967296001, %rax
	vmovsd	8(%rsp), %xmm2
	movq	%rax, 72(%rbp)
	vmovsd	%xmm2, 64(%rbp)
	jmp	.L778
.L809:
	testq	%r14, %r14
	je	.L770
	movq	%r14, %rdx
	movq	%rbx, %rdi
	call	memcmp@PLT
	testl	%eax, %eax
	je	.L770
	jmp	.L772
.L781:
	xorl	%edx, %edx
	jmp	.L760
.L780:
	vxorpd	%xmm13, %xmm13, %xmm13
	jmp	.L756
.L811:
	call	__stack_chk_fail@PLT
.L812:
	leaq	.LC32(%rip), %rcx
	movl	$234, %edx
	leaq	.LC33(%rip), %rsi
	leaq	.LC34(%rip), %rdi
	call	__assert_fail@PLT
.L783:
	endbr64
	movq	%rax, %rbp
	jmp	.L774
	.section	.gcc_except_table
.LLSDA13978:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSE13978-.LLSDACSB13978
.LLSDACSB13978:
	.uleb128 .LEHB44-.LFB13978
	.uleb128 .LEHE44-.LEHB44
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB45-.LFB13978
	.uleb128 .LEHE45-.LEHB45
	.uleb128 .L783-.LFB13978
	.uleb128 0
	.uleb128 .LEHB46-.LFB13978
	.uleb128 .LEHE46-.LEHB46
	.uleb128 0
	.uleb128 0
.LLSDACSE13978:
	.text
	.cfi_endproc
	.section	.text.unlikely
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gxx_personality_v0
	.cfi_lsda 0x1b,.LLSDAC13978
	.type	_Z9BM_DoubleIXadL_ZL21wrap_pow_hierarchicaldjEEEvRN9benchmark5StateERKSt6vectorI8TestCaseSaIS4_EE.cold, @function
_Z9BM_DoubleIXadL_ZL21wrap_pow_hierarchicaldjEEEvRN9benchmark5StateERKSt6vectorI8TestCaseSaIS4_EE.cold:
.LFSB13978:
.L774:
	.cfi_def_cfa_offset 144
	.cfi_offset 3, -56
	.cfi_offset 6, -48
	.cfi_offset 12, -40
	.cfi_offset 13, -32
	.cfi_offset 14, -24
	.cfi_offset 15, -16
	movq	%rbx, %rdi
	vzeroupper
	call	_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_disposeEv
	movq	72(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L813
	movq	%rbp, %rdi
.LEHB47:
	call	_Unwind_Resume@PLT
.LEHE47:
.L813:
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE13978:
	.section	.gcc_except_table
.LLSDAC13978:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSEC13978-.LLSDACSBC13978
.LLSDACSBC13978:
	.uleb128 .LEHB47-.LCOLDB41
	.uleb128 .LEHE47-.LEHB47
	.uleb128 0
	.uleb128 0
.LLSDACSEC13978:
	.section	.text.unlikely
	.text
	.size	_Z9BM_DoubleIXadL_ZL21wrap_pow_hierarchicaldjEEEvRN9benchmark5StateERKSt6vectorI8TestCaseSaIS4_EE, .-_Z9BM_DoubleIXadL_ZL21wrap_pow_hierarchicaldjEEEvRN9benchmark5StateERKSt6vectorI8TestCaseSaIS4_EE
	.section	.text.unlikely
	.size	_Z9BM_DoubleIXadL_ZL21wrap_pow_hierarchicaldjEEEvRN9benchmark5StateERKSt6vectorI8TestCaseSaIS4_EE.cold, .-_Z9BM_DoubleIXadL_ZL21wrap_pow_hierarchicaldjEEEvRN9benchmark5StateERKSt6vectorI8TestCaseSaIS4_EE.cold
.LCOLDE41:
	.text
.LHOTE41:
	.p2align 4
	.type	_ZL21BM_Hierarchical_Exp13RN9benchmark5StateE, @function
_ZL21BM_Hierarchical_Exp13RN9benchmark5StateE:
.LFB13398:
	.cfi_startproc
	endbr64
	leaq	_ZL10kTestExp13(%rip), %rsi
	jmp	_Z9BM_DoubleIXadL_ZL21wrap_pow_hierarchicaldjEEEvRN9benchmark5StateERKSt6vectorI8TestCaseSaIS4_EE
	.cfi_endproc
.LFE13398:
	.size	_ZL21BM_Hierarchical_Exp13RN9benchmark5StateE, .-_ZL21BM_Hierarchical_Exp13RN9benchmark5StateE
	.p2align 4
	.type	_ZL20BM_Hierarchical_Exp7RN9benchmark5StateE, @function
_ZL20BM_Hierarchical_Exp7RN9benchmark5StateE:
.LFB13391:
	.cfi_startproc
	endbr64
	leaq	_ZL9kTestExp7(%rip), %rsi
	jmp	_Z9BM_DoubleIXadL_ZL21wrap_pow_hierarchicaldjEEEvRN9benchmark5StateERKSt6vectorI8TestCaseSaIS4_EE
	.cfi_endproc
.LFE13391:
	.size	_ZL20BM_Hierarchical_Exp7RN9benchmark5StateE, .-_ZL20BM_Hierarchical_Exp7RN9benchmark5StateE
	.p2align 4
	.type	_ZL20BM_Hierarchical_Exp3RN9benchmark5StateE, @function
_ZL20BM_Hierarchical_Exp3RN9benchmark5StateE:
.LFB13384:
	.cfi_startproc
	endbr64
	leaq	_ZL9kTestExp3(%rip), %rsi
	jmp	_Z9BM_DoubleIXadL_ZL21wrap_pow_hierarchicaldjEEEvRN9benchmark5StateERKSt6vectorI8TestCaseSaIS4_EE
	.cfi_endproc
.LFE13384:
	.size	_ZL20BM_Hierarchical_Exp3RN9benchmark5StateE, .-_ZL20BM_Hierarchical_Exp3RN9benchmark5StateE
	.section	.text.unlikely
.LCOLDB42:
	.text
.LHOTB42:
	.p2align 4
	.type	_Z9BM_DoubleIXadL_ZL13pow_asm_blenddjEEEvRN9benchmark5StateERKSt6vectorI8TestCaseSaIS4_EE, @function
_Z9BM_DoubleIXadL_ZL13pow_asm_blenddjEEEvRN9benchmark5StateERKSt6vectorI8TestCaseSaIS4_EE:
.LFB13976:
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gxx_personality_v0
	.cfi_lsda 0x1b,.LLSDA13976
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	movq	%rdi, %r13
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	movq	%rsi, %r12
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	subq	$88, %rsp
	.cfi_def_cfa_offset 144
	movq	%fs:40, %rax
	movq	%rax, 72(%rsp)
	xorl	%eax, %eax
	movl	28(%rdi), %eax
	testl	%eax, %eax
	je	.L818
.LEHB48:
	call	_ZN9benchmark5State16StartKeepRunningEv@PLT
.L819:
	movq	%r13, %rdi
	call	_ZN9benchmark5State17FinishKeepRunningEv@PLT
	cmpb	$0, 24(%r13)
	je	.L846
	movq	16(%r13), %rdx
	subq	0(%r13), %rdx
	addq	8(%r13), %rdx
.L825:
	movq	8(%r12), %rax
	subq	(%r12), %rax
	vxorps	%xmm0, %xmm0, %xmm0
	leaq	48(%rsp), %r15
	sarq	$4, %rax
	movl	$17, %edi
	movq	%r15, 32(%rsp)
	imulq	%rdx, %rax
	vcvtsi2sdq	%rax, %xmm0, %xmm0
	vmovsd	%xmm0, 8(%rsp)
	call	_Znwm@PLT
.LEHE48:
	vmovdqa	.LC35(%rip), %xmm0
	movq	80(%r13), %r12
	movq	$16, 48(%rsp)
	movq	%rax, 32(%rsp)
	movq	%rax, %rbx
	movb	$0, 16(%rax)
	vmovdqu	%xmm0, (%rax)
	leaq	72(%r13), %rax
	movq	$16, 40(%rsp)
	movq	%rax, %rbp
	movq	%rax, (%rsp)
	testq	%r12, %r12
	jne	.L833
	jmp	.L826
	.p2align 4,,10
	.p2align 3
.L873:
	testq	%r14, %r14
	jne	.L871
.L828:
	movq	24(%r12), %r12
	testq	%r12, %r12
	je	.L872
.L833:
	movq	40(%r12), %r14
	movq	32(%r12), %rdi
	cmpq	$16, %r14
	jbe	.L873
	movl	$16, %edx
	movq	%rbx, %rsi
	call	memcmp@PLT
	testl	%eax, %eax
	jne	.L830
	leaq	-16(%r14), %rax
	cmpq	$2147483647, %rax
	jg	.L831
	cmpq	$-2147483648, %rax
	jl	.L828
	.p2align 4,,10
	.p2align 3
.L830:
	testl	%eax, %eax
	js	.L828
.L831:
	movq	%r12, %rbp
	movq	16(%r12), %r12
	testq	%r12, %r12
	jne	.L833
.L872:
	cmpq	%rbp, (%rsp)
	je	.L826
	movq	40(%rbp), %r14
	movq	32(%rbp), %rsi
	cmpq	$15, %r14
	jbe	.L874
	movl	$16, %edx
	movq	%rbx, %rdi
	call	memcmp@PLT
	testl	%eax, %eax
	je	.L875
.L837:
	testl	%eax, %eax
	jns	.L835
.L826:
	leaq	32(%rsp), %rbx
	leaq	24(%rsp), %rcx
	movq	%rbp, %rsi
	leaq	64(%r13), %rdi
	leaq	23(%rsp), %r8
	movq	%rbx, 24(%rsp)
	leaq	_ZSt19piecewise_construct(%rip), %rdx
.LEHB49:
	call	_ZNSt8_Rb_treeINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESt4pairIKS5_N9benchmark7CounterEESt10_Select1stISA_ESt4lessIS5_ESaISA_EE22_M_emplace_hint_uniqueIJRKSt21piecewise_construct_tSt5tupleIJOS5_EESL_IJEEEEESt17_Rb_tree_iteratorISA_ESt23_Rb_tree_const_iteratorISA_EDpOT_
.LEHE49:
	vmovsd	8(%rsp), %xmm3
	movq	32(%rsp), %rbx
	movabsq	$4294967296001, %rcx
	movq	%rcx, 72(%rax)
	vmovsd	%xmm3, 64(%rax)
	cmpq	%r15, %rbx
	je	.L817
.L843:
	movq	48(%rsp), %rax
	movq	%rbx, %rdi
	leaq	1(%rax), %rsi
	call	_ZdlPvm@PLT
.L817:
	movq	72(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L876
	addq	$88, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%rbp
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L871:
	.cfi_restore_state
	movq	%r14, %rdx
	movq	%rbx, %rsi
	call	memcmp@PLT
	testl	%eax, %eax
	jne	.L830
	leaq	-16(%r14), %rax
	testl	%eax, %eax
	jns	.L831
	jmp	.L828
.L818:
	movq	16(%rdi), %rbp
.LEHB50:
	call	_ZN9benchmark5State16StartKeepRunningEv@PLT
.LEHE50:
	testq	%rbp, %rbp
	je	.L819
	movq	(%r12), %rbx
	movq	8(%r12), %r14
	cmpq	%rbx, %r14
	je	.L845
	.p2align 4,,10
	.p2align 3
.L824:
	movq	$0x000000000, (%rsp)
	.p2align 4,,10
	.p2align 3
.L822:
	movl	8(%rbx), %edi
	vmovsd	(%rbx), %xmm0
	addq	$16, %rbx
	call	_ZL13pow_asm_blenddj
	vaddsd	(%rsp), %xmm0, %xmm1
	vmovsd	%xmm1, (%rsp)
	cmpq	%rbx, %r14
	jne	.L822
	vmovq	%xmm1, %rax
.L821:
	testq	%rbp, %rbp
	jle	.L877
.L823:
	subq	$1, %rbp
	je	.L819
	movq	(%r12), %rbx
	movq	8(%r12), %r14
	cmpq	%rbx, %r14
	jne	.L824
	xorl	%eax, %eax
	jmp	.L823
.L875:
	movl	$16, %eax
	subq	%r14, %rax
	cmpq	$2147483647, %rax
	jg	.L835
	cmpq	$-2147483648, %rax
	jl	.L826
	testl	%eax, %eax
	js	.L826
.L835:
	movabsq	$4294967296001, %rax
	vmovsd	8(%rsp), %xmm4
	movq	%rax, 72(%rbp)
	vmovsd	%xmm4, 64(%rbp)
	jmp	.L843
.L874:
	testq	%r14, %r14
	je	.L835
	movq	%r14, %rdx
	movq	%rbx, %rdi
	call	memcmp@PLT
	testl	%eax, %eax
	je	.L835
	jmp	.L837
.L846:
	xorl	%edx, %edx
	jmp	.L825
.L845:
	movq	$0x000000000, (%rsp)
	movq	(%rsp), %rax
	jmp	.L821
.L876:
	call	__stack_chk_fail@PLT
.L877:
	leaq	.LC32(%rip), %rcx
	movl	$234, %edx
	leaq	.LC33(%rip), %rsi
	leaq	.LC34(%rip), %rdi
	call	__assert_fail@PLT
.L848:
	endbr64
	movq	%rax, %rbp
	jmp	.L839
	.section	.gcc_except_table
.LLSDA13976:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSE13976-.LLSDACSB13976
.LLSDACSB13976:
	.uleb128 .LEHB48-.LFB13976
	.uleb128 .LEHE48-.LEHB48
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB49-.LFB13976
	.uleb128 .LEHE49-.LEHB49
	.uleb128 .L848-.LFB13976
	.uleb128 0
	.uleb128 .LEHB50-.LFB13976
	.uleb128 .LEHE50-.LEHB50
	.uleb128 0
	.uleb128 0
.LLSDACSE13976:
	.text
	.cfi_endproc
	.section	.text.unlikely
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gxx_personality_v0
	.cfi_lsda 0x1b,.LLSDAC13976
	.type	_Z9BM_DoubleIXadL_ZL13pow_asm_blenddjEEEvRN9benchmark5StateERKSt6vectorI8TestCaseSaIS4_EE.cold, @function
_Z9BM_DoubleIXadL_ZL13pow_asm_blenddjEEEvRN9benchmark5StateERKSt6vectorI8TestCaseSaIS4_EE.cold:
.LFSB13976:
.L839:
	.cfi_def_cfa_offset 144
	.cfi_offset 3, -56
	.cfi_offset 6, -48
	.cfi_offset 12, -40
	.cfi_offset 13, -32
	.cfi_offset 14, -24
	.cfi_offset 15, -16
	movq	%rbx, %rdi
	vzeroupper
	call	_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_disposeEv
	movq	72(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L878
	movq	%rbp, %rdi
.LEHB51:
	call	_Unwind_Resume@PLT
.LEHE51:
.L878:
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE13976:
	.section	.gcc_except_table
.LLSDAC13976:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSEC13976-.LLSDACSBC13976
.LLSDACSBC13976:
	.uleb128 .LEHB51-.LCOLDB42
	.uleb128 .LEHE51-.LEHB51
	.uleb128 0
	.uleb128 0
.LLSDACSEC13976:
	.section	.text.unlikely
	.text
	.size	_Z9BM_DoubleIXadL_ZL13pow_asm_blenddjEEEvRN9benchmark5StateERKSt6vectorI8TestCaseSaIS4_EE, .-_Z9BM_DoubleIXadL_ZL13pow_asm_blenddjEEEvRN9benchmark5StateERKSt6vectorI8TestCaseSaIS4_EE
	.section	.text.unlikely
	.size	_Z9BM_DoubleIXadL_ZL13pow_asm_blenddjEEEvRN9benchmark5StateERKSt6vectorI8TestCaseSaIS4_EE.cold, .-_Z9BM_DoubleIXadL_ZL13pow_asm_blenddjEEEvRN9benchmark5StateERKSt6vectorI8TestCaseSaIS4_EE.cold
.LCOLDE42:
	.text
.LHOTE42:
	.p2align 4
	.type	_ZL17BM_AsmBlend_Exp13RN9benchmark5StateE, @function
_ZL17BM_AsmBlend_Exp13RN9benchmark5StateE:
.LFB13396:
	.cfi_startproc
	endbr64
	leaq	_ZL10kTestExp13(%rip), %rsi
	jmp	_Z9BM_DoubleIXadL_ZL13pow_asm_blenddjEEEvRN9benchmark5StateERKSt6vectorI8TestCaseSaIS4_EE
	.cfi_endproc
.LFE13396:
	.size	_ZL17BM_AsmBlend_Exp13RN9benchmark5StateE, .-_ZL17BM_AsmBlend_Exp13RN9benchmark5StateE
	.p2align 4
	.type	_ZL16BM_AsmBlend_Exp7RN9benchmark5StateE, @function
_ZL16BM_AsmBlend_Exp7RN9benchmark5StateE:
.LFB13389:
	.cfi_startproc
	endbr64
	leaq	_ZL9kTestExp7(%rip), %rsi
	jmp	_Z9BM_DoubleIXadL_ZL13pow_asm_blenddjEEEvRN9benchmark5StateERKSt6vectorI8TestCaseSaIS4_EE
	.cfi_endproc
.LFE13389:
	.size	_ZL16BM_AsmBlend_Exp7RN9benchmark5StateE, .-_ZL16BM_AsmBlend_Exp7RN9benchmark5StateE
	.p2align 4
	.type	_ZL16BM_AsmBlend_Exp3RN9benchmark5StateE, @function
_ZL16BM_AsmBlend_Exp3RN9benchmark5StateE:
.LFB13382:
	.cfi_startproc
	endbr64
	leaq	_ZL9kTestExp3(%rip), %rsi
	jmp	_Z9BM_DoubleIXadL_ZL13pow_asm_blenddjEEEvRN9benchmark5StateERKSt6vectorI8TestCaseSaIS4_EE
	.cfi_endproc
.LFE13382:
	.size	_ZL16BM_AsmBlend_Exp3RN9benchmark5StateE, .-_ZL16BM_AsmBlend_Exp3RN9benchmark5StateE
	.section	.text._ZNSt23mersenne_twister_engineImLm64ELm312ELm156ELm31ELm13043109905998158313ELm29ELm6148914691236517205ELm17ELm8202884508482404352ELm37ELm18444473444759240704ELm43ELm6364136223846793005EE11_M_gen_randEv,"axG",@progbits,_ZNSt23mersenne_twister_engineImLm64ELm312ELm156ELm31ELm13043109905998158313ELm29ELm6148914691236517205ELm17ELm8202884508482404352ELm37ELm18444473444759240704ELm43ELm6364136223846793005EE11_M_gen_randEv,comdat
	.align 2
	.p2align 4
	.weak	_ZNSt23mersenne_twister_engineImLm64ELm312ELm156ELm31ELm13043109905998158313ELm29ELm6148914691236517205ELm17ELm8202884508482404352ELm37ELm18444473444759240704ELm43ELm6364136223846793005EE11_M_gen_randEv
	.type	_ZNSt23mersenne_twister_engineImLm64ELm312ELm156ELm31ELm13043109905998158313ELm29ELm6148914691236517205ELm17ELm8202884508482404352ELm37ELm18444473444759240704ELm43ELm6364136223846793005EE11_M_gen_randEv, @function
_ZNSt23mersenne_twister_engineImLm64ELm312ELm156ELm31ELm13043109905998158313ELm29ELm6148914691236517205ELm17ELm8202884508482404352ELm37ELm18444473444759240704ELm43ELm6364136223846793005EE11_M_gen_randEv:
.LFB14915:
	.cfi_startproc
	endbr64
	movabsq	$-5403634167711393303, %rsi
	movq	%rdi, %rdx
	movq	%rdi, %rax
	vpbroadcastq	.LC51(%rip), %ymm5
	vmovq	%rsi, %xmm2
	leaq	1248(%rdi), %rcx
	vpxor	%xmm6, %xmm6, %xmm6
	vpbroadcastq	.LC52(%rip), %ymm4
	vpbroadcastq	.LC53(%rip), %ymm3
	vpbroadcastq	%xmm2, %ymm2
	.p2align 4,,10
	.p2align 3
.L883:
	vpand	8(%rax), %ymm4, %ymm1
	vpand	(%rax), %ymm5, %ymm0
	addq	$32, %rax
	vpor	%ymm1, %ymm0, %ymm0
	vpsrlq	$1, %ymm0, %ymm1
	vpand	%ymm3, %ymm0, %ymm0
	vpxor	1216(%rax), %ymm1, %ymm1
	vpsubq	%ymm0, %ymm6, %ymm0
	vpand	%ymm2, %ymm0, %ymm0
	vpxor	%ymm0, %ymm1, %ymm0
	vmovdqu	%ymm0, -32(%rax)
	cmpq	%rcx, %rax
	jne	.L883
	movq	$-2147483648, %rsi
	leaq	2464(%rdx), %rcx
	vpxor	%xmm6, %xmm6, %xmm6
	vmovq	%rsi, %xmm0
	movl	$2147483647, %esi
	vmovq	%rsi, %xmm1
	movl	$1, %esi
	vpbroadcastq	%xmm0, %ymm9
	vmovq	%rsi, %xmm2
	vpbroadcastq	%xmm1, %ymm8
	movabsq	$-5403634167711393303, %rsi
	vmovq	%rsi, %xmm5
	vpbroadcastq	%xmm2, %ymm7
	vpbroadcastq	%xmm5, %ymm5
	.p2align 4,,10
	.p2align 3
.L884:
	vpand	8(%rax), %ymm8, %ymm4
	vpand	(%rax), %ymm9, %ymm3
	addq	$32, %rax
	vpor	%ymm4, %ymm3, %ymm3
	vpsrlq	$1, %ymm3, %ymm4
	vpand	%ymm7, %ymm3, %ymm3
	vpxor	-1280(%rax), %ymm4, %ymm4
	vpsubq	%ymm3, %ymm6, %ymm3
	vpand	%ymm5, %ymm3, %ymm3
	vpxor	%ymm3, %ymm4, %ymm3
	vmovdqu	%ymm3, -32(%rax)
	cmpq	%rax, %rcx
	jne	.L884
	movq	2488(%rdx), %rdi
	vpunpcklqdq	%xmm1, %xmm1, %xmm1
	vpunpcklqdq	%xmm0, %xmm0, %xmm0
	vpunpcklqdq	%xmm2, %xmm2, %xmm2
	movq	2480(%rdx), %rax
	vpand	2472(%rdx), %xmm1, %xmm1
	vmovq	%rsi, %xmm7
	movq	$0, 2496(%rdx)
	movq	%rdi, %rcx
	andq	$-2147483648, %rdi
	vpand	2464(%rdx), %xmm0, %xmm0
	andl	$2147483647, %ecx
	andq	$-2147483648, %rax
	orq	%rcx, %rax
	vpor	%xmm1, %xmm0, %xmm0
	movq	%rax, %rcx
	vpsrlq	$1, %xmm0, %xmm1
	vpand	%xmm2, %xmm0, %xmm0
	andl	$1, %eax
	negq	%rax
	shrq	%rcx
	xorq	1232(%rdx), %rcx
	vpxor	%xmm2, %xmm2, %xmm2
	andq	%rsi, %rax
	vpxor	1216(%rdx), %xmm1, %xmm1
	vpsubq	%xmm0, %xmm2, %xmm0
	xorq	%rcx, %rax
	vpunpcklqdq	%xmm7, %xmm7, %xmm2
	movq	%rax, 2480(%rdx)
	movq	(%rdx), %rax
	vpand	%xmm2, %xmm0, %xmm0
	vpxor	%xmm0, %xmm1, %xmm0
	andl	$2147483647, %eax
	vmovdqu	%xmm0, 2464(%rdx)
	orq	%rdi, %rax
	movq	%rax, %rcx
	andl	$1, %eax
	negq	%rax
	shrq	%rcx
	xorq	1240(%rdx), %rcx
	andq	%rsi, %rax
	xorq	%rcx, %rax
	movq	%rax, 2488(%rdx)
	vzeroupper
	ret
	.cfi_endproc
.LFE14915:
	.size	_ZNSt23mersenne_twister_engineImLm64ELm312ELm156ELm31ELm13043109905998158313ELm29ELm6148914691236517205ELm17ELm8202884508482404352ELm37ELm18444473444759240704ELm43ELm6364136223846793005EE11_M_gen_randEv, .-_ZNSt23mersenne_twister_engineImLm64ELm312ELm156ELm31ELm13043109905998158313ELm29ELm6148914691236517205ELm17ELm8202884508482404352ELm37ELm18444473444759240704ELm43ELm6364136223846793005EE11_M_gen_randEv
	.section	.rodata.str1.1
.LC58:
	.string	"vector::_M_realloc_insert"
	.section	.text.unlikely
.LCOLDB60:
	.section	.text.startup
.LHOTB60:
	.p2align 4
	.type	_ZL18generate_test_datajm.constprop.0, @function
_ZL18generate_test_datajm.constprop.0:
.LFB14993:
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gxx_personality_v0
	.cfi_lsda 0x1b,.LLSDA14993
	movabsq	$6364136223846793005, %rcx
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	leal	42(%rsi), %edx
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	movl	%esi, %r14d
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	movq	%rdi, %r12
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	movl	$1, %ebx
	subq	$2568, %rsp
	.cfi_def_cfa_offset 2624
	movq	%fs:40, %rax
	movq	%rax, 2552(%rsp)
	xorl	%eax, %eax
	movq	%rdx, 48(%rsp)
	leaq	48(%rsp), %rbp
	.p2align 4,,10
	.p2align 3
.L888:
	movq	%rdx, %rax
	shrq	$62, %rax
	xorq	%rdx, %rax
	imulq	%rcx, %rax
	leaq	(%rax,%rbx), %rdx
	movq	%rdx, 0(%rbp,%rbx,8)
	addq	$1, %rbx
	cmpq	$312, %rbx
	jne	.L888
	movq	$0, 16(%r12)
	vpxor	%xmm0, %xmm0, %xmm0
	movl	$16384, %edi
	vmovdqu	%xmm0, (%r12)
	movq	$312, 2544(%rsp)
.LEHB52:
	call	_Znwm@PLT
	movq	(%r12), %r15
	movq	8(%r12), %rdx
	vmovq	%rax, %xmm6
	movq	%rax, %r13
	vpunpcklqdq	%xmm6, %xmm6, %xmm0
	subq	%r15, %rdx
	testq	%rdx, %rdx
	jg	.L930
	testq	%r15, %r15
	jne	.L931
.L891:
	addq	$16384, %r13
	vmovdqu	%xmm0, (%r12)
	movabsq	$8202884508482404352, %r15
	movq	%r13, 16(%r12)
	movl	$1024, %r13d
	jmp	.L892
	.p2align 4,,10
	.p2align 3
.L934:
	vxorpd	%xmm3, %xmm3, %xmm3
	vcvtsi2sdq	%rax, %xmm3, %xmm0
	vcomisd	.LC55(%rip), %xmm0
	jnb	.L913
.L935:
	vmovsd	.LC57(%rip), %xmm1
	movq	8(%r12), %rax
	vfmadd132sd	.LC56(%rip), %xmm1, %xmm0
	vmovsd	%xmm0, (%rsp)
	cmpq	16(%r12), %rax
	je	.L898
.L936:
	vmovsd	(%rsp), %xmm2
	movl	%r14d, 8(%rax)
	addq	$16, %rax
	vmovsd	%xmm2, -16(%rax)
	movq	%rax, 8(%r12)
	subq	$1, %r13
	je	.L932
.L892:
	movq	%rbx, %rax
	cmpq	$311, %rbx
	ja	.L933
.L897:
	movabsq	$6148914691236517205, %rsi
	leaq	1(%rax), %rbx
	movq	48(%rsp,%rax,8), %rax
	movabsq	$-2270628950310912, %rcx
	movq	%rbx, 2544(%rsp)
	movq	%rax, %rdx
	shrq	$29, %rdx
	andq	%rsi, %rdx
	xorq	%rdx, %rax
	movq	%rax, %rdx
	salq	$17, %rdx
	andq	%r15, %rdx
	xorq	%rdx, %rax
	movq	%rax, %rdx
	salq	$37, %rdx
	andq	%rcx, %rdx
	xorq	%rdx, %rax
	movq	%rax, %rdx
	shrq	$43, %rdx
	xorq	%rdx, %rax
	jns	.L934
	movq	%rax, %rdx
	andl	$1, %eax
	vxorpd	%xmm4, %xmm4, %xmm4
	shrq	%rdx
	orq	%rax, %rdx
	vcvtsi2sdq	%rdx, %xmm4, %xmm0
	vaddsd	%xmm0, %xmm0, %xmm0
	vcomisd	.LC55(%rip), %xmm0
	jb	.L935
.L913:
	vmovsd	.LC54(%rip), %xmm7
	movq	8(%r12), %rax
	vmovsd	%xmm7, (%rsp)
	cmpq	16(%r12), %rax
	jne	.L936
	.p2align 4,,10
	.p2align 3
.L898:
	movq	(%r12), %rsi
	movq	%rax, %rdi
	movabsq	$576460752303423487, %rcx
	subq	%rsi, %rdi
	movq	%rsi, 24(%rsp)
	movq	%rdi, %rdx
	movq	%rdi, 40(%rsp)
	sarq	$4, %rdx
	cmpq	%rcx, %rdx
	je	.L937
	cmpq	%rsi, %rax
	je	.L938
	leaq	(%rdx,%rdx), %rax
	movq	%rax, 32(%rsp)
	cmpq	%rdx, %rax
	jb	.L905
	xorl	%ecx, %ecx
	testq	%rax, %rax
	jne	.L939
.L906:
	movq	40(%rsp), %rdx
	vmovsd	(%rsp), %xmm5
	leaq	(%rcx,%rdx), %rax
	leaq	16(%rcx,%rdx), %r8
	movl	%r14d, 8(%rax)
	vmovsd	%xmm5, (%rax)
	testq	%rdx, %rdx
	jg	.L940
	cmpq	$0, 24(%rsp)
	jne	.L941
.L909:
	movq	32(%rsp), %rax
	movq	%rcx, (%r12)
	movq	%r8, 8(%r12)
	addq	%rax, %rcx
	movq	%rcx, 16(%r12)
	subq	$1, %r13
	jne	.L892
.L932:
	movq	2552(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L929
	addq	$2568, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	movq	%r12, %rax
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%rbp
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L933:
	.cfi_restore_state
	movq	%rbp, %rdi
	call	_ZNSt23mersenne_twister_engineImLm64ELm312ELm156ELm31ELm13043109905998158313ELm29ELm6148914691236517205ELm17ELm8202884508482404352ELm37ELm18444473444759240704ELm43ELm6364136223846793005EE11_M_gen_randEv
	movq	2544(%rsp), %rax
	jmp	.L897
.L938:
	addq	$1, %rdx
	jc	.L905
	movabsq	$576460752303423487, %rcx
	cmpq	%rcx, %rdx
	cmovbe	%rdx, %rcx
.L905:
	salq	$4, %rcx
	movq	%rcx, %rdi
	movq	%rcx, 32(%rsp)
	call	_Znwm@PLT
	movq	%rax, %rcx
	jmp	.L906
.L940:
	movq	24(%rsp), %rsi
	movq	%rcx, %rdi
	movq	%r8, (%rsp)
	call	memmove@PLT
	movq	24(%rsp), %rdi
	movq	(%rsp), %r8
	movq	%rax, %rcx
	movq	16(%r12), %rax
	subq	%rdi, %rax
	movq	%rax, %rsi
.L908:
	movq	24(%rsp), %rdi
	movq	%rcx, 40(%rsp)
	movq	%r8, (%rsp)
	call	_ZdlPvm@PLT
	movq	40(%rsp), %rcx
	movq	(%rsp), %r8
	jmp	.L909
.L941:
	movq	16(%r12), %rsi
	movq	24(%rsp), %rax
	subq	%rax, %rsi
	jmp	.L908
.L930:
	movq	%r15, %rsi
	movq	%rax, %rdi
	vmovdqa	%xmm0, (%rsp)
	call	memmove@PLT
	movq	16(%r12), %rsi
	vmovdqa	(%rsp), %xmm0
	subq	%r15, %rsi
.L890:
	movq	%r15, %rdi
	vmovdqa	%xmm0, (%rsp)
	call	_ZdlPvm@PLT
	vmovdqa	(%rsp), %xmm0
	jmp	.L891
.L931:
	movq	16(%r12), %rsi
	subq	%r15, %rsi
	jmp	.L890
.L939:
	movabsq	$576460752303423487, %rcx
	cmpq	%rcx, %rax
	cmovbe	%rax, %rcx
	jmp	.L905
.L937:
	movq	2552(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L929
	leaq	.LC58(%rip), %rdi
	call	_ZSt20__throw_length_errorPKc@PLT
.LEHE52:
.L929:
	call	__stack_chk_fail@PLT
.L917:
	endbr64
	movq	%rax, %rbx
	jmp	.L910
	.section	.gcc_except_table
.LLSDA14993:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSE14993-.LLSDACSB14993
.LLSDACSB14993:
	.uleb128 .LEHB52-.LFB14993
	.uleb128 .LEHE52-.LEHB52
	.uleb128 .L917-.LFB14993
	.uleb128 0
.LLSDACSE14993:
	.section	.text.startup
	.cfi_endproc
	.section	.text.unlikely
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gxx_personality_v0
	.cfi_lsda 0x1b,.LLSDAC14993
	.type	_ZL18generate_test_datajm.constprop.0.cold, @function
_ZL18generate_test_datajm.constprop.0.cold:
.LFSB14993:
.L910:
	.cfi_def_cfa_offset 2624
	.cfi_offset 3, -56
	.cfi_offset 6, -48
	.cfi_offset 12, -40
	.cfi_offset 13, -32
	.cfi_offset 14, -24
	.cfi_offset 15, -16
	movq	%r12, %rdi
	vzeroupper
	call	_ZNSt6vectorI8TestCaseSaIS0_EED1Ev
	movq	2552(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L942
	movq	%rbx, %rdi
.LEHB53:
	call	_Unwind_Resume@PLT
.LEHE53:
.L942:
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE14993:
	.section	.gcc_except_table
.LLSDAC14993:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSEC14993-.LLSDACSBC14993
.LLSDACSBC14993:
	.uleb128 .LEHB53-.LCOLDB60
	.uleb128 .LEHE53-.LEHB53
	.uleb128 0
	.uleb128 0
.LLSDACSEC14993:
	.section	.text.unlikely
	.section	.text.startup
	.size	_ZL18generate_test_datajm.constprop.0, .-_ZL18generate_test_datajm.constprop.0
	.section	.text.unlikely
	.size	_ZL18generate_test_datajm.constprop.0.cold, .-_ZL18generate_test_datajm.constprop.0.cold
.LCOLDE60:
	.section	.text.startup
.LHOTE60:
	.section	.rodata.str1.1
.LC61:
	.string	"BM_ScalarLoop_Exp3"
.LC62:
	.string	"BM_Branchless_Exp3"
.LC63:
	.string	"BM_AsmBlend_Exp3"
.LC64:
	.string	"BM_AsmMul1_Exp3"
.LC65:
	.string	"BM_Hierarchical_Exp3"
.LC66:
	.string	"BM_Binary_Exp3"
.LC67:
	.string	"BM_StdPow_Exp3"
.LC68:
	.string	"BM_ScalarLoop_Exp7"
.LC69:
	.string	"BM_Branchless_Exp7"
.LC70:
	.string	"BM_AsmBlend_Exp7"
.LC71:
	.string	"BM_AsmMul1_Exp7"
.LC72:
	.string	"BM_Hierarchical_Exp7"
.LC73:
	.string	"BM_Binary_Exp7"
.LC74:
	.string	"BM_StdPow_Exp7"
.LC75:
	.string	"BM_ScalarLoop_Exp13"
.LC76:
	.string	"BM_Branchless_Exp13"
.LC77:
	.string	"BM_AsmMul1_Exp13"
.LC78:
	.string	"BM_Binary_Exp13"
.LC79:
	.string	"BM_StdPow_Exp13"
	.section	.text.unlikely
.LCOLDB82:
	.section	.text.startup
.LHOTB82:
	.p2align 4
	.type	_Z41__static_initialization_and_destruction_0v, @function
_Z41__static_initialization_and_destruction_0v:
.LFB14971:
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gxx_personality_v0
	.cfi_lsda 0x1b,.LLSDA14971
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	leaq	_ZL9kTestExp7(%rip), %r12
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	leaq	__dso_handle(%rip), %rbp
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	leaq	_ZL9kTestExp3(%rip), %rbx
	subq	$104, %rsp
	.cfi_def_cfa_offset 160
	movq	%fs:40, %rax
	movq	%rax, 88(%rsp)
	xorl	%eax, %eax
.LEHB54:
	call	_ZN9benchmark8internal17InitializeStreamsEv@PLT
	movq	%rbx, %rdi
	movl	$3, %esi
	call	_ZL18generate_test_datajm.constprop.0
	movq	%rbx, %rsi
	leaq	_ZNSt6vectorI8TestCaseSaIS0_EED1Ev(%rip), %rbx
	movq	%rbp, %rdx
	movq	%rbx, %rdi
	call	__cxa_atexit@PLT
	movq	%r12, %rdi
	movl	$7, %esi
	call	_ZL18generate_test_datajm.constprop.0
	movq	%rbp, %rdx
	movq	%r12, %rsi
	movq	%rbx, %rdi
	call	__cxa_atexit@PLT
	leaq	_ZL10kTestExp13(%rip), %r12
	movl	$13, %esi
	movq	%r12, %rdi
	call	_ZL18generate_test_datajm.constprop.0
	movq	%rbp, %rdx
	movq	%r12, %rsi
	movq	%rbx, %rdi
	call	__cxa_atexit@PLT
	leaq	32(%rsp), %rbp
	leaq	24(%rsp), %r12
	leaq	_ZL18BM_ScalarLoop_Exp3RN9benchmark5StateE(%rip), %rax
	movq	%rbp, %rdi
	movq	%r12, %rdx
	leaq	.LC61(%rip), %rsi
	movq	%rax, 24(%rsp)
	leaq	40(%rsp), %rbx
	call	_ZSt11make_uniqueIN9benchmark8internal17FunctionBenchmarkEJRA19_KcPFvRNS0_5StateEEEENSt8__detail9_MakeUniqIT_E15__single_objectEDpOT0_
.LEHE54:
	movq	32(%rsp), %rax
	movq	%rbx, %rdi
	movq	$0, 32(%rsp)
	movq	%rax, 40(%rsp)
.LEHB55:
	call	_ZN9benchmark8internal25RegisterBenchmarkInternalESt10unique_ptrINS_9BenchmarkESt14default_deleteIS2_EE@PLT
.LEHE55:
	movq	40(%rsp), %rdi
	testq	%rdi, %rdi
	je	.L944
	movq	(%rdi), %rax
	call	*8(%rax)
.L944:
	leaq	_ZL18BM_Branchless_Exp3RN9benchmark5StateE(%rip), %rax
	movq	%rbp, %rdi
	movq	%r12, %rdx
	leaq	.LC62(%rip), %rsi
	movq	%rax, 24(%rsp)
.LEHB56:
	call	_ZSt11make_uniqueIN9benchmark8internal17FunctionBenchmarkEJRA19_KcPFvRNS0_5StateEEEENSt8__detail9_MakeUniqIT_E15__single_objectEDpOT0_
.LEHE56:
	movq	32(%rsp), %rax
	movq	%rbx, %rdi
	movq	$0, 32(%rsp)
	movq	%rax, 40(%rsp)
.LEHB57:
	call	_ZN9benchmark8internal25RegisterBenchmarkInternalESt10unique_ptrINS_9BenchmarkESt14default_deleteIS2_EE@PLT
.LEHE57:
	movq	40(%rsp), %rdi
	testq	%rdi, %rdi
	je	.L945
	movq	(%rdi), %rax
	call	*8(%rax)
.L945:
	leaq	_ZL16BM_AsmBlend_Exp3RN9benchmark5StateE(%rip), %rax
	movq	%rbp, %rdi
	movq	%r12, %rdx
	leaq	.LC63(%rip), %rsi
	movq	%rax, 24(%rsp)
.LEHB58:
	call	_ZSt11make_uniqueIN9benchmark8internal17FunctionBenchmarkEJRA17_KcPFvRNS0_5StateEEEENSt8__detail9_MakeUniqIT_E15__single_objectEDpOT0_
.LEHE58:
	movq	32(%rsp), %rax
	movq	%rbx, %rdi
	movq	$0, 32(%rsp)
	movq	%rax, 40(%rsp)
.LEHB59:
	call	_ZN9benchmark8internal25RegisterBenchmarkInternalESt10unique_ptrINS_9BenchmarkESt14default_deleteIS2_EE@PLT
.LEHE59:
	movq	40(%rsp), %rdi
	testq	%rdi, %rdi
	je	.L946
	movq	(%rdi), %rax
	call	*8(%rax)
.L946:
	leaq	_ZL15BM_AsmMul1_Exp3RN9benchmark5StateE(%rip), %rax
	movq	%rbp, %rdi
	movq	%r12, %rdx
	leaq	.LC64(%rip), %rsi
	movq	%rax, 24(%rsp)
.LEHB60:
	call	_ZSt11make_uniqueIN9benchmark8internal17FunctionBenchmarkEJRA16_KcPFvRNS0_5StateEEEENSt8__detail9_MakeUniqIT_E15__single_objectEDpOT0_
.LEHE60:
	movq	32(%rsp), %rax
	movq	%rbx, %rdi
	movq	$0, 32(%rsp)
	movq	%rax, 40(%rsp)
.LEHB61:
	call	_ZN9benchmark8internal25RegisterBenchmarkInternalESt10unique_ptrINS_9BenchmarkESt14default_deleteIS2_EE@PLT
.LEHE61:
	movq	40(%rsp), %rdi
	testq	%rdi, %rdi
	je	.L947
	movq	(%rdi), %rax
	call	*8(%rax)
.L947:
	leaq	_ZL20BM_Hierarchical_Exp3RN9benchmark5StateE(%rip), %rax
	movq	%rbp, %rdi
	movq	%r12, %rdx
	leaq	.LC65(%rip), %rsi
	movq	%rax, 24(%rsp)
.LEHB62:
	call	_ZSt11make_uniqueIN9benchmark8internal17FunctionBenchmarkEJRA21_KcPFvRNS0_5StateEEEENSt8__detail9_MakeUniqIT_E15__single_objectEDpOT0_
.LEHE62:
	movq	32(%rsp), %rax
	movq	%rbx, %rdi
	movq	$0, 32(%rsp)
	movq	%rax, 40(%rsp)
.LEHB63:
	call	_ZN9benchmark8internal25RegisterBenchmarkInternalESt10unique_ptrINS_9BenchmarkESt14default_deleteIS2_EE@PLT
.LEHE63:
	movq	40(%rsp), %rdi
	testq	%rdi, %rdi
	je	.L948
	movq	(%rdi), %rax
	call	*8(%rax)
.L948:
	leaq	_ZL14BM_Binary_Exp3RN9benchmark5StateE(%rip), %rax
	movq	%rbp, %rdi
	movq	%r12, %rdx
	leaq	.LC66(%rip), %rsi
	movq	%rax, 24(%rsp)
.LEHB64:
	call	_ZSt11make_uniqueIN9benchmark8internal17FunctionBenchmarkEJRA15_KcPFvRNS0_5StateEEEENSt8__detail9_MakeUniqIT_E15__single_objectEDpOT0_
.LEHE64:
	movq	32(%rsp), %rax
	movq	%rbx, %rdi
	movq	$0, 32(%rsp)
	movq	%rax, 40(%rsp)
.LEHB65:
	call	_ZN9benchmark8internal25RegisterBenchmarkInternalESt10unique_ptrINS_9BenchmarkESt14default_deleteIS2_EE@PLT
.LEHE65:
	movq	40(%rsp), %rdi
	testq	%rdi, %rdi
	je	.L949
	movq	(%rdi), %rax
	call	*8(%rax)
.L949:
	leaq	_ZL14BM_StdPow_Exp3RN9benchmark5StateE(%rip), %rax
	movq	%rbp, %rdi
	movq	%r12, %rdx
	leaq	.LC67(%rip), %rsi
	movq	%rax, 24(%rsp)
.LEHB66:
	call	_ZSt11make_uniqueIN9benchmark8internal17FunctionBenchmarkEJRA15_KcPFvRNS0_5StateEEEENSt8__detail9_MakeUniqIT_E15__single_objectEDpOT0_
.LEHE66:
	movq	32(%rsp), %rax
	movq	%rbx, %rdi
	movq	$0, 32(%rsp)
	movq	%rax, 40(%rsp)
.LEHB67:
	call	_ZN9benchmark8internal25RegisterBenchmarkInternalESt10unique_ptrINS_9BenchmarkESt14default_deleteIS2_EE@PLT
.LEHE67:
	movq	40(%rsp), %rdi
	testq	%rdi, %rdi
	je	.L950
	movq	(%rdi), %rax
	call	*8(%rax)
.L950:
	leaq	_ZL18BM_ScalarLoop_Exp7RN9benchmark5StateE(%rip), %rax
	movq	%rbp, %rdi
	movq	%r12, %rdx
	leaq	.LC68(%rip), %rsi
	movq	%rax, 24(%rsp)
.LEHB68:
	call	_ZSt11make_uniqueIN9benchmark8internal17FunctionBenchmarkEJRA19_KcPFvRNS0_5StateEEEENSt8__detail9_MakeUniqIT_E15__single_objectEDpOT0_
.LEHE68:
	movq	32(%rsp), %rax
	movq	%rbx, %rdi
	movq	$0, 32(%rsp)
	movq	%rax, 40(%rsp)
.LEHB69:
	call	_ZN9benchmark8internal25RegisterBenchmarkInternalESt10unique_ptrINS_9BenchmarkESt14default_deleteIS2_EE@PLT
.LEHE69:
	movq	40(%rsp), %rdi
	testq	%rdi, %rdi
	je	.L951
	movq	(%rdi), %rax
	call	*8(%rax)
.L951:
	leaq	_ZL18BM_Branchless_Exp7RN9benchmark5StateE(%rip), %rax
	movq	%rbp, %rdi
	movq	%r12, %rdx
	leaq	.LC69(%rip), %rsi
	movq	%rax, 24(%rsp)
.LEHB70:
	call	_ZSt11make_uniqueIN9benchmark8internal17FunctionBenchmarkEJRA19_KcPFvRNS0_5StateEEEENSt8__detail9_MakeUniqIT_E15__single_objectEDpOT0_
.LEHE70:
	movq	32(%rsp), %rax
	movq	%rbx, %rdi
	movq	$0, 32(%rsp)
	movq	%rax, 40(%rsp)
.LEHB71:
	call	_ZN9benchmark8internal25RegisterBenchmarkInternalESt10unique_ptrINS_9BenchmarkESt14default_deleteIS2_EE@PLT
.LEHE71:
	movq	40(%rsp), %rdi
	testq	%rdi, %rdi
	je	.L952
	movq	(%rdi), %rax
	call	*8(%rax)
.L952:
	leaq	_ZL16BM_AsmBlend_Exp7RN9benchmark5StateE(%rip), %rax
	movq	%rbp, %rdi
	movq	%r12, %rdx
	leaq	.LC70(%rip), %rsi
	movq	%rax, 24(%rsp)
.LEHB72:
	call	_ZSt11make_uniqueIN9benchmark8internal17FunctionBenchmarkEJRA17_KcPFvRNS0_5StateEEEENSt8__detail9_MakeUniqIT_E15__single_objectEDpOT0_
.LEHE72:
	movq	32(%rsp), %rax
	movq	%rbx, %rdi
	movq	$0, 32(%rsp)
	movq	%rax, 40(%rsp)
.LEHB73:
	call	_ZN9benchmark8internal25RegisterBenchmarkInternalESt10unique_ptrINS_9BenchmarkESt14default_deleteIS2_EE@PLT
.LEHE73:
	movq	40(%rsp), %rdi
	testq	%rdi, %rdi
	je	.L953
	movq	(%rdi), %rax
	call	*8(%rax)
.L953:
	leaq	_ZL15BM_AsmMul1_Exp7RN9benchmark5StateE(%rip), %rax
	movq	%rbp, %rdi
	movq	%r12, %rdx
	leaq	.LC71(%rip), %rsi
	movq	%rax, 24(%rsp)
.LEHB74:
	call	_ZSt11make_uniqueIN9benchmark8internal17FunctionBenchmarkEJRA16_KcPFvRNS0_5StateEEEENSt8__detail9_MakeUniqIT_E15__single_objectEDpOT0_
.LEHE74:
	movq	32(%rsp), %rax
	movq	%rbx, %rdi
	movq	$0, 32(%rsp)
	movq	%rax, 40(%rsp)
.LEHB75:
	call	_ZN9benchmark8internal25RegisterBenchmarkInternalESt10unique_ptrINS_9BenchmarkESt14default_deleteIS2_EE@PLT
.LEHE75:
	movq	40(%rsp), %rdi
	testq	%rdi, %rdi
	je	.L954
	movq	(%rdi), %rax
	call	*8(%rax)
.L954:
	leaq	_ZL20BM_Hierarchical_Exp7RN9benchmark5StateE(%rip), %rax
	movq	%rbp, %rdi
	movq	%r12, %rdx
	leaq	.LC72(%rip), %rsi
	movq	%rax, 24(%rsp)
.LEHB76:
	call	_ZSt11make_uniqueIN9benchmark8internal17FunctionBenchmarkEJRA21_KcPFvRNS0_5StateEEEENSt8__detail9_MakeUniqIT_E15__single_objectEDpOT0_
.LEHE76:
	movq	32(%rsp), %rax
	movq	%rbx, %rdi
	movq	$0, 32(%rsp)
	movq	%rax, 40(%rsp)
.LEHB77:
	call	_ZN9benchmark8internal25RegisterBenchmarkInternalESt10unique_ptrINS_9BenchmarkESt14default_deleteIS2_EE@PLT
.LEHE77:
	movq	40(%rsp), %rdi
	testq	%rdi, %rdi
	je	.L955
	movq	(%rdi), %rax
	call	*8(%rax)
.L955:
	leaq	_ZL14BM_Binary_Exp7RN9benchmark5StateE(%rip), %rax
	movq	%rbp, %rdi
	movq	%r12, %rdx
	leaq	.LC73(%rip), %rsi
	movq	%rax, 24(%rsp)
.LEHB78:
	call	_ZSt11make_uniqueIN9benchmark8internal17FunctionBenchmarkEJRA15_KcPFvRNS0_5StateEEEENSt8__detail9_MakeUniqIT_E15__single_objectEDpOT0_
.LEHE78:
	movq	32(%rsp), %rax
	movq	%rbx, %rdi
	movq	$0, 32(%rsp)
	movq	%rax, 40(%rsp)
.LEHB79:
	call	_ZN9benchmark8internal25RegisterBenchmarkInternalESt10unique_ptrINS_9BenchmarkESt14default_deleteIS2_EE@PLT
.LEHE79:
	movq	40(%rsp), %rdi
	testq	%rdi, %rdi
	je	.L956
	movq	(%rdi), %rax
	call	*8(%rax)
.L956:
	leaq	_ZL14BM_StdPow_Exp7RN9benchmark5StateE(%rip), %rax
	movq	%rbp, %rdi
	movq	%r12, %rdx
	leaq	.LC74(%rip), %rsi
	movq	%rax, 24(%rsp)
.LEHB80:
	call	_ZSt11make_uniqueIN9benchmark8internal17FunctionBenchmarkEJRA15_KcPFvRNS0_5StateEEEENSt8__detail9_MakeUniqIT_E15__single_objectEDpOT0_
.LEHE80:
	movq	32(%rsp), %rax
	movq	%rbx, %rdi
	movq	$0, 32(%rsp)
	movq	%rax, 40(%rsp)
.LEHB81:
	call	_ZN9benchmark8internal25RegisterBenchmarkInternalESt10unique_ptrINS_9BenchmarkESt14default_deleteIS2_EE@PLT
.LEHE81:
	movq	40(%rsp), %rdi
	testq	%rdi, %rdi
	je	.L957
	movq	(%rdi), %rax
	call	*8(%rax)
.L957:
	leaq	_ZL19BM_ScalarLoop_Exp13RN9benchmark5StateE(%rip), %rax
	movq	%rbp, %rdi
	movq	%r12, %rdx
	leaq	.LC75(%rip), %rsi
	movq	%rax, 24(%rsp)
.LEHB82:
	call	_ZSt11make_uniqueIN9benchmark8internal17FunctionBenchmarkEJRA20_KcPFvRNS0_5StateEEEENSt8__detail9_MakeUniqIT_E15__single_objectEDpOT0_
.LEHE82:
	movq	32(%rsp), %rax
	movq	%rbx, %rdi
	movq	$0, 32(%rsp)
	movq	%rax, 40(%rsp)
.LEHB83:
	call	_ZN9benchmark8internal25RegisterBenchmarkInternalESt10unique_ptrINS_9BenchmarkESt14default_deleteIS2_EE@PLT
.LEHE83:
	movq	40(%rsp), %rdi
	testq	%rdi, %rdi
	je	.L958
	movq	(%rdi), %rax
	call	*8(%rax)
.L958:
	leaq	_ZL19BM_Branchless_Exp13RN9benchmark5StateE(%rip), %rax
	movq	%rbp, %rdi
	movq	%r12, %rdx
	leaq	.LC76(%rip), %rsi
	movq	%rax, 24(%rsp)
.LEHB84:
	call	_ZSt11make_uniqueIN9benchmark8internal17FunctionBenchmarkEJRA20_KcPFvRNS0_5StateEEEENSt8__detail9_MakeUniqIT_E15__single_objectEDpOT0_
.LEHE84:
	movq	32(%rsp), %rax
	movq	%rbx, %rdi
	movq	$0, 32(%rsp)
	movq	%rax, 40(%rsp)
.LEHB85:
	call	_ZN9benchmark8internal25RegisterBenchmarkInternalESt10unique_ptrINS_9BenchmarkESt14default_deleteIS2_EE@PLT
.LEHE85:
	movq	40(%rsp), %rdi
	testq	%rdi, %rdi
	je	.L959
	movq	(%rdi), %rax
	call	*8(%rax)
.L959:
	movl	$312, %edi
	leaq	64(%rsp), %r14
.LEHB86:
	call	_Znwm@PLT
.LEHE86:
	movl	$18, %edi
	movq	%r14, 48(%rsp)
	movq	%rax, %r13
.LEHB87:
	call	_Znwm@PLT
.LEHE87:
	vmovdqa	.LC80(%rip), %xmm0
	movb	$51, 16(%rax)
	movq	%r13, %rdi
	movb	$0, 17(%rax)
	movq	%rax, 48(%rsp)
	vmovdqu	%xmm0, (%rax)
	leaq	48(%rsp), %rax
	movq	%rax, %rsi
	movq	%rax, 8(%rsp)
	movq	$17, 64(%rsp)
	movq	$17, 56(%rsp)
.LEHB88:
	call	_ZN9benchmark9BenchmarkC2ERKNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEE@PLT
.LEHE88:
	movq	48(%rsp), %rdi
	leaq	16+_ZTVN9benchmark8internal17FunctionBenchmarkE(%rip), %r15
	leaq	_ZL17BM_AsmBlend_Exp13RN9benchmark5StateE(%rip), %rax
	movq	%r15, 0(%r13)
	movq	%rax, 304(%r13)
	cmpq	%r14, %rdi
	je	.L960
	movq	64(%rsp), %rax
	leaq	1(%rax), %rsi
	call	_ZdlPvm@PLT
.L960:
	movq	%rbx, %rdi
	movq	%r13, 40(%rsp)
.LEHB89:
	call	_ZN9benchmark8internal25RegisterBenchmarkInternalESt10unique_ptrINS_9BenchmarkESt14default_deleteIS2_EE@PLT
.LEHE89:
	movq	40(%rsp), %rdi
	testq	%rdi, %rdi
	je	.L965
	movq	(%rdi), %rax
	call	*8(%rax)
.L965:
	leaq	_ZL16BM_AsmMul1_Exp13RN9benchmark5StateE(%rip), %rax
	movq	%rbp, %rdi
	movq	%r12, %rdx
	leaq	.LC77(%rip), %rsi
	movq	%rax, 24(%rsp)
.LEHB90:
	call	_ZSt11make_uniqueIN9benchmark8internal17FunctionBenchmarkEJRA17_KcPFvRNS0_5StateEEEENSt8__detail9_MakeUniqIT_E15__single_objectEDpOT0_
.LEHE90:
	movq	32(%rsp), %rax
	movq	%rbx, %rdi
	movq	$0, 32(%rsp)
	movq	%rax, 40(%rsp)
.LEHB91:
	call	_ZN9benchmark8internal25RegisterBenchmarkInternalESt10unique_ptrINS_9BenchmarkESt14default_deleteIS2_EE@PLT
.LEHE91:
	movq	40(%rsp), %rdi
	testq	%rdi, %rdi
	je	.L966
	movq	(%rdi), %rax
	call	*8(%rax)
.L966:
	movl	$312, %edi
.LEHB92:
	call	_Znwm@PLT
.LEHE92:
	movl	$22, %edi
	movq	%r14, 48(%rsp)
	movq	%rax, %r13
.LEHB93:
	call	_Znwm@PLT
.LEHE93:
	vmovdqa	.LC81(%rip), %xmm0
	movb	$0, 21(%rax)
	movq	%r13, %rdi
	movabsq	$3688853231655414881, %rcx
	movq	8(%rsp), %rsi
	movq	%rax, 48(%rsp)
	vmovdqu	%xmm0, (%rax)
	movq	%rcx, 13(%rax)
	movq	$21, 64(%rsp)
	movq	$21, 56(%rsp)
.LEHB94:
	call	_ZN9benchmark9BenchmarkC2ERKNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEE@PLT
.LEHE94:
	movq	48(%rsp), %rdi
	leaq	_ZL21BM_Hierarchical_Exp13RN9benchmark5StateE(%rip), %rax
	movq	%r15, 0(%r13)
	movq	%rax, 304(%r13)
	cmpq	%r14, %rdi
	je	.L967
	movq	64(%rsp), %rax
	leaq	1(%rax), %rsi
	call	_ZdlPvm@PLT
.L967:
	movq	%rbx, %rdi
	movq	%r13, 40(%rsp)
.LEHB95:
	call	_ZN9benchmark8internal25RegisterBenchmarkInternalESt10unique_ptrINS_9BenchmarkESt14default_deleteIS2_EE@PLT
.LEHE95:
	movq	40(%rsp), %rdi
	testq	%rdi, %rdi
	je	.L972
	movq	(%rdi), %rax
	call	*8(%rax)
.L972:
	leaq	_ZL15BM_Binary_Exp13RN9benchmark5StateE(%rip), %rax
	movq	%rbp, %rdi
	movq	%r12, %rdx
	leaq	.LC78(%rip), %rsi
	movq	%rax, 24(%rsp)
.LEHB96:
	call	_ZSt11make_uniqueIN9benchmark8internal17FunctionBenchmarkEJRA16_KcPFvRNS0_5StateEEEENSt8__detail9_MakeUniqIT_E15__single_objectEDpOT0_
.LEHE96:
	movq	32(%rsp), %rax
	movq	%rbx, %rdi
	movq	$0, 32(%rsp)
	movq	%rax, 40(%rsp)
.LEHB97:
	call	_ZN9benchmark8internal25RegisterBenchmarkInternalESt10unique_ptrINS_9BenchmarkESt14default_deleteIS2_EE@PLT
.LEHE97:
	movq	40(%rsp), %rdi
	testq	%rdi, %rdi
	je	.L973
	movq	(%rdi), %rax
	call	*8(%rax)
.L973:
	leaq	_ZL15BM_StdPow_Exp13RN9benchmark5StateE(%rip), %rax
	movq	%rbp, %rdi
	movq	%r12, %rdx
	leaq	.LC79(%rip), %rsi
	movq	%rax, 24(%rsp)
.LEHB98:
	call	_ZSt11make_uniqueIN9benchmark8internal17FunctionBenchmarkEJRA16_KcPFvRNS0_5StateEEEENSt8__detail9_MakeUniqIT_E15__single_objectEDpOT0_
.LEHE98:
	movq	32(%rsp), %rax
	movq	%rbx, %rdi
	movq	$0, 32(%rsp)
	movq	%rax, 40(%rsp)
.LEHB99:
	call	_ZN9benchmark8internal25RegisterBenchmarkInternalESt10unique_ptrINS_9BenchmarkESt14default_deleteIS2_EE@PLT
.LEHE99:
	movq	40(%rsp), %rdi
	testq	%rdi, %rdi
	je	.L943
	movq	(%rdi), %rax
	call	*8(%rax)
.L943:
	movq	88(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L1215
	addq	$104, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%rbp
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	ret
.L1215:
	.cfi_restore_state
	call	__stack_chk_fail@PLT
.L1059:
	endbr64
	movq	%rax, %rbx
	jmp	.L1035
.L1058:
	endbr64
	movq	%rax, %rbx
	jmp	.L1032
.L1056:
	endbr64
	movq	%rax, %rbx
	jmp	.L1026
.L1063:
	endbr64
	movq	%rax, %rbx
	jmp	.L969
.L1061:
	endbr64
	movq	%rax, %rbx
	jmp	.L962
.L1057:
	endbr64
	movq	%rax, %rbx
	jmp	.L1029
.L1055:
	endbr64
	movq	%rax, %rbx
	jmp	.L1023
.L1062:
	endbr64
	movq	%rax, %rbx
	vzeroupper
	jmp	.L970
.L1060:
	endbr64
	movq	%rax, %rbx
	vzeroupper
	jmp	.L963
.L1054:
	endbr64
	movq	%rax, %rbx
	jmp	.L1020
.L1053:
	endbr64
	movq	%rax, %rbx
	jmp	.L1017
.L1046:
	endbr64
	movq	%rax, %rbx
	jmp	.L996
.L1045:
	endbr64
	movq	%rax, %rbx
	jmp	.L993
.L1050:
	endbr64
	movq	%rax, %rbx
	jmp	.L1008
.L1049:
	endbr64
	movq	%rax, %rbx
	jmp	.L1005
.L1042:
	endbr64
	movq	%rax, %rbx
	jmp	.L984
.L1041:
	endbr64
	movq	%rax, %rbx
	jmp	.L981
.L1052:
	endbr64
	movq	%rax, %rbx
	jmp	.L1014
.L1051:
	endbr64
	movq	%rax, %rbx
	jmp	.L1011
.L1044:
	endbr64
	movq	%rax, %rbx
	jmp	.L990
.L1043:
	endbr64
	movq	%rax, %rbx
	jmp	.L987
.L1048:
	endbr64
	movq	%rax, %rbx
	jmp	.L1002
.L1047:
	endbr64
	movq	%rax, %rbx
	jmp	.L999
.L1040:
	endbr64
	movq	%rax, %rbx
	jmp	.L978
.L1039:
	endbr64
	movq	%rax, %rbx
	jmp	.L975
	.section	.gcc_except_table
.LLSDA14971:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSE14971-.LLSDACSB14971
.LLSDACSB14971:
	.uleb128 .LEHB54-.LFB14971
	.uleb128 .LEHE54-.LEHB54
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB55-.LFB14971
	.uleb128 .LEHE55-.LEHB55
	.uleb128 .L1039-.LFB14971
	.uleb128 0
	.uleb128 .LEHB56-.LFB14971
	.uleb128 .LEHE56-.LEHB56
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB57-.LFB14971
	.uleb128 .LEHE57-.LEHB57
	.uleb128 .L1040-.LFB14971
	.uleb128 0
	.uleb128 .LEHB58-.LFB14971
	.uleb128 .LEHE58-.LEHB58
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB59-.LFB14971
	.uleb128 .LEHE59-.LEHB59
	.uleb128 .L1041-.LFB14971
	.uleb128 0
	.uleb128 .LEHB60-.LFB14971
	.uleb128 .LEHE60-.LEHB60
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB61-.LFB14971
	.uleb128 .LEHE61-.LEHB61
	.uleb128 .L1042-.LFB14971
	.uleb128 0
	.uleb128 .LEHB62-.LFB14971
	.uleb128 .LEHE62-.LEHB62
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB63-.LFB14971
	.uleb128 .LEHE63-.LEHB63
	.uleb128 .L1043-.LFB14971
	.uleb128 0
	.uleb128 .LEHB64-.LFB14971
	.uleb128 .LEHE64-.LEHB64
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB65-.LFB14971
	.uleb128 .LEHE65-.LEHB65
	.uleb128 .L1044-.LFB14971
	.uleb128 0
	.uleb128 .LEHB66-.LFB14971
	.uleb128 .LEHE66-.LEHB66
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB67-.LFB14971
	.uleb128 .LEHE67-.LEHB67
	.uleb128 .L1045-.LFB14971
	.uleb128 0
	.uleb128 .LEHB68-.LFB14971
	.uleb128 .LEHE68-.LEHB68
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB69-.LFB14971
	.uleb128 .LEHE69-.LEHB69
	.uleb128 .L1046-.LFB14971
	.uleb128 0
	.uleb128 .LEHB70-.LFB14971
	.uleb128 .LEHE70-.LEHB70
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB71-.LFB14971
	.uleb128 .LEHE71-.LEHB71
	.uleb128 .L1047-.LFB14971
	.uleb128 0
	.uleb128 .LEHB72-.LFB14971
	.uleb128 .LEHE72-.LEHB72
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB73-.LFB14971
	.uleb128 .LEHE73-.LEHB73
	.uleb128 .L1048-.LFB14971
	.uleb128 0
	.uleb128 .LEHB74-.LFB14971
	.uleb128 .LEHE74-.LEHB74
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB75-.LFB14971
	.uleb128 .LEHE75-.LEHB75
	.uleb128 .L1049-.LFB14971
	.uleb128 0
	.uleb128 .LEHB76-.LFB14971
	.uleb128 .LEHE76-.LEHB76
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB77-.LFB14971
	.uleb128 .LEHE77-.LEHB77
	.uleb128 .L1050-.LFB14971
	.uleb128 0
	.uleb128 .LEHB78-.LFB14971
	.uleb128 .LEHE78-.LEHB78
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB79-.LFB14971
	.uleb128 .LEHE79-.LEHB79
	.uleb128 .L1051-.LFB14971
	.uleb128 0
	.uleb128 .LEHB80-.LFB14971
	.uleb128 .LEHE80-.LEHB80
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB81-.LFB14971
	.uleb128 .LEHE81-.LEHB81
	.uleb128 .L1052-.LFB14971
	.uleb128 0
	.uleb128 .LEHB82-.LFB14971
	.uleb128 .LEHE82-.LEHB82
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB83-.LFB14971
	.uleb128 .LEHE83-.LEHB83
	.uleb128 .L1053-.LFB14971
	.uleb128 0
	.uleb128 .LEHB84-.LFB14971
	.uleb128 .LEHE84-.LEHB84
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB85-.LFB14971
	.uleb128 .LEHE85-.LEHB85
	.uleb128 .L1054-.LFB14971
	.uleb128 0
	.uleb128 .LEHB86-.LFB14971
	.uleb128 .LEHE86-.LEHB86
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB87-.LFB14971
	.uleb128 .LEHE87-.LEHB87
	.uleb128 .L1060-.LFB14971
	.uleb128 0
	.uleb128 .LEHB88-.LFB14971
	.uleb128 .LEHE88-.LEHB88
	.uleb128 .L1061-.LFB14971
	.uleb128 0
	.uleb128 .LEHB89-.LFB14971
	.uleb128 .LEHE89-.LEHB89
	.uleb128 .L1055-.LFB14971
	.uleb128 0
	.uleb128 .LEHB90-.LFB14971
	.uleb128 .LEHE90-.LEHB90
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB91-.LFB14971
	.uleb128 .LEHE91-.LEHB91
	.uleb128 .L1056-.LFB14971
	.uleb128 0
	.uleb128 .LEHB92-.LFB14971
	.uleb128 .LEHE92-.LEHB92
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB93-.LFB14971
	.uleb128 .LEHE93-.LEHB93
	.uleb128 .L1062-.LFB14971
	.uleb128 0
	.uleb128 .LEHB94-.LFB14971
	.uleb128 .LEHE94-.LEHB94
	.uleb128 .L1063-.LFB14971
	.uleb128 0
	.uleb128 .LEHB95-.LFB14971
	.uleb128 .LEHE95-.LEHB95
	.uleb128 .L1057-.LFB14971
	.uleb128 0
	.uleb128 .LEHB96-.LFB14971
	.uleb128 .LEHE96-.LEHB96
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB97-.LFB14971
	.uleb128 .LEHE97-.LEHB97
	.uleb128 .L1058-.LFB14971
	.uleb128 0
	.uleb128 .LEHB98-.LFB14971
	.uleb128 .LEHE98-.LEHB98
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB99-.LFB14971
	.uleb128 .LEHE99-.LEHB99
	.uleb128 .L1059-.LFB14971
	.uleb128 0
.LLSDACSE14971:
	.section	.text.startup
	.cfi_endproc
	.section	.text.unlikely
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gxx_personality_v0
	.cfi_lsda 0x1b,.LLSDAC14971
	.type	_Z41__static_initialization_and_destruction_0v.cold, @function
_Z41__static_initialization_and_destruction_0v.cold:
.LFSB14971:
.L1035:
	.cfi_def_cfa_offset 160
	.cfi_offset 3, -56
	.cfi_offset 6, -48
	.cfi_offset 12, -40
	.cfi_offset 13, -32
	.cfi_offset 14, -24
	.cfi_offset 15, -16
	movq	40(%rsp), %rdi
	testq	%rdi, %rdi
	jne	.L1216
	vzeroupper
.L1036:
	movq	88(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L1217
	movq	%rbx, %rdi
.LEHB100:
	call	_Unwind_Resume@PLT
.L1032:
	movq	40(%rsp), %rdi
	testq	%rdi, %rdi
	jne	.L1218
	vzeroupper
.L1033:
	movq	88(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L1219
	movq	%rbx, %rdi
	call	_Unwind_Resume@PLT
.L1029:
	movq	40(%rsp), %rdi
	testq	%rdi, %rdi
	jne	.L1220
	vzeroupper
.L1030:
	movq	88(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L1221
	movq	%rbx, %rdi
	call	_Unwind_Resume@PLT
.L1218:
	movq	(%rdi), %rax
	vzeroupper
	call	*8(%rax)
	jmp	.L1033
.L1219:
	call	__stack_chk_fail@PLT
.L1220:
	movq	(%rdi), %rax
	vzeroupper
	call	*8(%rax)
	jmp	.L1030
.L1221:
	call	__stack_chk_fail@PLT
.L1026:
	movq	40(%rsp), %rdi
	testq	%rdi, %rdi
	jne	.L1222
	vzeroupper
.L1027:
	movq	88(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L1223
	movq	%rbx, %rdi
	call	_Unwind_Resume@PLT
.L1023:
	movq	40(%rsp), %rdi
	testq	%rdi, %rdi
	jne	.L1224
	vzeroupper
.L1024:
	movq	88(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L1225
	movq	%rbx, %rdi
	call	_Unwind_Resume@PLT
.L1222:
	movq	(%rdi), %rax
	vzeroupper
	call	*8(%rax)
	jmp	.L1027
.L1223:
	call	__stack_chk_fail@PLT
.L969:
	movq	8(%rsp), %rdi
	vzeroupper
	call	_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_disposeEv
.L970:
	movl	$312, %esi
	movq	%r13, %rdi
	call	_ZdlPvm@PLT
	movq	88(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L1226
	movq	%rbx, %rdi
	call	_Unwind_Resume@PLT
.L1216:
	movq	(%rdi), %rax
	vzeroupper
	call	*8(%rax)
	jmp	.L1036
.L1217:
	call	__stack_chk_fail@PLT
.L1226:
	call	__stack_chk_fail@PLT
.L962:
	movq	8(%rsp), %rdi
	vzeroupper
	call	_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_disposeEv
.L963:
	movl	$312, %esi
	movq	%r13, %rdi
	call	_ZdlPvm@PLT
	movq	88(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L1227
	movq	%rbx, %rdi
	call	_Unwind_Resume@PLT
.L1224:
	movq	(%rdi), %rax
	vzeroupper
	call	*8(%rax)
	jmp	.L1024
.L1225:
	call	__stack_chk_fail@PLT
.L1227:
	call	__stack_chk_fail@PLT
.L1020:
	movq	40(%rsp), %rdi
	testq	%rdi, %rdi
	jne	.L1228
	vzeroupper
.L1021:
	movq	88(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L1229
	movq	%rbx, %rdi
	call	_Unwind_Resume@PLT
.L1017:
	movq	40(%rsp), %rdi
	testq	%rdi, %rdi
	jne	.L1230
	vzeroupper
.L1018:
	movq	88(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L1231
	movq	%rbx, %rdi
	call	_Unwind_Resume@PLT
.L1228:
	movq	(%rdi), %rax
	vzeroupper
	call	*8(%rax)
	jmp	.L1021
.L1229:
	call	__stack_chk_fail@PLT
.L996:
	movq	40(%rsp), %rdi
	testq	%rdi, %rdi
	jne	.L1232
	vzeroupper
.L997:
	movq	88(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L1233
	movq	%rbx, %rdi
	call	_Unwind_Resume@PLT
.L993:
	movq	40(%rsp), %rdi
	testq	%rdi, %rdi
	jne	.L1234
	vzeroupper
.L994:
	movq	88(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L1235
	movq	%rbx, %rdi
	call	_Unwind_Resume@PLT
.L1232:
	movq	(%rdi), %rax
	vzeroupper
	call	*8(%rax)
	jmp	.L997
.L1233:
	call	__stack_chk_fail@PLT
.L1008:
	movq	40(%rsp), %rdi
	testq	%rdi, %rdi
	jne	.L1236
	vzeroupper
.L1009:
	movq	88(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L1237
	movq	%rbx, %rdi
	call	_Unwind_Resume@PLT
.L1005:
	movq	40(%rsp), %rdi
	testq	%rdi, %rdi
	jne	.L1238
	vzeroupper
.L1006:
	movq	88(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L1239
	movq	%rbx, %rdi
	call	_Unwind_Resume@PLT
.L1236:
	movq	(%rdi), %rax
	vzeroupper
	call	*8(%rax)
	jmp	.L1009
.L1237:
	call	__stack_chk_fail@PLT
.L984:
	movq	40(%rsp), %rdi
	testq	%rdi, %rdi
	jne	.L1240
	vzeroupper
.L985:
	movq	88(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L1241
	movq	%rbx, %rdi
	call	_Unwind_Resume@PLT
.L981:
	movq	40(%rsp), %rdi
	testq	%rdi, %rdi
	jne	.L1242
	vzeroupper
.L982:
	movq	88(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L1243
	movq	%rbx, %rdi
	call	_Unwind_Resume@PLT
.L1240:
	movq	(%rdi), %rax
	vzeroupper
	call	*8(%rax)
	jmp	.L985
.L1241:
	call	__stack_chk_fail@PLT
.L1014:
	movq	40(%rsp), %rdi
	testq	%rdi, %rdi
	jne	.L1244
	vzeroupper
.L1015:
	movq	88(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L1245
	movq	%rbx, %rdi
	call	_Unwind_Resume@PLT
.L1011:
	movq	40(%rsp), %rdi
	testq	%rdi, %rdi
	jne	.L1246
	vzeroupper
.L1012:
	movq	88(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L1247
	movq	%rbx, %rdi
	call	_Unwind_Resume@PLT
.L1244:
	movq	(%rdi), %rax
	vzeroupper
	call	*8(%rax)
	jmp	.L1015
.L1245:
	call	__stack_chk_fail@PLT
.L990:
	movq	40(%rsp), %rdi
	testq	%rdi, %rdi
	jne	.L1248
	vzeroupper
.L991:
	movq	88(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L1249
	movq	%rbx, %rdi
	call	_Unwind_Resume@PLT
.L987:
	movq	40(%rsp), %rdi
	testq	%rdi, %rdi
	jne	.L1250
	vzeroupper
.L988:
	movq	88(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L1251
	movq	%rbx, %rdi
	call	_Unwind_Resume@PLT
.L1248:
	movq	(%rdi), %rax
	vzeroupper
	call	*8(%rax)
	jmp	.L991
.L1249:
	call	__stack_chk_fail@PLT
.L1002:
	movq	40(%rsp), %rdi
	testq	%rdi, %rdi
	jne	.L1252
	vzeroupper
.L1003:
	movq	88(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L1253
	movq	%rbx, %rdi
	call	_Unwind_Resume@PLT
.L999:
	movq	40(%rsp), %rdi
	testq	%rdi, %rdi
	jne	.L1254
	vzeroupper
.L1000:
	movq	88(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L1255
	movq	%rbx, %rdi
	call	_Unwind_Resume@PLT
.L1252:
	movq	(%rdi), %rax
	vzeroupper
	call	*8(%rax)
	jmp	.L1003
.L1253:
	call	__stack_chk_fail@PLT
.L978:
	movq	40(%rsp), %rdi
	testq	%rdi, %rdi
	jne	.L1256
	vzeroupper
.L979:
	movq	88(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L1257
	movq	%rbx, %rdi
	call	_Unwind_Resume@PLT
.L975:
	movq	40(%rsp), %rdi
	testq	%rdi, %rdi
	jne	.L1258
	vzeroupper
.L976:
	movq	88(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L1259
	movq	%rbx, %rdi
	call	_Unwind_Resume@PLT
.LEHE100:
.L1256:
	movq	(%rdi), %rax
	vzeroupper
	call	*8(%rax)
	jmp	.L979
.L1257:
	call	__stack_chk_fail@PLT
.L1230:
	movq	(%rdi), %rax
	vzeroupper
	call	*8(%rax)
	jmp	.L1018
.L1231:
	call	__stack_chk_fail@PLT
.L1246:
	movq	(%rdi), %rax
	vzeroupper
	call	*8(%rax)
	jmp	.L1012
.L1247:
	call	__stack_chk_fail@PLT
.L1238:
	movq	(%rdi), %rax
	vzeroupper
	call	*8(%rax)
	jmp	.L1006
.L1239:
	call	__stack_chk_fail@PLT
.L1254:
	movq	(%rdi), %rax
	vzeroupper
	call	*8(%rax)
	jmp	.L1000
.L1255:
	call	__stack_chk_fail@PLT
.L1234:
	movq	(%rdi), %rax
	vzeroupper
	call	*8(%rax)
	jmp	.L994
.L1235:
	call	__stack_chk_fail@PLT
.L1250:
	movq	(%rdi), %rax
	vzeroupper
	call	*8(%rax)
	jmp	.L988
.L1251:
	call	__stack_chk_fail@PLT
.L1242:
	movq	(%rdi), %rax
	vzeroupper
	call	*8(%rax)
	jmp	.L982
.L1243:
	call	__stack_chk_fail@PLT
.L1258:
	movq	(%rdi), %rax
	vzeroupper
	call	*8(%rax)
	jmp	.L976
.L1259:
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE14971:
	.section	.gcc_except_table
.LLSDAC14971:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSEC14971-.LLSDACSBC14971
.LLSDACSBC14971:
	.uleb128 .LEHB100-.LCOLDB82
	.uleb128 .LEHE100-.LEHB100
	.uleb128 0
	.uleb128 0
.LLSDACSEC14971:
	.section	.text.unlikely
	.section	.text.startup
	.size	_Z41__static_initialization_and_destruction_0v, .-_Z41__static_initialization_and_destruction_0v
	.section	.text.unlikely
	.size	_Z41__static_initialization_and_destruction_0v.cold, .-_Z41__static_initialization_and_destruction_0v.cold
.LCOLDE82:
	.section	.text.startup
.LHOTE82:
	.p2align 4
	.type	_GLOBAL__sub_I_main, @function
_GLOBAL__sub_I_main:
.LFB14972:
	.cfi_startproc
	endbr64
	jmp	_Z41__static_initialization_and_destruction_0v
	.cfi_endproc
.LFE14972:
	.size	_GLOBAL__sub_I_main, .-_GLOBAL__sub_I_main
	.section	.init_array,"aw"
	.align 8
	.quad	_GLOBAL__sub_I_main
	.local	_ZL10kTestExp13
	.comm	_ZL10kTestExp13,24,16
	.local	_ZL9kTestExp7
	.comm	_ZL9kTestExp7,24,16
	.local	_ZL9kTestExp3
	.comm	_ZL9kTestExp3,24,16
	.weak	_ZSt19piecewise_construct
	.section	.rodata._ZSt19piecewise_construct,"aG",@progbits,_ZSt19piecewise_construct,comdat
	.type	_ZSt19piecewise_construct, @gnu_unique_object
	.size	_ZSt19piecewise_construct, 1
_ZSt19piecewise_construct:
	.zero	1
	.set	.LC0,.LC3+16
	.section	.rodata.cst32,"aM",@progbits,32
	.align 32
.LC3:
	.long	0
	.long	0
	.long	0
	.long	1071644672
	.long	0
	.long	1072693248
	.long	0
	.long	1073217536
	.align 32
.LC4:
	.long	0
	.long	1073741824
	.long	-266631570
	.long	1074340345
	.long	-755914244
	.long	1062232653
	.long	0
	.long	1079574528
	.section	.rodata.cst8,"aM",@progbits,8
	.align 8
.LC5:
	.long	0
	.long	-1073479680
	.section	.rodata.cst32
	.align 32
.LC6:
	.long	0
	.long	1
	.long	2
	.long	3
	.long	4
	.long	5
	.long	7
	.long	8
	.section	.rodata.cst8
	.align 8
.LC7:
	.long	10
	.long	13
	.section	.rodata.cst16,"aM",@progbits,16
	.align 16
.LC8:
	.long	-1
	.long	2147483647
	.long	0
	.long	0
	.section	.rodata.cst8
	.align 8
.LC10:
	.long	-2127697391
	.long	1030854553
	.section	.rodata.cst16
	.align 16
.LC35:
	.quad	7309447144583558249
	.quad	7236844123925471090
	.section	.rodata.cst8
	.align 8
.LC51:
	.quad	-2147483648
	.align 8
.LC52:
	.quad	2147483647
	.align 8
.LC53:
	.quad	1
	.align 8
.LC54:
	.long	-1
	.long	1073741823
	.align 8
.LC55:
	.long	0
	.long	1139802112
	.align 8
.LC56:
	.long	0
	.long	1006108672
	.set	.LC57,.LC3+8
	.section	.rodata.cst16
	.align 16
.LC80:
	.quad	7800917846344551746
	.quad	3562479544598556261
	.align 16
.LC81:
	.quad	7021786271884201282
	.quad	6875977810686010226
	.hidden	DW.ref.__gxx_personality_v0
	.weak	DW.ref.__gxx_personality_v0
	.section	.data.rel.local.DW.ref.__gxx_personality_v0,"awG",@progbits,DW.ref.__gxx_personality_v0,comdat
	.align 8
	.type	DW.ref.__gxx_personality_v0, @object
	.size	DW.ref.__gxx_personality_v0, 8
DW.ref.__gxx_personality_v0:
	.quad	__gxx_personality_v0
	.hidden	__dso_handle
	.ident	"GCC: (Ubuntu 13.3.0-6ubuntu2~24.04.1) 13.3.0"
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
