	.file	"benchmark_asm.cpp"
	.intel_syntax noprefix
	.text
#APP
	.globl _ZSt21ios_base_library_initv
#NO_APP
	.p2align 4
	.type	_ZL12pow_asm_cmovmm, @function
_ZL12pow_asm_cmovmm:
.LFB6278:
	.cfi_startproc
#APP
# 88 "/tmp/powerix/benchmark/benchmark_asm.cpp" 1
	mov $1, %rax
	test %rsi, %rsi
	jz 2f
	.p2align 4
	1:
	mov %rax, %rcx
	imul %rdi, %rcx
	test $1, %sil
	cmovnz %rcx, %rax
	imul %rdi, %rdi
	shr %rsi
	jnz 1b
	2:
	
# 0 "" 2
#NO_APP
	ret
	.cfi_endproc
.LFE6278:
	.size	_ZL12pow_asm_cmovmm, .-_ZL12pow_asm_cmovmm
	.p2align 4
	.type	_ZL18pow_asm_unrolled64mm, @function
_ZL18pow_asm_unrolled64mm:
.LFB6279:
	.cfi_startproc
#APP
# 129 "/tmp/powerix/benchmark/benchmark_asm.cpp" 1
	mov $1, %rax
	test %rsi, %rsi
	jz 2f
	.p2align 4
	1:
	mov %rax, %rcx
	imul %rdi, %rcx
	test $1, %sil
	cmovnz %rcx, %rax
	imul %rdi, %rdi
	shr %rsi
	jz 2f
	mov %rax, %rcx
	imul %rdi, %rcx
	test $1, %sil
	cmovnz %rcx, %rax
	imul %rdi, %rdi
	shr %rsi
	jz 2f
	mov %rax, %rcx
	imul %rdi, %rcx
	test $1, %sil
	cmovnz %rcx, %rax
	imul %rdi, %rdi
	shr %rsi
	jz 2f
	mov %rax, %rcx
	imul %rdi, %rcx
	test $1, %sil
	cmovnz %rcx, %rax
	imul %rdi, %rdi
	shr %rsi
	jz 2f
	mov %rax, %rcx
	imul %rdi, %rcx
	test $1, %sil
	cmovnz %rcx, %rax
	imul %rdi, %rdi
	shr %rsi
	jz 2f
	mov %rax, %rcx
	imul %rdi, %rcx
	test $1, %sil
	cmovnz %rcx, %rax
	imul %rdi, %rdi
	shr %rsi
	jz 2f
	mov %rax, %rcx
	imul %rdi, %rcx
	test $1, %sil
	cmovnz %rcx, %rax
	imul %rdi, %rdi
	shr %rsi
	jz 2f
	mov %rax, %rcx
	imul %rdi, %rcx
	test $1, %sil
	cmovnz %rcx, %rax
	imul %rdi, %rdi
	shr %rsi
	jnz 1b
	2:
	
# 0 "" 2
#NO_APP
	ret
	.cfi_endproc
.LFE6279:
	.size	_ZL18pow_asm_unrolled64mm, .-_ZL18pow_asm_unrolled64mm
	.p2align 4
	.type	_ZL18pow_cpp_branchlessmm, @function
_ZL18pow_cpp_branchlessmm:
.LFB6280:
	.cfi_startproc
	mov	eax, 1
	test	rsi, rsi
	je	.L8
	.p2align 4,,10
	.p2align 3
.L7:
	test	sil, 1
	je	.L6
	imul	rax, rdi
.L6:
	imul	rdi, rdi
	shr	rsi
	jne	.L7
	ret
	.p2align 4,,10
	.p2align 3
.L8:
	ret
	.cfi_endproc
.LFE6280:
	.size	_ZL18pow_cpp_branchlessmm, .-_ZL18pow_cpp_branchlessmm
	.p2align 4
	.type	_ZL15pow_cpp_ternarymm, @function
_ZL15pow_cpp_ternarymm:
.LFB6281:
	.cfi_startproc
	mov	eax, 1
	test	rsi, rsi
	je	.L17
	.p2align 4,,10
	.p2align 3
.L16:
	test	sil, 1
	je	.L15
	imul	rax, rdi
.L15:
	imul	rdi, rdi
	shr	rsi
	jne	.L16
	ret
	.p2align 4,,10
	.p2align 3
.L17:
	ret
	.cfi_endproc
.LFE6281:
	.size	_ZL15pow_cpp_ternarymm, .-_ZL15pow_cpp_ternarymm
	.p2align 4
	.type	_ZL11wrap_binarymm, @function
_ZL11wrap_binarymm:
.LFB6349:
	.cfi_startproc
	mov	eax, 1
	test	rsi, rsi
	je	.L22
	mov	rax, rdi
	cmp	rsi, 1
	je	.L22
	mov	eax, 1
	.p2align 4,,10
	.p2align 3
.L25:
	test	sil, 1
	je	.L24
	imul	rax, rdi
.L24:
	imul	rdi, rdi
	shr	rsi
	jne	.L25
.L22:
	ret
	.cfi_endproc
.LFE6349:
	.size	_ZL11wrap_binarymm, .-_ZL11wrap_binarymm
	.p2align 4
	.type	_ZL15wrap_ultra_fastmm, @function
_ZL15wrap_ultra_fastmm:
.LFB6350:
	.cfi_startproc
	mov	eax, 1
	test	rsi, rsi
	jne	.L53
	ret
	.p2align 4,,10
	.p2align 3
.L53:
	cmp	rsi, 8
	ja	.L44
	lea	rdx, .L38[rip]
	movsx	rax, DWORD PTR [rdx+rsi*4]
	add	rax, rdx
	notrack jmp	rax
	.section	.rodata
	.align 4
	.align 4
.L38:
	.long	.L44-.L38
	.long	.L45-.L38
	.long	.L51-.L38
	.long	.L40-.L38
	.long	.L39-.L38
	.long	.L44-.L38
	.long	.L44-.L38
	.long	.L44-.L38
	.long	.L37-.L38
	.text
	.p2align 4,,10
	.p2align 3
.L44:
	mov	eax, 1
	.p2align 4,,10
	.p2align 3
.L36:
	test	sil, 1
	je	.L42
	imul	rax, rdi
.L42:
	shr	rsi
	imul	rdi, rdi
	cmp	rsi, 1
	jne	.L36
.L52:
	imul	rax, rdi
	ret
	.p2align 4,,10
	.p2align 3
.L39:
	imul	rdi, rdi
.L51:
	mov	rax, rdi
	jmp	.L52
	.p2align 4,,10
	.p2align 3
.L37:
	imul	rdi, rdi
	imul	rdi, rdi
	mov	rax, rdi
	imul	rax, rdi
	ret
	.p2align 4,,10
	.p2align 3
.L40:
	mov	rax, rdi
	imul	rax, rdi
	imul	rax, rdi
	ret
	.p2align 4,,10
	.p2align 3
.L45:
	mov	rax, rdi
	ret
	.cfi_endproc
.LFE6350:
	.size	_ZL15wrap_ultra_fastmm, .-_ZL15wrap_ultra_fastmm
	.p2align 4
	.type	_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.isra.0, @function
_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.isra.0:
.LFB7835:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rdi
	push	rbx
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	sub	rsp, 8
	.cfi_def_cfa_offset 32
	test	rsi, rsi
	je	.L57
	mov	rdi, rsi
	mov	rbx, rsi
	call	strlen@PLT
	add	rsp, 8
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	mov	rsi, rbx
	mov	rdi, rbp
	pop	rbx
	.cfi_def_cfa_offset 16
	mov	rdx, rax
	pop	rbp
	.cfi_def_cfa_offset 8
	jmp	_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l@PLT
.L57:
	.cfi_restore_state
	mov	rax, QWORD PTR [rdi]
	mov	rdi, QWORD PTR -24[rax]
	add	rdi, rbp
	mov	esi, DWORD PTR 32[rdi]
	pop	rax
	.cfi_def_cfa_offset 24
	pop	rbx
	.cfi_def_cfa_offset 16
	pop	rbp
	.cfi_def_cfa_offset 8
	or	esi, 1
	jmp	_ZNSt9basic_iosIcSt11char_traitsIcEE5clearESt12_Ios_Iostate@PLT
	.cfi_endproc
.LFE7835:
	.size	_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.isra.0, .-_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.isra.0
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align 8
.LC0:
	.string	"cannot create std::vector larger than max_size()"
	.section	.text.unlikely,"ax",@progbits
	.align 2
.LCOLDB1:
	.section	.text.startup,"ax",@progbits
.LHOTB1:
	.align 2
	.p2align 4
	.type	_ZNSt6vectorISt4pairImmESaIS1_EEC1ESt16initializer_listIS1_ERKS2_.isra.0, @function
_ZNSt6vectorISt4pairImmESaIS1_EEC1ESt16initializer_listIS1_ERKS2_.isra.0:
.LFB7837:
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gxx_personality_v0
	.cfi_lsda 0x1b,.LLSDA7837
	push	r13
	.cfi_def_cfa_offset 16
	.cfi_offset 13, -16
	vpxor	xmm0, xmm0, xmm0
	sal	rdx, 4
	movabs	rax, 9223372036854775792
	push	r12
	.cfi_def_cfa_offset 24
	.cfi_offset 12, -24
	push	rbp
	.cfi_def_cfa_offset 32
	.cfi_offset 6, -32
	mov	rbp, rdi
	push	rbx
	.cfi_def_cfa_offset 40
	.cfi_offset 3, -40
	sub	rsp, 8
	.cfi_def_cfa_offset 48
	mov	QWORD PTR 16[rdi], 0
	vmovdqu	XMMWORD PTR [rdi], xmm0
	cmp	rax, rdx
	jb	.L73
	mov	rbx, rdx
	test	rdx, rdx
	je	.L60
	mov	rdi, rdx
	mov	r12, rsi
.LEHB0:
	call	_Znwm@PLT
	lea	r13, [rax+rbx]
	mov	QWORD PTR 0[rbp], rax
	mov	rdi, rax
	mov	QWORD PTR 16[rbp], r13
	test	rbx, rbx
	je	.L64
	mov	rdx, rbx
	mov	rsi, r12
	call	memcpy@PLT
.L61:
	mov	QWORD PTR 8[rbp], r13
	add	rsp, 8
	.cfi_remember_state
	.cfi_def_cfa_offset 40
	pop	rbx
	.cfi_def_cfa_offset 32
	pop	rbp
	.cfi_def_cfa_offset 24
	pop	r12
	.cfi_def_cfa_offset 16
	pop	r13
	.cfi_def_cfa_offset 8
	ret
.L60:
	.cfi_restore_state
	xor	eax, eax
	xor	r13d, r13d
	mov	QWORD PTR [rdi], rax
	mov	QWORD PTR 16[rdi], rax
	jmp	.L61
.L64:
	mov	r13, rax
	jmp	.L61
.L73:
	lea	rdi, .LC0[rip]
	call	_ZSt20__throw_length_errorPKc@PLT
.LEHE0:
.L65:
	endbr64
	mov	rbx, rax
	jmp	.L62
	.globl	__gxx_personality_v0
	.section	.gcc_except_table,"a",@progbits
.LLSDA7837:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSE7837-.LLSDACSB7837
.LLSDACSB7837:
	.uleb128 .LEHB0-.LFB7837
	.uleb128 .LEHE0-.LEHB0
	.uleb128 .L65-.LFB7837
	.uleb128 0
.LLSDACSE7837:
	.section	.text.startup
	.cfi_endproc
	.section	.text.unlikely
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gxx_personality_v0
	.cfi_lsda 0x1b,.LLSDAC7837
	.type	_ZNSt6vectorISt4pairImmESaIS1_EEC1ESt16initializer_listIS1_ERKS2_.isra.0.cold, @function
_ZNSt6vectorISt4pairImmESaIS1_EEC1ESt16initializer_listIS1_ERKS2_.isra.0.cold:
.LFSB7837:
.L62:
	.cfi_def_cfa_offset 48
	.cfi_offset 3, -40
	.cfi_offset 6, -32
	.cfi_offset 12, -24
	.cfi_offset 13, -16
	mov	rdi, QWORD PTR 0[rbp]
	mov	rsi, QWORD PTR 16[rbp]
	sub	rsi, rdi
	test	rdi, rdi
	je	.L70
	vzeroupper
	call	_ZdlPvm@PLT
.L63:
	mov	rdi, rbx
.LEHB1:
	call	_Unwind_Resume@PLT
.LEHE1:
.L70:
	vzeroupper
	jmp	.L63
	.cfi_endproc
.LFE7837:
	.section	.gcc_except_table
.LLSDAC7837:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSEC7837-.LLSDACSBC7837
.LLSDACSBC7837:
	.uleb128 .LEHB1-.LCOLDB1
	.uleb128 .LEHE1-.LEHB1
	.uleb128 0
	.uleb128 0
.LLSDACSEC7837:
	.section	.text.unlikely
	.section	.text.startup
	.size	_ZNSt6vectorISt4pairImmESaIS1_EEC1ESt16initializer_listIS1_ERKS2_.isra.0, .-_ZNSt6vectorISt4pairImmESaIS1_EEC1ESt16initializer_listIS1_ERKS2_.isra.0
	.section	.text.unlikely
	.size	_ZNSt6vectorISt4pairImmESaIS1_EEC1ESt16initializer_listIS1_ERKS2_.isra.0.cold, .-_ZNSt6vectorISt4pairImmESaIS1_EEC1ESt16initializer_listIS1_ERKS2_.isra.0.cold
.LCOLDE1:
	.section	.text.startup
.LHOTE1:
	.section	.text._ZNSt6vectorISt4pairImmESaIS1_EED2Ev,"axG",@progbits,_ZNSt6vectorISt4pairImmESaIS1_EED5Ev,comdat
	.align 2
	.p2align 4
	.weak	_ZNSt6vectorISt4pairImmESaIS1_EED2Ev
	.type	_ZNSt6vectorISt4pairImmESaIS1_EED2Ev, @function
_ZNSt6vectorISt4pairImmESaIS1_EED2Ev:
.LFB7827:
	.cfi_startproc
	endbr64
	mov	rax, QWORD PTR [rdi]
	test	rax, rax
	je	.L76
	mov	rsi, QWORD PTR 16[rdi]
	mov	rdi, rax
	sub	rsi, rax
	jmp	_ZdlPvm@PLT
	.p2align 4,,10
	.p2align 3
.L76:
	ret
	.cfi_endproc
.LFE7827:
	.size	_ZNSt6vectorISt4pairImmESaIS1_EED2Ev, .-_ZNSt6vectorISt4pairImmESaIS1_EED2Ev
	.weak	_ZNSt6vectorISt4pairImmESaIS1_EED1Ev
	.set	_ZNSt6vectorISt4pairImmESaIS1_EED1Ev,_ZNSt6vectorISt4pairImmESaIS1_EED2Ev
	.text
	.p2align 4
	.type	_ZN7powerix16pow_hierarchicalImmEET_S1_T0_.part.0, @function
_ZN7powerix16pow_hierarchicalImmEET_S1_T0_.part.0:
.LFB7833:
	.cfi_startproc
	push	r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	push	r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	push	r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	mov	r13, rsi
	push	r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	shr	r13
	mov	r12, rdi
	push	rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	imul	r12, rdi
	mov	rbp, rdi
	push	rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	mov	rbx, rsi
	sub	rsp, 8
	.cfi_def_cfa_offset 64
	cmp	r13, 1
	je	.L78
	mov	r15, rsi
	mov	r14, r12
	shr	r15, 2
	imul	r14, r12
	cmp	r15, 1
	je	.L79
	mov	rdi, r14
	shr	rsi, 3
	imul	rdi, r14
	cmp	rsi, 1
	je	.L80
	call	_ZN7powerix16pow_hierarchicalImmEET_S1_T0_.part.0
	mov	rdi, rax
.L80:
	and	r15d, 1
	je	.L82
	imul	r14, rdi
.L79:
	and	r13d, 1
	je	.L83
	imul	r12, r14
.L78:
	and	ebx, 1
	je	.L77
	imul	r12, rbp
.L77:
	add	rsp, 8
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	mov	rax, r12
	pop	rbx
	.cfi_def_cfa_offset 48
	pop	rbp
	.cfi_def_cfa_offset 40
	pop	r12
	.cfi_def_cfa_offset 32
	pop	r13
	.cfi_def_cfa_offset 24
	pop	r14
	.cfi_def_cfa_offset 16
	pop	r15
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L83:
	.cfi_restore_state
	mov	r12, r14
	jmp	.L78
	.p2align 4,,10
	.p2align 3
.L82:
	mov	r14, rdi
	jmp	.L79
	.cfi_endproc
.LFE7833:
	.size	_ZN7powerix16pow_hierarchicalImmEET_S1_T0_.part.0, .-_ZN7powerix16pow_hierarchicalImmEET_S1_T0_.part.0
	.p2align 4
	.type	_ZL17wrap_hierarchicalmm, @function
_ZL17wrap_hierarchicalmm:
.LFB6348:
	.cfi_startproc
	mov	r8d, 1
	test	rsi, rsi
	je	.L153
	mov	rcx, rdi
	mov	rdx, rsi
	mov	r8, rdi
	cmp	rsi, 1
	je	.L153
	mov	r9, rsi
	imul	r8, rdi
	shr	r9
	cmp	r9, 1
	je	.L154
	mov	r11, rsi
	mov	r10, r8
	shr	r11, 2
	imul	r10, r8
	cmp	r11, 1
	je	.L155
	push	r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	push	r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	push	r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	push	r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	push	rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	mov	rbp, rsi
	push	rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	shr	rbp, 3
	mov	rbx, r10
	imul	rbx, r10
	sub	rsp, 56
	.cfi_def_cfa_offset 112
	cmp	rbp, 1
	je	.L101
	mov	r13, rsi
	mov	r12, rbx
	shr	r13, 4
	imul	r12, rbx
	cmp	r13, 1
	je	.L102
	mov	r15, rsi
	mov	r14, r12
	shr	r15, 5
	imul	r14, r12
	cmp	r15, 1
	je	.L103
	mov	rax, r14
	shr	rsi, 6
	imul	rax, r14
	mov	QWORD PTR 8[rsp], rsi
	mov	QWORD PTR [rsp], rax
	cmp	rsi, 1
	je	.L104
	mov	rsi, rax
	mov	rdi, rdx
	imul	rsi, rax
	shr	rdi, 7
	mov	QWORD PTR 16[rsp], rdi
	cmp	QWORD PTR 16[rsp], 1
	mov	QWORD PTR 24[rsp], rsi
	mov	rdi, rsi
	je	.L105
	imul	rsi, rsi
	mov	rdi, rdx
	shr	rdi, 8
	mov	QWORD PTR 32[rsp], rdi
	cmp	QWORD PTR 32[rsp], 1
	mov	QWORD PTR 40[rsp], rsi
	mov	rax, rsi
	mov	rdi, rsi
	je	.L106
	mov	rsi, rdx
	imul	rdi, rax
	shr	rsi, 9
	cmp	rsi, 1
	je	.L107
	call	_ZN7powerix16pow_hierarchicalImmEET_S1_T0_.part.0
	mov	rdi, rax
.L107:
	test	BYTE PTR 32[rsp], 1
	je	.L106
	mov	rax, QWORD PTR 40[rsp]
	imul	rdi, rax
.L106:
	test	BYTE PTR 16[rsp], 1
	je	.L105
	mov	rax, QWORD PTR 24[rsp]
	imul	rdi, rax
.L105:
	test	BYTE PTR 8[rsp], 1
	je	.L112
	mov	rax, QWORD PTR [rsp]
	imul	rax, rdi
	mov	QWORD PTR [rsp], rax
.L104:
	and	r15d, 1
	je	.L113
	mov	rax, QWORD PTR [rsp]
	imul	r14, rax
.L103:
	and	r13d, 1
	je	.L114
	imul	r12, r14
.L102:
	and	ebp, 1
	je	.L115
	imul	rbx, r12
.L101:
	and	r11d, 1
	jne	.L161
	mov	r10, rbx
.L100:
	and	r9d, 1
	je	.L117
	imul	r8, r10
.L99:
	and	edx, 1
	je	.L97
	imul	r8, rcx
.L97:
	add	rsp, 56
	.cfi_def_cfa_offset 56
	mov	rax, r8
	pop	rbx
	.cfi_def_cfa_offset 48
	pop	rbp
	.cfi_def_cfa_offset 40
	pop	r12
	.cfi_def_cfa_offset 32
	pop	r13
	.cfi_def_cfa_offset 24
	pop	r14
	.cfi_def_cfa_offset 16
	pop	r15
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L155:
	.cfi_restore 3
	.cfi_restore 6
	.cfi_restore 12
	.cfi_restore 13
	.cfi_restore 14
	.cfi_restore 15
	and	r9d, 1
	je	.L157
	imul	r8, r10
	.p2align 4,,10
	.p2align 3
.L154:
	and	edx, 1
	je	.L153
	imul	r8, rcx
.L153:
	mov	rax, r8
	ret
	.p2align 4,,10
	.p2align 3
.L161:
	.cfi_def_cfa_offset 112
	.cfi_offset 3, -56
	.cfi_offset 6, -48
	.cfi_offset 12, -40
	.cfi_offset 13, -32
	.cfi_offset 14, -24
	.cfi_offset 15, -16
	imul	r10, rbx
	jmp	.L100
	.p2align 4,,10
	.p2align 3
.L157:
	.cfi_def_cfa_offset 8
	.cfi_restore 3
	.cfi_restore 6
	.cfi_restore 12
	.cfi_restore 13
	.cfi_restore 14
	.cfi_restore 15
	mov	r8, r10
	jmp	.L154
	.p2align 4,,10
	.p2align 3
.L117:
	.cfi_def_cfa_offset 112
	.cfi_offset 3, -56
	.cfi_offset 6, -48
	.cfi_offset 12, -40
	.cfi_offset 13, -32
	.cfi_offset 14, -24
	.cfi_offset 15, -16
	mov	r8, r10
	jmp	.L99
	.p2align 4,,10
	.p2align 3
.L115:
	mov	rbx, r12
	jmp	.L101
.L114:
	mov	r12, r14
	jmp	.L102
.L113:
	mov	r14, QWORD PTR [rsp]
	jmp	.L103
.L112:
	mov	QWORD PTR [rsp], rdi
	jmp	.L104
	.cfi_endproc
.LFE6348:
	.size	_ZL17wrap_hierarchicalmm, .-_ZL17wrap_hierarchicalmm
	.section	.rodata.str1.8
	.align 8
.LC2:
	.string	"=== CORRECTNESS VERIFICATION ===\n"
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC8:
	.string	"MISMATCH: base="
.LC9:
	.string	" exp="
.LC10:
	.string	" ref="
.LC11:
	.string	" asm_cmov="
.LC12:
	.string	" asm_unrolled="
.LC13:
	.string	" cpp_branchless="
.LC14:
	.string	" cpp_ternary="
.LC15:
	.string	"\n"
	.section	.rodata.str1.8
	.align 8
.LC16:
	.string	"CORRECTNESS CHECK FAILED -- aborting benchmarks.\n"
	.align 8
.LC17:
	.string	"All implementations produce identical results.\n\n"
	.section	.rodata.str1.1
.LC18:
	.string	"=== IMPLEMENTATION NOTES ===\n"
	.section	.rodata.str1.8
	.align 8
.LC19:
	.string	"pow_asm_cmov:      Inline asm, cmov-based branchless loop (4 regs, no stack)\n"
	.align 8
.LC20:
	.string	"pow_asm_unrolled64: Inline asm, 8x unrolled cmov loop with early exit\n"
	.align 8
.LC21:
	.string	"pow_cpp_branchless: C++ ternary (compiler-generated, may or may not use cmov)\n"
	.align 8
.LC22:
	.string	"pow_cpp_ternary:    C++ multiplier=(exp&1)?base:1 (may use cmov)\n"
	.section	.text.startup
	.p2align 4
	.globl	main
	.type	main, @function
main:
.LFB6372:
	.cfi_startproc
	endbr64
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	push	r15
	push	r14
	push	r13
	push	r12
	push	rbx
	.cfi_offset 15, -24
	.cfi_offset 14, -32
	.cfi_offset 13, -40
	.cfi_offset 12, -48
	.cfi_offset 3, -56
	mov	rbx, rsi
	lea	rsi, .LC2[rip]
	and	rsp, -32
	sub	rsp, 320
	mov	DWORD PTR 92[rsp], edi
	lea	rdi, _ZSt4cout[rip]
	lea	r13, 184[rsp]
	lea	r14, 192[rsp]
	mov	rax, QWORD PTR fs:40
	mov	QWORD PTR 312[rsp], rax
	xor	eax, eax
	call	_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.isra.0
	mov	QWORD PTR 32[rsp], r13
	lea	rax, 96[rsp]
	vmovdqa	ymm0, YMMWORD PTR .LC3[rip]
	vmovdqa	ymm1, YMMWORD PTR .LC4[rip]
	mov	r12, rax
	lea	rcx, 296[rsp]
	mov	QWORD PTR 176[rsp], -1
	vmovdqa	YMMWORD PTR 96[rsp], ymm0
	mov	r8d, 1
	vmovdqa	YMMWORD PTR 192[rsp], ymm0
	vmovdqa	ymm0, YMMWORD PTR .LC6[rip]
	vmovdqa	YMMWORD PTR 128[rsp], ymm1
	vmovdqa	xmm1, XMMWORD PTR .LC5[rip]
	vmovdqa	YMMWORD PTR 224[rsp], ymm0
	vmovdqa	ymm0, YMMWORD PTR .LC7[rip]
	mov	QWORD PTR 288[rsp], 63
	mov	QWORD PTR 40[rsp], rcx
	mov	QWORD PTR 16[rsp], rbx
	mov	QWORD PTR 24[rsp], r14
	vmovdqa	XMMWORD PTR 160[rsp], xmm1
	vmovdqa	YMMWORD PTR 256[rsp], ymm0
	vzeroupper
	.p2align 4,,10
	.p2align 3
.L170:
	mov	rax, QWORD PTR 24[rsp]
	mov	rbx, QWORD PTR [r12]
	mov	QWORD PTR 48[rsp], r12
	mov	QWORD PTR 56[rsp], rax
	.p2align 4,,10
	.p2align 3
.L169:
	mov	rax, QWORD PTR 56[rsp]
	mov	r15d, 1
	mov	r12, QWORD PTR [rax]
	test	r12, r12
	je	.L163
	mov	r15, rbx
	cmp	r12, 1
	je	.L163
	mov	rdx, rbx
	mov	rax, r12
	mov	r15d, 1
	.p2align 4,,10
	.p2align 3
.L165:
	test	al, 1
	je	.L164
	imul	r15, rdx
.L164:
	imul	rdx, rdx
	shr	rax
	jne	.L165
.L163:
	mov	rsi, r12
	mov	rdi, rbx
	call	_ZL12pow_asm_cmovmm
	mov	rsi, r12
	mov	rdi, rbx
	mov	QWORD PTR 72[rsp], rax
	mov	rdx, rax
	call	_ZL18pow_asm_unrolled64mm
	mov	rsi, r12
	mov	rdi, rbx
	mov	r13, rax
	call	_ZL18pow_cpp_branchlessmm
	mov	rsi, r12
	mov	rdi, rbx
	mov	r14, rax
	call	_ZL15pow_cpp_ternarymm
	mov	QWORD PTR 64[rsp], rax
	cmp	rdx, r15
	jne	.L166
	cmp	r13, r15
	jne	.L166
	cmp	r14, r15
	jne	.L166
	cmp	rax, r15
	jne	.L166
.L167:
	add	QWORD PTR 56[rsp], 8
	mov	rax, QWORD PTR 56[rsp]
	cmp	QWORD PTR 40[rsp], rax
	jne	.L169
	mov	r12, QWORD PTR 48[rsp]
	add	r12, 8
	cmp	QWORD PTR 32[rsp], r12
	jne	.L170
	mov	rbx, QWORD PTR 16[rsp]
	test	r8b, r8b
	je	.L188
	lea	rsi, .LC17[rip]
	lea	rdi, _ZSt4cout[rip]
	call	_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.isra.0
	lea	rsi, .LC18[rip]
	lea	rdi, _ZSt4cout[rip]
	call	_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.isra.0
	lea	rsi, .LC19[rip]
	lea	rdi, _ZSt4cout[rip]
	call	_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.isra.0
	lea	rsi, .LC20[rip]
	lea	rdi, _ZSt4cout[rip]
	call	_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.isra.0
	lea	rsi, .LC21[rip]
	lea	rdi, _ZSt4cout[rip]
	call	_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.isra.0
	lea	rsi, .LC22[rip]
	lea	rdi, _ZSt4cout[rip]
	call	_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.isra.0
	lea	rsi, .LC15[rip]
	lea	rdi, _ZSt4cout[rip]
	call	_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.isra.0
	mov	rdx, QWORD PTR _ZN9benchmark16PrintDefaultHelpEv@GOTPCREL[rip]
	lea	rdi, 92[rsp]
	mov	rsi, rbx
	call	_ZN9benchmark10InitializeEPiPPcPFvvE@PLT
	call	_ZN9benchmark22RunSpecifiedBenchmarksEv@PLT
	call	_ZN9benchmark8ShutdownEv@PLT
	xor	eax, eax
.L162:
	mov	rdx, QWORD PTR 312[rsp]
	sub	rdx, QWORD PTR fs:40
	jne	.L189
	lea	rsp, -40[rbp]
	pop	rbx
	pop	r12
	pop	r13
	pop	r14
	pop	r15
	pop	rbp
	.cfi_remember_state
	.cfi_def_cfa 7, 8
	ret
	.p2align 4,,10
	.p2align 3
.L166:
	.cfi_restore_state
	mov	edx, 15
	lea	rsi, .LC8[rip]
	lea	rdi, _ZSt4cerr[rip]
	call	_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l@PLT
	mov	rsi, rbx
	lea	rdi, _ZSt4cerr[rip]
	call	_ZNSo9_M_insertImEERSoT_@PLT
	mov	edx, 5
	lea	rsi, .LC9[rip]
	mov	rdi, rax
	mov	QWORD PTR 80[rsp], rax
	call	_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l@PLT
	mov	rdi, QWORD PTR 80[rsp]
	mov	rsi, r12
	call	_ZNSo9_M_insertImEERSoT_@PLT
	mov	edx, 5
	lea	rsi, .LC10[rip]
	mov	r12, rax
	mov	rdi, rax
	call	_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l@PLT
	mov	rdi, r12
	mov	rsi, r15
	call	_ZNSo9_M_insertImEERSoT_@PLT
	mov	edx, 10
	lea	rsi, .LC11[rip]
	mov	rdi, rax
	mov	r12, rax
	call	_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l@PLT
	mov	rsi, QWORD PTR 72[rsp]
	mov	rdi, r12
	call	_ZNSo9_M_insertImEERSoT_@PLT
	mov	edx, 14
	lea	rsi, .LC12[rip]
	mov	r12, rax
	mov	rdi, rax
	call	_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l@PLT
	mov	rdi, r12
	mov	rsi, r13
	call	_ZNSo9_M_insertImEERSoT_@PLT
	mov	edx, 16
	lea	rsi, .LC13[rip]
	mov	r12, rax
	mov	rdi, rax
	call	_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l@PLT
	mov	rdi, r12
	mov	rsi, r14
	call	_ZNSo9_M_insertImEERSoT_@PLT
	mov	edx, 13
	lea	rsi, .LC14[rip]
	mov	rdi, rax
	mov	r12, rax
	call	_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l@PLT
	mov	rsi, QWORD PTR 64[rsp]
	mov	rdi, r12
	call	_ZNSo9_M_insertImEERSoT_@PLT
	mov	edx, 1
	lea	rsi, .LC15[rip]
	mov	rdi, rax
	call	_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l@PLT
	xor	r8d, r8d
	jmp	.L167
.L188:
	lea	rsi, .LC16[rip]
	lea	rdi, _ZSt4cerr[rip]
	call	_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.isra.0
	mov	eax, 1
	jmp	.L162
.L189:
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE6372:
	.size	main, .-main
	.section	.text._ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_disposeEv,"axG",@progbits,_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_disposeEv,comdat
	.align 2
	.p2align 4
	.weak	_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_disposeEv
	.type	_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_disposeEv, @function
_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_disposeEv:
.LFB6961:
	.cfi_startproc
	endbr64
	mov	rax, QWORD PTR [rdi]
	lea	rdx, 16[rdi]
	cmp	rax, rdx
	je	.L192
	mov	rsi, QWORD PTR 16[rdi]
	mov	rdi, rax
	add	rsi, 1
	jmp	_ZdlPvm@PLT
	.p2align 4,,10
	.p2align 3
.L192:
	ret
	.cfi_endproc
.LFE6961:
	.size	_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_disposeEv, .-_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_disposeEv
	.section	.text._ZSt11make_uniqueIN9benchmark8internal17FunctionBenchmarkEJRA22_KcPFvRNS0_5StateEEEENSt8__detail9_MakeUniqIT_E15__single_objectEDpOT0_,"axG",@progbits,_ZSt11make_uniqueIN9benchmark8internal17FunctionBenchmarkEJRA22_KcPFvRNS0_5StateEEEENSt8__detail9_MakeUniqIT_E15__single_objectEDpOT0_,comdat
	.p2align 4
	.weak	_ZSt11make_uniqueIN9benchmark8internal17FunctionBenchmarkEJRA22_KcPFvRNS0_5StateEEEENSt8__detail9_MakeUniqIT_E15__single_objectEDpOT0_
	.type	_ZSt11make_uniqueIN9benchmark8internal17FunctionBenchmarkEJRA22_KcPFvRNS0_5StateEEEENSt8__detail9_MakeUniqIT_E15__single_objectEDpOT0_, @function
_ZSt11make_uniqueIN9benchmark8internal17FunctionBenchmarkEJRA22_KcPFvRNS0_5StateEEEENSt8__detail9_MakeUniqIT_E15__single_objectEDpOT0_:
.LFB6923:
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gxx_personality_v0
	.cfi_lsda 0x1b,.LLSDA6923
	endbr64
	push	r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	push	r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	push	r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	mov	r13, rsi
	push	r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	mov	r12, rdi
	mov	edi, 312
	push	rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	push	rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	mov	rbx, rdx
	sub	rsp, 56
	.cfi_def_cfa_offset 112
	mov	rax, QWORD PTR fs:40
	mov	QWORD PTR 40[rsp], rax
	xor	eax, eax
	lea	r14, 16[rsp]
.LEHB2:
	call	_Znwm@PLT
.LEHE2:
	mov	rdi, r13
	mov	QWORD PTR [rsp], r14
	mov	r15, QWORD PTR [rbx]
	mov	rbp, rax
	call	strlen@PLT
	mov	rbx, rax
	cmp	rax, 15
	ja	.L211
	cmp	rax, 1
	je	.L212
	test	rax, rax
	jne	.L213
.L198:
	mov	rax, r14
.L197:
	mov	QWORD PTR 8[rsp], rbx
	mov	rdi, rbp
	mov	BYTE PTR [rax+rbx], 0
	mov	rbx, rsp
	mov	rsi, rbx
.LEHB3:
	call	_ZN9benchmark9BenchmarkC2ERKNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEE@PLT
.LEHE3:
	mov	rdi, QWORD PTR [rsp]
	lea	rax, _ZTVN9benchmark8internal17FunctionBenchmarkE[rip+16]
	mov	QWORD PTR 304[rbp], r15
	mov	QWORD PTR 0[rbp], rax
	mov	QWORD PTR [r12], rbp
	cmp	rdi, r14
	je	.L193
	mov	rax, QWORD PTR 16[rsp]
	lea	rsi, 1[rax]
	call	_ZdlPvm@PLT
.L193:
	mov	rax, QWORD PTR 40[rsp]
	sub	rax, QWORD PTR fs:40
	jne	.L210
	add	rsp, 56
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	mov	rax, r12
	pop	rbx
	.cfi_def_cfa_offset 48
	pop	rbp
	.cfi_def_cfa_offset 40
	pop	r12
	.cfi_def_cfa_offset 32
	pop	r13
	.cfi_def_cfa_offset 24
	pop	r14
	.cfi_def_cfa_offset 16
	pop	r15
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L212:
	.cfi_restore_state
	movzx	eax, BYTE PTR 0[r13]
	mov	BYTE PTR 16[rsp], al
	jmp	.L198
	.p2align 4,,10
	.p2align 3
.L211:
	lea	rdi, 1[rax]
.LEHB4:
	call	_Znwm@PLT
.LEHE4:
	mov	QWORD PTR [rsp], rax
	mov	rdi, rax
	mov	QWORD PTR 16[rsp], rbx
.L195:
	mov	rdx, rbx
	mov	rsi, r13
	call	memcpy@PLT
	mov	rax, QWORD PTR [rsp]
	jmp	.L197
	.p2align 4,,10
	.p2align 3
.L213:
	mov	rdi, r14
	jmp	.L195
.L200:
	mov	rdi, rbx
	vzeroupper
	call	_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_disposeEv
.L201:
	mov	esi, 312
	mov	rdi, rbp
	vzeroupper
	call	_ZdlPvm@PLT
	mov	rax, QWORD PTR 40[rsp]
	sub	rax, QWORD PTR fs:40
	je	.L202
.L210:
	call	__stack_chk_fail@PLT
.L205:
	endbr64
	mov	r12, rax
	jmp	.L200
.L204:
	endbr64
	mov	r12, rax
	jmp	.L201
.L202:
	mov	rdi, r12
.LEHB5:
	call	_Unwind_Resume@PLT
.LEHE5:
	.cfi_endproc
.LFE6923:
	.section	.gcc_except_table
.LLSDA6923:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSE6923-.LLSDACSB6923
.LLSDACSB6923:
	.uleb128 .LEHB2-.LFB6923
	.uleb128 .LEHE2-.LEHB2
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB3-.LFB6923
	.uleb128 .LEHE3-.LEHB3
	.uleb128 .L205-.LFB6923
	.uleb128 0
	.uleb128 .LEHB4-.LFB6923
	.uleb128 .LEHE4-.LEHB4
	.uleb128 .L204-.LFB6923
	.uleb128 0
	.uleb128 .LEHB5-.LFB6923
	.uleb128 .LEHE5-.LEHB5
	.uleb128 0
	.uleb128 0
.LLSDACSE6923:
	.section	.text._ZSt11make_uniqueIN9benchmark8internal17FunctionBenchmarkEJRA22_KcPFvRNS0_5StateEEEENSt8__detail9_MakeUniqIT_E15__single_objectEDpOT0_,"axG",@progbits,_ZSt11make_uniqueIN9benchmark8internal17FunctionBenchmarkEJRA22_KcPFvRNS0_5StateEEEENSt8__detail9_MakeUniqIT_E15__single_objectEDpOT0_,comdat
	.size	_ZSt11make_uniqueIN9benchmark8internal17FunctionBenchmarkEJRA22_KcPFvRNS0_5StateEEEENSt8__detail9_MakeUniqIT_E15__single_objectEDpOT0_, .-_ZSt11make_uniqueIN9benchmark8internal17FunctionBenchmarkEJRA22_KcPFvRNS0_5StateEEEENSt8__detail9_MakeUniqIT_E15__single_objectEDpOT0_
	.section	.text._ZSt11make_uniqueIN9benchmark8internal17FunctionBenchmarkEJRA16_KcPFvRNS0_5StateEEEENSt8__detail9_MakeUniqIT_E15__single_objectEDpOT0_,"axG",@progbits,_ZSt11make_uniqueIN9benchmark8internal17FunctionBenchmarkEJRA16_KcPFvRNS0_5StateEEEENSt8__detail9_MakeUniqIT_E15__single_objectEDpOT0_,comdat
	.p2align 4
	.weak	_ZSt11make_uniqueIN9benchmark8internal17FunctionBenchmarkEJRA16_KcPFvRNS0_5StateEEEENSt8__detail9_MakeUniqIT_E15__single_objectEDpOT0_
	.type	_ZSt11make_uniqueIN9benchmark8internal17FunctionBenchmarkEJRA16_KcPFvRNS0_5StateEEEENSt8__detail9_MakeUniqIT_E15__single_objectEDpOT0_, @function
_ZSt11make_uniqueIN9benchmark8internal17FunctionBenchmarkEJRA16_KcPFvRNS0_5StateEEEENSt8__detail9_MakeUniqIT_E15__single_objectEDpOT0_:
.LFB6924:
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gxx_personality_v0
	.cfi_lsda 0x1b,.LLSDA6924
	endbr64
	push	r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	push	r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	push	r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	mov	r13, rsi
	push	r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	mov	r12, rdi
	mov	edi, 312
	push	rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	push	rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	mov	rbx, rdx
	sub	rsp, 56
	.cfi_def_cfa_offset 112
	mov	rax, QWORD PTR fs:40
	mov	QWORD PTR 40[rsp], rax
	xor	eax, eax
	lea	r14, 16[rsp]
.LEHB6:
	call	_Znwm@PLT
.LEHE6:
	mov	rdi, r13
	mov	QWORD PTR [rsp], r14
	mov	r15, QWORD PTR [rbx]
	mov	rbp, rax
	call	strlen@PLT
	mov	rbx, rax
	cmp	rax, 15
	ja	.L232
	cmp	rax, 1
	je	.L233
	test	rax, rax
	jne	.L234
.L219:
	mov	rax, r14
.L218:
	mov	QWORD PTR 8[rsp], rbx
	mov	rdi, rbp
	mov	BYTE PTR [rax+rbx], 0
	mov	rbx, rsp
	mov	rsi, rbx
.LEHB7:
	call	_ZN9benchmark9BenchmarkC2ERKNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEE@PLT
.LEHE7:
	mov	rdi, QWORD PTR [rsp]
	lea	rax, _ZTVN9benchmark8internal17FunctionBenchmarkE[rip+16]
	mov	QWORD PTR 304[rbp], r15
	mov	QWORD PTR 0[rbp], rax
	mov	QWORD PTR [r12], rbp
	cmp	rdi, r14
	je	.L214
	mov	rax, QWORD PTR 16[rsp]
	lea	rsi, 1[rax]
	call	_ZdlPvm@PLT
.L214:
	mov	rax, QWORD PTR 40[rsp]
	sub	rax, QWORD PTR fs:40
	jne	.L231
	add	rsp, 56
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	mov	rax, r12
	pop	rbx
	.cfi_def_cfa_offset 48
	pop	rbp
	.cfi_def_cfa_offset 40
	pop	r12
	.cfi_def_cfa_offset 32
	pop	r13
	.cfi_def_cfa_offset 24
	pop	r14
	.cfi_def_cfa_offset 16
	pop	r15
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L233:
	.cfi_restore_state
	movzx	eax, BYTE PTR 0[r13]
	mov	BYTE PTR 16[rsp], al
	jmp	.L219
	.p2align 4,,10
	.p2align 3
.L232:
	lea	rdi, 1[rax]
.LEHB8:
	call	_Znwm@PLT
.LEHE8:
	mov	QWORD PTR [rsp], rax
	mov	rdi, rax
	mov	QWORD PTR 16[rsp], rbx
.L216:
	mov	rdx, rbx
	mov	rsi, r13
	call	memcpy@PLT
	mov	rax, QWORD PTR [rsp]
	jmp	.L218
	.p2align 4,,10
	.p2align 3
.L234:
	mov	rdi, r14
	jmp	.L216
.L221:
	mov	rdi, rbx
	vzeroupper
	call	_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_disposeEv
.L222:
	mov	esi, 312
	mov	rdi, rbp
	vzeroupper
	call	_ZdlPvm@PLT
	mov	rax, QWORD PTR 40[rsp]
	sub	rax, QWORD PTR fs:40
	je	.L223
.L231:
	call	__stack_chk_fail@PLT
.L226:
	endbr64
	mov	r12, rax
	jmp	.L221
.L225:
	endbr64
	mov	r12, rax
	jmp	.L222
.L223:
	mov	rdi, r12
.LEHB9:
	call	_Unwind_Resume@PLT
.LEHE9:
	.cfi_endproc
.LFE6924:
	.section	.gcc_except_table
.LLSDA6924:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSE6924-.LLSDACSB6924
.LLSDACSB6924:
	.uleb128 .LEHB6-.LFB6924
	.uleb128 .LEHE6-.LEHB6
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB7-.LFB6924
	.uleb128 .LEHE7-.LEHB7
	.uleb128 .L226-.LFB6924
	.uleb128 0
	.uleb128 .LEHB8-.LFB6924
	.uleb128 .LEHE8-.LEHB8
	.uleb128 .L225-.LFB6924
	.uleb128 0
	.uleb128 .LEHB9-.LFB6924
	.uleb128 .LEHE9-.LEHB9
	.uleb128 0
	.uleb128 0
.LLSDACSE6924:
	.section	.text._ZSt11make_uniqueIN9benchmark8internal17FunctionBenchmarkEJRA16_KcPFvRNS0_5StateEEEENSt8__detail9_MakeUniqIT_E15__single_objectEDpOT0_,"axG",@progbits,_ZSt11make_uniqueIN9benchmark8internal17FunctionBenchmarkEJRA16_KcPFvRNS0_5StateEEEENSt8__detail9_MakeUniqIT_E15__single_objectEDpOT0_,comdat
	.size	_ZSt11make_uniqueIN9benchmark8internal17FunctionBenchmarkEJRA16_KcPFvRNS0_5StateEEEENSt8__detail9_MakeUniqIT_E15__single_objectEDpOT0_, .-_ZSt11make_uniqueIN9benchmark8internal17FunctionBenchmarkEJRA16_KcPFvRNS0_5StateEEEENSt8__detail9_MakeUniqIT_E15__single_objectEDpOT0_
	.section	.text._ZSt11make_uniqueIN9benchmark8internal17FunctionBenchmarkEJRA19_KcPFvRNS0_5StateEEEENSt8__detail9_MakeUniqIT_E15__single_objectEDpOT0_,"axG",@progbits,_ZSt11make_uniqueIN9benchmark8internal17FunctionBenchmarkEJRA19_KcPFvRNS0_5StateEEEENSt8__detail9_MakeUniqIT_E15__single_objectEDpOT0_,comdat
	.p2align 4
	.weak	_ZSt11make_uniqueIN9benchmark8internal17FunctionBenchmarkEJRA19_KcPFvRNS0_5StateEEEENSt8__detail9_MakeUniqIT_E15__single_objectEDpOT0_
	.type	_ZSt11make_uniqueIN9benchmark8internal17FunctionBenchmarkEJRA19_KcPFvRNS0_5StateEEEENSt8__detail9_MakeUniqIT_E15__single_objectEDpOT0_, @function
_ZSt11make_uniqueIN9benchmark8internal17FunctionBenchmarkEJRA19_KcPFvRNS0_5StateEEEENSt8__detail9_MakeUniqIT_E15__single_objectEDpOT0_:
.LFB6925:
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gxx_personality_v0
	.cfi_lsda 0x1b,.LLSDA6925
	endbr64
	push	r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	push	r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	push	r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	mov	r13, rsi
	push	r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	mov	r12, rdi
	mov	edi, 312
	push	rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	push	rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	mov	rbx, rdx
	sub	rsp, 56
	.cfi_def_cfa_offset 112
	mov	rax, QWORD PTR fs:40
	mov	QWORD PTR 40[rsp], rax
	xor	eax, eax
	lea	r14, 16[rsp]
.LEHB10:
	call	_Znwm@PLT
.LEHE10:
	mov	rdi, r13
	mov	QWORD PTR [rsp], r14
	mov	r15, QWORD PTR [rbx]
	mov	rbp, rax
	call	strlen@PLT
	mov	rbx, rax
	cmp	rax, 15
	ja	.L253
	cmp	rax, 1
	je	.L254
	test	rax, rax
	jne	.L255
.L240:
	mov	rax, r14
.L239:
	mov	QWORD PTR 8[rsp], rbx
	mov	rdi, rbp
	mov	BYTE PTR [rax+rbx], 0
	mov	rbx, rsp
	mov	rsi, rbx
.LEHB11:
	call	_ZN9benchmark9BenchmarkC2ERKNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEE@PLT
.LEHE11:
	mov	rdi, QWORD PTR [rsp]
	lea	rax, _ZTVN9benchmark8internal17FunctionBenchmarkE[rip+16]
	mov	QWORD PTR 304[rbp], r15
	mov	QWORD PTR 0[rbp], rax
	mov	QWORD PTR [r12], rbp
	cmp	rdi, r14
	je	.L235
	mov	rax, QWORD PTR 16[rsp]
	lea	rsi, 1[rax]
	call	_ZdlPvm@PLT
.L235:
	mov	rax, QWORD PTR 40[rsp]
	sub	rax, QWORD PTR fs:40
	jne	.L252
	add	rsp, 56
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	mov	rax, r12
	pop	rbx
	.cfi_def_cfa_offset 48
	pop	rbp
	.cfi_def_cfa_offset 40
	pop	r12
	.cfi_def_cfa_offset 32
	pop	r13
	.cfi_def_cfa_offset 24
	pop	r14
	.cfi_def_cfa_offset 16
	pop	r15
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L254:
	.cfi_restore_state
	movzx	eax, BYTE PTR 0[r13]
	mov	BYTE PTR 16[rsp], al
	jmp	.L240
	.p2align 4,,10
	.p2align 3
.L253:
	lea	rdi, 1[rax]
.LEHB12:
	call	_Znwm@PLT
.LEHE12:
	mov	QWORD PTR [rsp], rax
	mov	rdi, rax
	mov	QWORD PTR 16[rsp], rbx
.L237:
	mov	rdx, rbx
	mov	rsi, r13
	call	memcpy@PLT
	mov	rax, QWORD PTR [rsp]
	jmp	.L239
	.p2align 4,,10
	.p2align 3
.L255:
	mov	rdi, r14
	jmp	.L237
.L242:
	mov	rdi, rbx
	vzeroupper
	call	_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_disposeEv
.L243:
	mov	esi, 312
	mov	rdi, rbp
	vzeroupper
	call	_ZdlPvm@PLT
	mov	rax, QWORD PTR 40[rsp]
	sub	rax, QWORD PTR fs:40
	je	.L244
.L252:
	call	__stack_chk_fail@PLT
.L247:
	endbr64
	mov	r12, rax
	jmp	.L242
.L246:
	endbr64
	mov	r12, rax
	jmp	.L243
.L244:
	mov	rdi, r12
.LEHB13:
	call	_Unwind_Resume@PLT
.LEHE13:
	.cfi_endproc
.LFE6925:
	.section	.gcc_except_table
.LLSDA6925:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSE6925-.LLSDACSB6925
.LLSDACSB6925:
	.uleb128 .LEHB10-.LFB6925
	.uleb128 .LEHE10-.LEHB10
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB11-.LFB6925
	.uleb128 .LEHE11-.LEHB11
	.uleb128 .L247-.LFB6925
	.uleb128 0
	.uleb128 .LEHB12-.LFB6925
	.uleb128 .LEHE12-.LEHB12
	.uleb128 .L246-.LFB6925
	.uleb128 0
	.uleb128 .LEHB13-.LFB6925
	.uleb128 .LEHE13-.LEHB13
	.uleb128 0
	.uleb128 0
.LLSDACSE6925:
	.section	.text._ZSt11make_uniqueIN9benchmark8internal17FunctionBenchmarkEJRA19_KcPFvRNS0_5StateEEEENSt8__detail9_MakeUniqIT_E15__single_objectEDpOT0_,"axG",@progbits,_ZSt11make_uniqueIN9benchmark8internal17FunctionBenchmarkEJRA19_KcPFvRNS0_5StateEEEENSt8__detail9_MakeUniqIT_E15__single_objectEDpOT0_,comdat
	.size	_ZSt11make_uniqueIN9benchmark8internal17FunctionBenchmarkEJRA19_KcPFvRNS0_5StateEEEENSt8__detail9_MakeUniqIT_E15__single_objectEDpOT0_, .-_ZSt11make_uniqueIN9benchmark8internal17FunctionBenchmarkEJRA19_KcPFvRNS0_5StateEEEENSt8__detail9_MakeUniqIT_E15__single_objectEDpOT0_
	.section	.text._ZSt11make_uniqueIN9benchmark8internal17FunctionBenchmarkEJRA17_KcPFvRNS0_5StateEEEENSt8__detail9_MakeUniqIT_E15__single_objectEDpOT0_,"axG",@progbits,_ZSt11make_uniqueIN9benchmark8internal17FunctionBenchmarkEJRA17_KcPFvRNS0_5StateEEEENSt8__detail9_MakeUniqIT_E15__single_objectEDpOT0_,comdat
	.p2align 4
	.weak	_ZSt11make_uniqueIN9benchmark8internal17FunctionBenchmarkEJRA17_KcPFvRNS0_5StateEEEENSt8__detail9_MakeUniqIT_E15__single_objectEDpOT0_
	.type	_ZSt11make_uniqueIN9benchmark8internal17FunctionBenchmarkEJRA17_KcPFvRNS0_5StateEEEENSt8__detail9_MakeUniqIT_E15__single_objectEDpOT0_, @function
_ZSt11make_uniqueIN9benchmark8internal17FunctionBenchmarkEJRA17_KcPFvRNS0_5StateEEEENSt8__detail9_MakeUniqIT_E15__single_objectEDpOT0_:
.LFB6926:
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gxx_personality_v0
	.cfi_lsda 0x1b,.LLSDA6926
	endbr64
	push	r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	push	r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	push	r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	mov	r13, rsi
	push	r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	mov	r12, rdi
	mov	edi, 312
	push	rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	push	rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	mov	rbx, rdx
	sub	rsp, 56
	.cfi_def_cfa_offset 112
	mov	rax, QWORD PTR fs:40
	mov	QWORD PTR 40[rsp], rax
	xor	eax, eax
	lea	r14, 16[rsp]
.LEHB14:
	call	_Znwm@PLT
.LEHE14:
	mov	rdi, r13
	mov	QWORD PTR [rsp], r14
	mov	r15, QWORD PTR [rbx]
	mov	rbp, rax
	call	strlen@PLT
	mov	rbx, rax
	cmp	rax, 15
	ja	.L274
	cmp	rax, 1
	je	.L275
	test	rax, rax
	jne	.L276
.L261:
	mov	rax, r14
.L260:
	mov	QWORD PTR 8[rsp], rbx
	mov	rdi, rbp
	mov	BYTE PTR [rax+rbx], 0
	mov	rbx, rsp
	mov	rsi, rbx
.LEHB15:
	call	_ZN9benchmark9BenchmarkC2ERKNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEE@PLT
.LEHE15:
	mov	rdi, QWORD PTR [rsp]
	lea	rax, _ZTVN9benchmark8internal17FunctionBenchmarkE[rip+16]
	mov	QWORD PTR 304[rbp], r15
	mov	QWORD PTR 0[rbp], rax
	mov	QWORD PTR [r12], rbp
	cmp	rdi, r14
	je	.L256
	mov	rax, QWORD PTR 16[rsp]
	lea	rsi, 1[rax]
	call	_ZdlPvm@PLT
.L256:
	mov	rax, QWORD PTR 40[rsp]
	sub	rax, QWORD PTR fs:40
	jne	.L273
	add	rsp, 56
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	mov	rax, r12
	pop	rbx
	.cfi_def_cfa_offset 48
	pop	rbp
	.cfi_def_cfa_offset 40
	pop	r12
	.cfi_def_cfa_offset 32
	pop	r13
	.cfi_def_cfa_offset 24
	pop	r14
	.cfi_def_cfa_offset 16
	pop	r15
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L275:
	.cfi_restore_state
	movzx	eax, BYTE PTR 0[r13]
	mov	BYTE PTR 16[rsp], al
	jmp	.L261
	.p2align 4,,10
	.p2align 3
.L274:
	lea	rdi, 1[rax]
.LEHB16:
	call	_Znwm@PLT
.LEHE16:
	mov	QWORD PTR [rsp], rax
	mov	rdi, rax
	mov	QWORD PTR 16[rsp], rbx
.L258:
	mov	rdx, rbx
	mov	rsi, r13
	call	memcpy@PLT
	mov	rax, QWORD PTR [rsp]
	jmp	.L260
	.p2align 4,,10
	.p2align 3
.L276:
	mov	rdi, r14
	jmp	.L258
.L263:
	mov	rdi, rbx
	vzeroupper
	call	_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_disposeEv
.L264:
	mov	esi, 312
	mov	rdi, rbp
	vzeroupper
	call	_ZdlPvm@PLT
	mov	rax, QWORD PTR 40[rsp]
	sub	rax, QWORD PTR fs:40
	je	.L265
.L273:
	call	__stack_chk_fail@PLT
.L268:
	endbr64
	mov	r12, rax
	jmp	.L263
.L267:
	endbr64
	mov	r12, rax
	jmp	.L264
.L265:
	mov	rdi, r12
.LEHB17:
	call	_Unwind_Resume@PLT
.LEHE17:
	.cfi_endproc
.LFE6926:
	.section	.gcc_except_table
.LLSDA6926:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSE6926-.LLSDACSB6926
.LLSDACSB6926:
	.uleb128 .LEHB14-.LFB6926
	.uleb128 .LEHE14-.LEHB14
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB15-.LFB6926
	.uleb128 .LEHE15-.LEHB15
	.uleb128 .L268-.LFB6926
	.uleb128 0
	.uleb128 .LEHB16-.LFB6926
	.uleb128 .LEHE16-.LEHB16
	.uleb128 .L267-.LFB6926
	.uleb128 0
	.uleb128 .LEHB17-.LFB6926
	.uleb128 .LEHE17-.LEHB17
	.uleb128 0
	.uleb128 0
.LLSDACSE6926:
	.section	.text._ZSt11make_uniqueIN9benchmark8internal17FunctionBenchmarkEJRA17_KcPFvRNS0_5StateEEEENSt8__detail9_MakeUniqIT_E15__single_objectEDpOT0_,"axG",@progbits,_ZSt11make_uniqueIN9benchmark8internal17FunctionBenchmarkEJRA17_KcPFvRNS0_5StateEEEENSt8__detail9_MakeUniqIT_E15__single_objectEDpOT0_,comdat
	.size	_ZSt11make_uniqueIN9benchmark8internal17FunctionBenchmarkEJRA17_KcPFvRNS0_5StateEEEENSt8__detail9_MakeUniqIT_E15__single_objectEDpOT0_, .-_ZSt11make_uniqueIN9benchmark8internal17FunctionBenchmarkEJRA17_KcPFvRNS0_5StateEEEENSt8__detail9_MakeUniqIT_E15__single_objectEDpOT0_
	.section	.text._ZSt11make_uniqueIN9benchmark8internal17FunctionBenchmarkEJRA21_KcPFvRNS0_5StateEEEENSt8__detail9_MakeUniqIT_E15__single_objectEDpOT0_,"axG",@progbits,_ZSt11make_uniqueIN9benchmark8internal17FunctionBenchmarkEJRA21_KcPFvRNS0_5StateEEEENSt8__detail9_MakeUniqIT_E15__single_objectEDpOT0_,comdat
	.p2align 4
	.weak	_ZSt11make_uniqueIN9benchmark8internal17FunctionBenchmarkEJRA21_KcPFvRNS0_5StateEEEENSt8__detail9_MakeUniqIT_E15__single_objectEDpOT0_
	.type	_ZSt11make_uniqueIN9benchmark8internal17FunctionBenchmarkEJRA21_KcPFvRNS0_5StateEEEENSt8__detail9_MakeUniqIT_E15__single_objectEDpOT0_, @function
_ZSt11make_uniqueIN9benchmark8internal17FunctionBenchmarkEJRA21_KcPFvRNS0_5StateEEEENSt8__detail9_MakeUniqIT_E15__single_objectEDpOT0_:
.LFB6927:
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gxx_personality_v0
	.cfi_lsda 0x1b,.LLSDA6927
	endbr64
	push	r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	push	r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	push	r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	mov	r13, rsi
	push	r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	mov	r12, rdi
	mov	edi, 312
	push	rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	push	rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	mov	rbx, rdx
	sub	rsp, 56
	.cfi_def_cfa_offset 112
	mov	rax, QWORD PTR fs:40
	mov	QWORD PTR 40[rsp], rax
	xor	eax, eax
	lea	r14, 16[rsp]
.LEHB18:
	call	_Znwm@PLT
.LEHE18:
	mov	rdi, r13
	mov	QWORD PTR [rsp], r14
	mov	r15, QWORD PTR [rbx]
	mov	rbp, rax
	call	strlen@PLT
	mov	rbx, rax
	cmp	rax, 15
	ja	.L295
	cmp	rax, 1
	je	.L296
	test	rax, rax
	jne	.L297
.L282:
	mov	rax, r14
.L281:
	mov	QWORD PTR 8[rsp], rbx
	mov	rdi, rbp
	mov	BYTE PTR [rax+rbx], 0
	mov	rbx, rsp
	mov	rsi, rbx
.LEHB19:
	call	_ZN9benchmark9BenchmarkC2ERKNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEE@PLT
.LEHE19:
	mov	rdi, QWORD PTR [rsp]
	lea	rax, _ZTVN9benchmark8internal17FunctionBenchmarkE[rip+16]
	mov	QWORD PTR 304[rbp], r15
	mov	QWORD PTR 0[rbp], rax
	mov	QWORD PTR [r12], rbp
	cmp	rdi, r14
	je	.L277
	mov	rax, QWORD PTR 16[rsp]
	lea	rsi, 1[rax]
	call	_ZdlPvm@PLT
.L277:
	mov	rax, QWORD PTR 40[rsp]
	sub	rax, QWORD PTR fs:40
	jne	.L294
	add	rsp, 56
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	mov	rax, r12
	pop	rbx
	.cfi_def_cfa_offset 48
	pop	rbp
	.cfi_def_cfa_offset 40
	pop	r12
	.cfi_def_cfa_offset 32
	pop	r13
	.cfi_def_cfa_offset 24
	pop	r14
	.cfi_def_cfa_offset 16
	pop	r15
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L296:
	.cfi_restore_state
	movzx	eax, BYTE PTR 0[r13]
	mov	BYTE PTR 16[rsp], al
	jmp	.L282
	.p2align 4,,10
	.p2align 3
.L295:
	lea	rdi, 1[rax]
.LEHB20:
	call	_Znwm@PLT
.LEHE20:
	mov	QWORD PTR [rsp], rax
	mov	rdi, rax
	mov	QWORD PTR 16[rsp], rbx
.L279:
	mov	rdx, rbx
	mov	rsi, r13
	call	memcpy@PLT
	mov	rax, QWORD PTR [rsp]
	jmp	.L281
	.p2align 4,,10
	.p2align 3
.L297:
	mov	rdi, r14
	jmp	.L279
.L284:
	mov	rdi, rbx
	vzeroupper
	call	_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_disposeEv
.L285:
	mov	esi, 312
	mov	rdi, rbp
	vzeroupper
	call	_ZdlPvm@PLT
	mov	rax, QWORD PTR 40[rsp]
	sub	rax, QWORD PTR fs:40
	je	.L286
.L294:
	call	__stack_chk_fail@PLT
.L289:
	endbr64
	mov	r12, rax
	jmp	.L284
.L288:
	endbr64
	mov	r12, rax
	jmp	.L285
.L286:
	mov	rdi, r12
.LEHB21:
	call	_Unwind_Resume@PLT
.LEHE21:
	.cfi_endproc
.LFE6927:
	.section	.gcc_except_table
.LLSDA6927:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSE6927-.LLSDACSB6927
.LLSDACSB6927:
	.uleb128 .LEHB18-.LFB6927
	.uleb128 .LEHE18-.LEHB18
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB19-.LFB6927
	.uleb128 .LEHE19-.LEHB19
	.uleb128 .L289-.LFB6927
	.uleb128 0
	.uleb128 .LEHB20-.LFB6927
	.uleb128 .LEHE20-.LEHB20
	.uleb128 .L288-.LFB6927
	.uleb128 0
	.uleb128 .LEHB21-.LFB6927
	.uleb128 .LEHE21-.LEHB21
	.uleb128 0
	.uleb128 0
.LLSDACSE6927:
	.section	.text._ZSt11make_uniqueIN9benchmark8internal17FunctionBenchmarkEJRA21_KcPFvRNS0_5StateEEEENSt8__detail9_MakeUniqIT_E15__single_objectEDpOT0_,"axG",@progbits,_ZSt11make_uniqueIN9benchmark8internal17FunctionBenchmarkEJRA21_KcPFvRNS0_5StateEEEENSt8__detail9_MakeUniqIT_E15__single_objectEDpOT0_,comdat
	.size	_ZSt11make_uniqueIN9benchmark8internal17FunctionBenchmarkEJRA21_KcPFvRNS0_5StateEEEENSt8__detail9_MakeUniqIT_E15__single_objectEDpOT0_, .-_ZSt11make_uniqueIN9benchmark8internal17FunctionBenchmarkEJRA21_KcPFvRNS0_5StateEEEENSt8__detail9_MakeUniqIT_E15__single_objectEDpOT0_
	.section	.text._ZSt11make_uniqueIN9benchmark8internal17FunctionBenchmarkEJRA23_KcPFvRNS0_5StateEEEENSt8__detail9_MakeUniqIT_E15__single_objectEDpOT0_,"axG",@progbits,_ZSt11make_uniqueIN9benchmark8internal17FunctionBenchmarkEJRA23_KcPFvRNS0_5StateEEEENSt8__detail9_MakeUniqIT_E15__single_objectEDpOT0_,comdat
	.p2align 4
	.weak	_ZSt11make_uniqueIN9benchmark8internal17FunctionBenchmarkEJRA23_KcPFvRNS0_5StateEEEENSt8__detail9_MakeUniqIT_E15__single_objectEDpOT0_
	.type	_ZSt11make_uniqueIN9benchmark8internal17FunctionBenchmarkEJRA23_KcPFvRNS0_5StateEEEENSt8__detail9_MakeUniqIT_E15__single_objectEDpOT0_, @function
_ZSt11make_uniqueIN9benchmark8internal17FunctionBenchmarkEJRA23_KcPFvRNS0_5StateEEEENSt8__detail9_MakeUniqIT_E15__single_objectEDpOT0_:
.LFB6928:
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gxx_personality_v0
	.cfi_lsda 0x1b,.LLSDA6928
	endbr64
	push	r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	push	r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	push	r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	mov	r13, rsi
	push	r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	mov	r12, rdi
	mov	edi, 312
	push	rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	push	rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	mov	rbx, rdx
	sub	rsp, 56
	.cfi_def_cfa_offset 112
	mov	rax, QWORD PTR fs:40
	mov	QWORD PTR 40[rsp], rax
	xor	eax, eax
	lea	r14, 16[rsp]
.LEHB22:
	call	_Znwm@PLT
.LEHE22:
	mov	rdi, r13
	mov	QWORD PTR [rsp], r14
	mov	r15, QWORD PTR [rbx]
	mov	rbp, rax
	call	strlen@PLT
	mov	rbx, rax
	cmp	rax, 15
	ja	.L316
	cmp	rax, 1
	je	.L317
	test	rax, rax
	jne	.L318
.L303:
	mov	rax, r14
.L302:
	mov	QWORD PTR 8[rsp], rbx
	mov	rdi, rbp
	mov	BYTE PTR [rax+rbx], 0
	mov	rbx, rsp
	mov	rsi, rbx
.LEHB23:
	call	_ZN9benchmark9BenchmarkC2ERKNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEE@PLT
.LEHE23:
	mov	rdi, QWORD PTR [rsp]
	lea	rax, _ZTVN9benchmark8internal17FunctionBenchmarkE[rip+16]
	mov	QWORD PTR 304[rbp], r15
	mov	QWORD PTR 0[rbp], rax
	mov	QWORD PTR [r12], rbp
	cmp	rdi, r14
	je	.L298
	mov	rax, QWORD PTR 16[rsp]
	lea	rsi, 1[rax]
	call	_ZdlPvm@PLT
.L298:
	mov	rax, QWORD PTR 40[rsp]
	sub	rax, QWORD PTR fs:40
	jne	.L315
	add	rsp, 56
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	mov	rax, r12
	pop	rbx
	.cfi_def_cfa_offset 48
	pop	rbp
	.cfi_def_cfa_offset 40
	pop	r12
	.cfi_def_cfa_offset 32
	pop	r13
	.cfi_def_cfa_offset 24
	pop	r14
	.cfi_def_cfa_offset 16
	pop	r15
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L317:
	.cfi_restore_state
	movzx	eax, BYTE PTR 0[r13]
	mov	BYTE PTR 16[rsp], al
	jmp	.L303
	.p2align 4,,10
	.p2align 3
.L316:
	lea	rdi, 1[rax]
.LEHB24:
	call	_Znwm@PLT
.LEHE24:
	mov	QWORD PTR [rsp], rax
	mov	rdi, rax
	mov	QWORD PTR 16[rsp], rbx
.L300:
	mov	rdx, rbx
	mov	rsi, r13
	call	memcpy@PLT
	mov	rax, QWORD PTR [rsp]
	jmp	.L302
	.p2align 4,,10
	.p2align 3
.L318:
	mov	rdi, r14
	jmp	.L300
.L305:
	mov	rdi, rbx
	vzeroupper
	call	_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_disposeEv
.L306:
	mov	esi, 312
	mov	rdi, rbp
	vzeroupper
	call	_ZdlPvm@PLT
	mov	rax, QWORD PTR 40[rsp]
	sub	rax, QWORD PTR fs:40
	je	.L307
.L315:
	call	__stack_chk_fail@PLT
.L310:
	endbr64
	mov	r12, rax
	jmp	.L305
.L309:
	endbr64
	mov	r12, rax
	jmp	.L306
.L307:
	mov	rdi, r12
.LEHB25:
	call	_Unwind_Resume@PLT
.LEHE25:
	.cfi_endproc
.LFE6928:
	.section	.gcc_except_table
.LLSDA6928:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSE6928-.LLSDACSB6928
.LLSDACSB6928:
	.uleb128 .LEHB22-.LFB6928
	.uleb128 .LEHE22-.LEHB22
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB23-.LFB6928
	.uleb128 .LEHE23-.LEHB23
	.uleb128 .L310-.LFB6928
	.uleb128 0
	.uleb128 .LEHB24-.LFB6928
	.uleb128 .LEHE24-.LEHB24
	.uleb128 .L309-.LFB6928
	.uleb128 0
	.uleb128 .LEHB25-.LFB6928
	.uleb128 .LEHE25-.LEHB25
	.uleb128 0
	.uleb128 0
.LLSDACSE6928:
	.section	.text._ZSt11make_uniqueIN9benchmark8internal17FunctionBenchmarkEJRA23_KcPFvRNS0_5StateEEEENSt8__detail9_MakeUniqIT_E15__single_objectEDpOT0_,"axG",@progbits,_ZSt11make_uniqueIN9benchmark8internal17FunctionBenchmarkEJRA23_KcPFvRNS0_5StateEEEENSt8__detail9_MakeUniqIT_E15__single_objectEDpOT0_,comdat
	.size	_ZSt11make_uniqueIN9benchmark8internal17FunctionBenchmarkEJRA23_KcPFvRNS0_5StateEEEENSt8__detail9_MakeUniqIT_E15__single_objectEDpOT0_, .-_ZSt11make_uniqueIN9benchmark8internal17FunctionBenchmarkEJRA23_KcPFvRNS0_5StateEEEENSt8__detail9_MakeUniqIT_E15__single_objectEDpOT0_
	.section	.text._ZSt11make_uniqueIN9benchmark8internal17FunctionBenchmarkEJRA20_KcPFvRNS0_5StateEEEENSt8__detail9_MakeUniqIT_E15__single_objectEDpOT0_,"axG",@progbits,_ZSt11make_uniqueIN9benchmark8internal17FunctionBenchmarkEJRA20_KcPFvRNS0_5StateEEEENSt8__detail9_MakeUniqIT_E15__single_objectEDpOT0_,comdat
	.p2align 4
	.weak	_ZSt11make_uniqueIN9benchmark8internal17FunctionBenchmarkEJRA20_KcPFvRNS0_5StateEEEENSt8__detail9_MakeUniqIT_E15__single_objectEDpOT0_
	.type	_ZSt11make_uniqueIN9benchmark8internal17FunctionBenchmarkEJRA20_KcPFvRNS0_5StateEEEENSt8__detail9_MakeUniqIT_E15__single_objectEDpOT0_, @function
_ZSt11make_uniqueIN9benchmark8internal17FunctionBenchmarkEJRA20_KcPFvRNS0_5StateEEEENSt8__detail9_MakeUniqIT_E15__single_objectEDpOT0_:
.LFB6929:
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gxx_personality_v0
	.cfi_lsda 0x1b,.LLSDA6929
	endbr64
	push	r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	push	r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	push	r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	mov	r13, rsi
	push	r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	mov	r12, rdi
	mov	edi, 312
	push	rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	push	rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	mov	rbx, rdx
	sub	rsp, 56
	.cfi_def_cfa_offset 112
	mov	rax, QWORD PTR fs:40
	mov	QWORD PTR 40[rsp], rax
	xor	eax, eax
	lea	r14, 16[rsp]
.LEHB26:
	call	_Znwm@PLT
.LEHE26:
	mov	rdi, r13
	mov	QWORD PTR [rsp], r14
	mov	r15, QWORD PTR [rbx]
	mov	rbp, rax
	call	strlen@PLT
	mov	rbx, rax
	cmp	rax, 15
	ja	.L337
	cmp	rax, 1
	je	.L338
	test	rax, rax
	jne	.L339
.L324:
	mov	rax, r14
.L323:
	mov	QWORD PTR 8[rsp], rbx
	mov	rdi, rbp
	mov	BYTE PTR [rax+rbx], 0
	mov	rbx, rsp
	mov	rsi, rbx
.LEHB27:
	call	_ZN9benchmark9BenchmarkC2ERKNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEE@PLT
.LEHE27:
	mov	rdi, QWORD PTR [rsp]
	lea	rax, _ZTVN9benchmark8internal17FunctionBenchmarkE[rip+16]
	mov	QWORD PTR 304[rbp], r15
	mov	QWORD PTR 0[rbp], rax
	mov	QWORD PTR [r12], rbp
	cmp	rdi, r14
	je	.L319
	mov	rax, QWORD PTR 16[rsp]
	lea	rsi, 1[rax]
	call	_ZdlPvm@PLT
.L319:
	mov	rax, QWORD PTR 40[rsp]
	sub	rax, QWORD PTR fs:40
	jne	.L336
	add	rsp, 56
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	mov	rax, r12
	pop	rbx
	.cfi_def_cfa_offset 48
	pop	rbp
	.cfi_def_cfa_offset 40
	pop	r12
	.cfi_def_cfa_offset 32
	pop	r13
	.cfi_def_cfa_offset 24
	pop	r14
	.cfi_def_cfa_offset 16
	pop	r15
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L338:
	.cfi_restore_state
	movzx	eax, BYTE PTR 0[r13]
	mov	BYTE PTR 16[rsp], al
	jmp	.L324
	.p2align 4,,10
	.p2align 3
.L337:
	lea	rdi, 1[rax]
.LEHB28:
	call	_Znwm@PLT
.LEHE28:
	mov	QWORD PTR [rsp], rax
	mov	rdi, rax
	mov	QWORD PTR 16[rsp], rbx
.L321:
	mov	rdx, rbx
	mov	rsi, r13
	call	memcpy@PLT
	mov	rax, QWORD PTR [rsp]
	jmp	.L323
	.p2align 4,,10
	.p2align 3
.L339:
	mov	rdi, r14
	jmp	.L321
.L326:
	mov	rdi, rbx
	vzeroupper
	call	_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_disposeEv
.L327:
	mov	esi, 312
	mov	rdi, rbp
	vzeroupper
	call	_ZdlPvm@PLT
	mov	rax, QWORD PTR 40[rsp]
	sub	rax, QWORD PTR fs:40
	je	.L328
.L336:
	call	__stack_chk_fail@PLT
.L331:
	endbr64
	mov	r12, rax
	jmp	.L326
.L330:
	endbr64
	mov	r12, rax
	jmp	.L327
.L328:
	mov	rdi, r12
.LEHB29:
	call	_Unwind_Resume@PLT
.LEHE29:
	.cfi_endproc
.LFE6929:
	.section	.gcc_except_table
.LLSDA6929:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSE6929-.LLSDACSB6929
.LLSDACSB6929:
	.uleb128 .LEHB26-.LFB6929
	.uleb128 .LEHE26-.LEHB26
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB27-.LFB6929
	.uleb128 .LEHE27-.LEHB27
	.uleb128 .L331-.LFB6929
	.uleb128 0
	.uleb128 .LEHB28-.LFB6929
	.uleb128 .LEHE28-.LEHB28
	.uleb128 .L330-.LFB6929
	.uleb128 0
	.uleb128 .LEHB29-.LFB6929
	.uleb128 .LEHE29-.LEHB29
	.uleb128 0
	.uleb128 0
.LLSDACSE6929:
	.section	.text._ZSt11make_uniqueIN9benchmark8internal17FunctionBenchmarkEJRA20_KcPFvRNS0_5StateEEEENSt8__detail9_MakeUniqIT_E15__single_objectEDpOT0_,"axG",@progbits,_ZSt11make_uniqueIN9benchmark8internal17FunctionBenchmarkEJRA20_KcPFvRNS0_5StateEEEENSt8__detail9_MakeUniqIT_E15__single_objectEDpOT0_,comdat
	.size	_ZSt11make_uniqueIN9benchmark8internal17FunctionBenchmarkEJRA20_KcPFvRNS0_5StateEEEENSt8__detail9_MakeUniqIT_E15__single_objectEDpOT0_, .-_ZSt11make_uniqueIN9benchmark8internal17FunctionBenchmarkEJRA20_KcPFvRNS0_5StateEEEENSt8__detail9_MakeUniqIT_E15__single_objectEDpOT0_
	.section	.rodata.str1.1
.LC53:
	.string	"BM_Hierarchical_Small"
.LC54:
	.string	"BM_Binary_Small"
.LC55:
	.string	"BM_UltraFast_Small"
.LC56:
	.string	"BM_AsmCmov_Small"
.LC57:
	.string	"BM_AsmUnrolled_Small"
.LC58:
	.string	"BM_CppBranchless_Small"
.LC59:
	.string	"BM_CppTernary_Small"
.LC60:
	.string	"BM_Hierarchical_Med"
.LC61:
	.string	"BM_UltraFast_Med"
.LC62:
	.string	"BM_AsmUnrolled_Med"
.LC63:
	.string	"BM_CppBranchless_Med"
.LC64:
	.string	"BM_Hierarchical_Large"
.LC65:
	.string	"BM_Binary_Large"
.LC66:
	.string	"BM_UltraFast_Large"
.LC67:
	.string	"BM_AsmCmov_Large"
.LC68:
	.string	"BM_AsmUnrolled_Large"
.LC69:
	.string	"BM_CppBranchless_Large"
.LC70:
	.string	"BM_CppTernary_Large"
	.section	.text.unlikely
.LCOLDB72:
	.section	.text.startup
.LHOTB72:
	.p2align 4
	.type	_Z41__static_initialization_and_destruction_0v, @function
_Z41__static_initialization_and_destruction_0v:
.LFB7825:
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gxx_personality_v0
	.cfi_lsda 0x1b,.LLSDA7825
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	push	r15
	push	r14
	push	r13
	.cfi_offset 15, -24
	.cfi_offset 14, -32
	.cfi_offset 13, -40
	lea	r13, _ZL7kMedExp[rip]
	push	r12
	.cfi_offset 12, -48
	lea	r12, __dso_handle[rip]
	push	rbx
	.cfi_offset 3, -56
	lea	rbx, _ZL9kSmallExp[rip]
	and	rsp, -32
	sub	rsp, 544
	mov	rax, QWORD PTR fs:40
	mov	QWORD PTR 536[rsp], rax
	xor	eax, eax
	lea	r14, 64[rsp]
.LEHB30:
	call	_ZN9benchmark8internal17InitializeStreamsEv@PLT
	xor	eax, eax
	lea	rdi, 64[rsp]
	mov	rsi, r14
	vmovdqa	ymm0, YMMWORD PTR .LC23[rip]
	mov	ecx, 56
	mov	edx, 28
	rep stosq
	mov	rdi, rbx
	mov	QWORD PTR 64[rsp], 2
	vmovdqu	YMMWORD PTR 80[rsp], ymm0
	vmovdqa	ymm0, YMMWORD PTR .LC24[rip]
	mov	QWORD PTR 176[rsp], 3
	vmovdqu	YMMWORD PTR 112[rsp], ymm0
	vmovdqa	ymm0, YMMWORD PTR .LC25[rip]
	mov	QWORD PTR 288[rsp], 5
	vmovdqu	YMMWORD PTR 144[rsp], ymm0
	vmovdqa	ymm0, YMMWORD PTR .LC26[rip]
	mov	QWORD PTR 400[rsp], 7
	vmovdqa	YMMWORD PTR 192[rsp], ymm0
	vmovdqa	ymm0, YMMWORD PTR .LC27[rip]
	vmovdqa	YMMWORD PTR 224[rsp], ymm0
	vmovdqa	ymm0, YMMWORD PTR .LC28[rip]
	vmovdqa	YMMWORD PTR 256[rsp], ymm0
	vmovdqa	ymm0, YMMWORD PTR .LC29[rip]
	vmovdqu	YMMWORD PTR 304[rsp], ymm0
	vmovdqa	ymm0, YMMWORD PTR .LC30[rip]
	vmovdqu	YMMWORD PTR 336[rsp], ymm0
	vmovdqa	ymm0, YMMWORD PTR .LC31[rip]
	vmovdqu	YMMWORD PTR 368[rsp], ymm0
	vmovdqa	ymm0, YMMWORD PTR .LC32[rip]
	vmovdqa	YMMWORD PTR 416[rsp], ymm0
	vmovdqa	ymm0, YMMWORD PTR .LC33[rip]
	vmovdqa	YMMWORD PTR 448[rsp], ymm0
	vmovdqa	ymm0, YMMWORD PTR .LC34[rip]
	vmovdqa	YMMWORD PTR 480[rsp], ymm0
	vzeroupper
	call	_ZNSt6vectorISt4pairImmESaIS1_EEC1ESt16initializer_listIS1_ERKS2_.isra.0
	mov	rsi, rbx
	mov	rdx, r12
	lea	rbx, _ZNSt6vectorISt4pairImmESaIS1_EED1Ev[rip]
	mov	rdi, rbx
	call	__cxa_atexit@PLT
	mov	rdi, r13
	mov	rsi, r14
	mov	edx, 20
	vmovdqa	ymm0, YMMWORD PTR .LC35[rip]
	vmovdqa	YMMWORD PTR 64[rsp], ymm0
	vmovdqa	ymm0, YMMWORD PTR .LC36[rip]
	vmovdqa	YMMWORD PTR 96[rsp], ymm0
	vmovdqa	ymm0, YMMWORD PTR .LC37[rip]
	vmovdqa	YMMWORD PTR 128[rsp], ymm0
	vmovdqa	ymm0, YMMWORD PTR .LC38[rip]
	vmovdqa	YMMWORD PTR 160[rsp], ymm0
	vmovdqa	ymm0, YMMWORD PTR .LC39[rip]
	vmovdqa	YMMWORD PTR 192[rsp], ymm0
	vmovdqa	ymm0, YMMWORD PTR .LC40[rip]
	vmovdqa	YMMWORD PTR 224[rsp], ymm0
	vmovdqa	ymm0, YMMWORD PTR .LC41[rip]
	vmovdqa	YMMWORD PTR 256[rsp], ymm0
	vmovdqa	ymm0, YMMWORD PTR .LC42[rip]
	vmovdqa	YMMWORD PTR 288[rsp], ymm0
	vmovdqa	ymm0, YMMWORD PTR .LC43[rip]
	vmovdqa	YMMWORD PTR 320[rsp], ymm0
	vmovdqa	ymm0, YMMWORD PTR .LC44[rip]
	vmovdqa	YMMWORD PTR 352[rsp], ymm0
	vzeroupper
	call	_ZNSt6vectorISt4pairImmESaIS1_EEC1ESt16initializer_listIS1_ERKS2_.isra.0
	mov	rdx, r12
	mov	rsi, r13
	mov	rdi, rbx
	lea	r13, _ZL9kLargeExp[rip]
	call	__cxa_atexit@PLT
	mov	rdi, r13
	mov	rsi, r14
	mov	edx, 15
	vmovdqa	ymm0, YMMWORD PTR .LC45[rip]
	vmovdqa	YMMWORD PTR 64[rsp], ymm0
	vmovdqa	ymm0, YMMWORD PTR .LC46[rip]
	vmovdqa	YMMWORD PTR 96[rsp], ymm0
	vmovdqa	ymm0, YMMWORD PTR .LC47[rip]
	vmovdqa	YMMWORD PTR 128[rsp], ymm0
	vmovdqa	ymm0, YMMWORD PTR .LC48[rip]
	vmovdqa	YMMWORD PTR 160[rsp], ymm0
	vmovdqa	ymm0, YMMWORD PTR .LC49[rip]
	vmovdqa	YMMWORD PTR 192[rsp], ymm0
	vmovdqa	ymm0, YMMWORD PTR .LC50[rip]
	vmovdqa	YMMWORD PTR 224[rsp], ymm0
	vmovdqa	ymm0, YMMWORD PTR .LC51[rip]
	vmovdqa	YMMWORD PTR 256[rsp], ymm0
	vmovdqa	xmm0, XMMWORD PTR .LC52[rip]
	vmovdqa	XMMWORD PTR 288[rsp], xmm0
	vzeroupper
	call	_ZNSt6vectorISt4pairImmESaIS1_EEC1ESt16initializer_listIS1_ERKS2_.isra.0
	mov	rdx, r12
	mov	rsi, r13
	mov	rdi, rbx
	lea	r12, 48[rsp]
	lea	r13, 40[rsp]
	call	__cxa_atexit@PLT
	mov	rdi, r12
	mov	rdx, r13
	lea	rbx, 56[rsp]
	lea	rax, _ZL21BM_Hierarchical_SmallRN9benchmark5StateE[rip]
	lea	rsi, .LC53[rip]
	mov	QWORD PTR 40[rsp], rax
	call	_ZSt11make_uniqueIN9benchmark8internal17FunctionBenchmarkEJRA22_KcPFvRNS0_5StateEEEENSt8__detail9_MakeUniqIT_E15__single_objectEDpOT0_
.LEHE30:
	mov	rax, QWORD PTR 48[rsp]
	mov	rdi, rbx
	mov	QWORD PTR 48[rsp], 0
	mov	QWORD PTR 56[rsp], rax
.LEHB31:
	call	_ZN9benchmark8internal25RegisterBenchmarkInternalESt10unique_ptrINS_9BenchmarkESt14default_deleteIS2_EE@PLT
.LEHE31:
	mov	rdi, QWORD PTR 56[rsp]
	test	rdi, rdi
	je	.L341
	mov	rax, QWORD PTR [rdi]
	call	[QWORD PTR 8[rax]]
.L341:
	lea	rax, _ZL15BM_Binary_SmallRN9benchmark5StateE[rip]
	mov	rdi, r12
	mov	rdx, r13
	mov	QWORD PTR 40[rsp], rax
	lea	rsi, .LC54[rip]
.LEHB32:
	call	_ZSt11make_uniqueIN9benchmark8internal17FunctionBenchmarkEJRA16_KcPFvRNS0_5StateEEEENSt8__detail9_MakeUniqIT_E15__single_objectEDpOT0_
.LEHE32:
	mov	rax, QWORD PTR 48[rsp]
	mov	rdi, rbx
	mov	QWORD PTR 48[rsp], 0
	mov	QWORD PTR 56[rsp], rax
.LEHB33:
	call	_ZN9benchmark8internal25RegisterBenchmarkInternalESt10unique_ptrINS_9BenchmarkESt14default_deleteIS2_EE@PLT
.LEHE33:
	mov	rdi, QWORD PTR 56[rsp]
	test	rdi, rdi
	je	.L342
	mov	rax, QWORD PTR [rdi]
	call	[QWORD PTR 8[rax]]
.L342:
	lea	rax, _ZL18BM_UltraFast_SmallRN9benchmark5StateE[rip]
	mov	rdi, r12
	mov	rdx, r13
	mov	QWORD PTR 40[rsp], rax
	lea	rsi, .LC55[rip]
.LEHB34:
	call	_ZSt11make_uniqueIN9benchmark8internal17FunctionBenchmarkEJRA19_KcPFvRNS0_5StateEEEENSt8__detail9_MakeUniqIT_E15__single_objectEDpOT0_
.LEHE34:
	mov	rax, QWORD PTR 48[rsp]
	mov	rdi, rbx
	mov	QWORD PTR 48[rsp], 0
	mov	QWORD PTR 56[rsp], rax
.LEHB35:
	call	_ZN9benchmark8internal25RegisterBenchmarkInternalESt10unique_ptrINS_9BenchmarkESt14default_deleteIS2_EE@PLT
.LEHE35:
	mov	rdi, QWORD PTR 56[rsp]
	test	rdi, rdi
	je	.L343
	mov	rax, QWORD PTR [rdi]
	call	[QWORD PTR 8[rax]]
.L343:
	lea	rax, _ZL16BM_AsmCmov_SmallRN9benchmark5StateE[rip]
	mov	rdi, r12
	mov	rdx, r13
	mov	QWORD PTR 40[rsp], rax
	lea	rsi, .LC56[rip]
.LEHB36:
	call	_ZSt11make_uniqueIN9benchmark8internal17FunctionBenchmarkEJRA17_KcPFvRNS0_5StateEEEENSt8__detail9_MakeUniqIT_E15__single_objectEDpOT0_
.LEHE36:
	mov	rax, QWORD PTR 48[rsp]
	mov	rdi, rbx
	mov	QWORD PTR 48[rsp], 0
	mov	QWORD PTR 56[rsp], rax
.LEHB37:
	call	_ZN9benchmark8internal25RegisterBenchmarkInternalESt10unique_ptrINS_9BenchmarkESt14default_deleteIS2_EE@PLT
.LEHE37:
	mov	rdi, QWORD PTR 56[rsp]
	test	rdi, rdi
	je	.L344
	mov	rax, QWORD PTR [rdi]
	call	[QWORD PTR 8[rax]]
.L344:
	lea	rax, _ZL20BM_AsmUnrolled_SmallRN9benchmark5StateE[rip]
	mov	rdi, r12
	mov	rdx, r13
	mov	QWORD PTR 40[rsp], rax
	lea	rsi, .LC57[rip]
.LEHB38:
	call	_ZSt11make_uniqueIN9benchmark8internal17FunctionBenchmarkEJRA21_KcPFvRNS0_5StateEEEENSt8__detail9_MakeUniqIT_E15__single_objectEDpOT0_
.LEHE38:
	mov	rax, QWORD PTR 48[rsp]
	mov	rdi, rbx
	mov	QWORD PTR 48[rsp], 0
	mov	QWORD PTR 56[rsp], rax
.LEHB39:
	call	_ZN9benchmark8internal25RegisterBenchmarkInternalESt10unique_ptrINS_9BenchmarkESt14default_deleteIS2_EE@PLT
.LEHE39:
	mov	rdi, QWORD PTR 56[rsp]
	test	rdi, rdi
	je	.L345
	mov	rax, QWORD PTR [rdi]
	call	[QWORD PTR 8[rax]]
.L345:
	lea	rax, _ZL22BM_CppBranchless_SmallRN9benchmark5StateE[rip]
	mov	rdi, r12
	mov	rdx, r13
	mov	QWORD PTR 40[rsp], rax
	lea	rsi, .LC58[rip]
.LEHB40:
	call	_ZSt11make_uniqueIN9benchmark8internal17FunctionBenchmarkEJRA23_KcPFvRNS0_5StateEEEENSt8__detail9_MakeUniqIT_E15__single_objectEDpOT0_
.LEHE40:
	mov	rax, QWORD PTR 48[rsp]
	mov	rdi, rbx
	mov	QWORD PTR 48[rsp], 0
	mov	QWORD PTR 56[rsp], rax
.LEHB41:
	call	_ZN9benchmark8internal25RegisterBenchmarkInternalESt10unique_ptrINS_9BenchmarkESt14default_deleteIS2_EE@PLT
.LEHE41:
	mov	rdi, QWORD PTR 56[rsp]
	test	rdi, rdi
	je	.L346
	mov	rax, QWORD PTR [rdi]
	call	[QWORD PTR 8[rax]]
.L346:
	lea	rax, _ZL19BM_CppTernary_SmallRN9benchmark5StateE[rip]
	mov	rdi, r12
	mov	rdx, r13
	mov	QWORD PTR 40[rsp], rax
	lea	rsi, .LC59[rip]
.LEHB42:
	call	_ZSt11make_uniqueIN9benchmark8internal17FunctionBenchmarkEJRA20_KcPFvRNS0_5StateEEEENSt8__detail9_MakeUniqIT_E15__single_objectEDpOT0_
.LEHE42:
	mov	rax, QWORD PTR 48[rsp]
	mov	rdi, rbx
	mov	QWORD PTR 48[rsp], 0
	mov	QWORD PTR 56[rsp], rax
.LEHB43:
	call	_ZN9benchmark8internal25RegisterBenchmarkInternalESt10unique_ptrINS_9BenchmarkESt14default_deleteIS2_EE@PLT
.LEHE43:
	mov	rdi, QWORD PTR 56[rsp]
	test	rdi, rdi
	je	.L347
	mov	rax, QWORD PTR [rdi]
	call	[QWORD PTR 8[rax]]
.L347:
	lea	rax, _ZL19BM_Hierarchical_MedRN9benchmark5StateE[rip]
	mov	rdi, r12
	mov	rdx, r13
	mov	QWORD PTR 40[rsp], rax
	lea	rsi, .LC60[rip]
.LEHB44:
	call	_ZSt11make_uniqueIN9benchmark8internal17FunctionBenchmarkEJRA20_KcPFvRNS0_5StateEEEENSt8__detail9_MakeUniqIT_E15__single_objectEDpOT0_
.LEHE44:
	mov	rax, QWORD PTR 48[rsp]
	mov	rdi, rbx
	mov	QWORD PTR 48[rsp], 0
	mov	QWORD PTR 56[rsp], rax
.LEHB45:
	call	_ZN9benchmark8internal25RegisterBenchmarkInternalESt10unique_ptrINS_9BenchmarkESt14default_deleteIS2_EE@PLT
.LEHE45:
	mov	rdi, QWORD PTR 56[rsp]
	test	rdi, rdi
	je	.L348
	mov	rax, QWORD PTR [rdi]
	call	[QWORD PTR 8[rax]]
.L348:
	mov	edi, 312
	lea	r15, 80[rsp]
.LEHB46:
	call	_Znwm@PLT
.LEHE46:
	mov	QWORD PTR 64[rsp], r15
	mov	rsi, r14
	movabs	rcx, 8241990191428881730
	mov	QWORD PTR 80[rsp], rcx
	mov	rdi, rax
	movabs	rcx, 7234273448895340910
	mov	QWORD PTR 85[rsp], rcx
	mov	QWORD PTR 72[rsp], 13
	mov	BYTE PTR 93[rsp], 0
	mov	QWORD PTR 24[rsp], rax
.LEHB47:
	call	_ZN9benchmark9BenchmarkC2ERKNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEE@PLT
.LEHE47:
	mov	rax, QWORD PTR 24[rsp]
	lea	rcx, _ZTVN9benchmark8internal17FunctionBenchmarkE[rip+16]
	mov	rdi, QWORD PTR 64[rsp]
	mov	QWORD PTR [rax], rcx
	lea	rcx, _ZL13BM_Binary_MedRN9benchmark5StateE[rip]
	mov	QWORD PTR 304[rax], rcx
	cmp	rdi, r15
	je	.L349
	mov	rax, QWORD PTR 80[rsp]
	lea	rsi, 1[rax]
	call	_ZdlPvm@PLT
.L349:
	mov	rax, QWORD PTR 24[rsp]
	mov	rdi, rbx
	mov	QWORD PTR 56[rsp], rax
.LEHB48:
	call	_ZN9benchmark8internal25RegisterBenchmarkInternalESt10unique_ptrINS_9BenchmarkESt14default_deleteIS2_EE@PLT
.LEHE48:
	mov	rdi, QWORD PTR 56[rsp]
	test	rdi, rdi
	je	.L353
	mov	rax, QWORD PTR [rdi]
	call	[QWORD PTR 8[rax]]
.L353:
	lea	rax, _ZL16BM_UltraFast_MedRN9benchmark5StateE[rip]
	mov	rdi, r12
	mov	rdx, r13
	mov	QWORD PTR 40[rsp], rax
	lea	rsi, .LC61[rip]
.LEHB49:
	call	_ZSt11make_uniqueIN9benchmark8internal17FunctionBenchmarkEJRA17_KcPFvRNS0_5StateEEEENSt8__detail9_MakeUniqIT_E15__single_objectEDpOT0_
.LEHE49:
	mov	rax, QWORD PTR 48[rsp]
	mov	rdi, rbx
	mov	QWORD PTR 48[rsp], 0
	mov	QWORD PTR 56[rsp], rax
.LEHB50:
	call	_ZN9benchmark8internal25RegisterBenchmarkInternalESt10unique_ptrINS_9BenchmarkESt14default_deleteIS2_EE@PLT
.LEHE50:
	mov	rdi, QWORD PTR 56[rsp]
	test	rdi, rdi
	je	.L354
	mov	rax, QWORD PTR [rdi]
	call	[QWORD PTR 8[rax]]
.L354:
	mov	edi, 312
.LEHB51:
	call	_Znwm@PLT
.LEHE51:
	mov	QWORD PTR 64[rsp], r15
	mov	rsi, r14
	movabs	rcx, 7873256915359190338
	mov	QWORD PTR 80[rsp], rcx
	mov	rdi, rax
	movabs	rcx, 7234273448844815683
	mov	QWORD PTR 86[rsp], rcx
	mov	QWORD PTR 72[rsp], 14
	mov	BYTE PTR 94[rsp], 0
	mov	QWORD PTR 24[rsp], rax
.LEHB52:
	call	_ZN9benchmark9BenchmarkC2ERKNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEE@PLT
.LEHE52:
	mov	rax, QWORD PTR 24[rsp]
	lea	rcx, _ZTVN9benchmark8internal17FunctionBenchmarkE[rip+16]
	mov	rdi, QWORD PTR 64[rsp]
	mov	QWORD PTR [rax], rcx
	lea	rcx, _ZL14BM_AsmCmov_MedRN9benchmark5StateE[rip]
	mov	QWORD PTR 304[rax], rcx
	cmp	rdi, r15
	je	.L355
	mov	rax, QWORD PTR 80[rsp]
	lea	rsi, 1[rax]
	call	_ZdlPvm@PLT
.L355:
	mov	rax, QWORD PTR 24[rsp]
	mov	rdi, rbx
	mov	QWORD PTR 56[rsp], rax
.LEHB53:
	call	_ZN9benchmark8internal25RegisterBenchmarkInternalESt10unique_ptrINS_9BenchmarkESt14default_deleteIS2_EE@PLT
.LEHE53:
	mov	rdi, QWORD PTR 56[rsp]
	test	rdi, rdi
	je	.L359
	mov	rax, QWORD PTR [rdi]
	call	[QWORD PTR 8[rax]]
.L359:
	lea	rax, _ZL18BM_AsmUnrolled_MedRN9benchmark5StateE[rip]
	mov	rdi, r12
	mov	rdx, r13
	mov	QWORD PTR 40[rsp], rax
	lea	rsi, .LC62[rip]
.LEHB54:
	call	_ZSt11make_uniqueIN9benchmark8internal17FunctionBenchmarkEJRA19_KcPFvRNS0_5StateEEEENSt8__detail9_MakeUniqIT_E15__single_objectEDpOT0_
.LEHE54:
	mov	rax, QWORD PTR 48[rsp]
	mov	rdi, rbx
	mov	QWORD PTR 48[rsp], 0
	mov	QWORD PTR 56[rsp], rax
.LEHB55:
	call	_ZN9benchmark8internal25RegisterBenchmarkInternalESt10unique_ptrINS_9BenchmarkESt14default_deleteIS2_EE@PLT
.LEHE55:
	mov	rdi, QWORD PTR 56[rsp]
	test	rdi, rdi
	je	.L360
	mov	rax, QWORD PTR [rdi]
	call	[QWORD PTR 8[rax]]
.L360:
	lea	rax, _ZL20BM_CppBranchless_MedRN9benchmark5StateE[rip]
	mov	rdi, r12
	mov	rdx, r13
	mov	QWORD PTR 40[rsp], rax
	lea	rsi, .LC63[rip]
.LEHB56:
	call	_ZSt11make_uniqueIN9benchmark8internal17FunctionBenchmarkEJRA21_KcPFvRNS0_5StateEEEENSt8__detail9_MakeUniqIT_E15__single_objectEDpOT0_
.LEHE56:
	mov	rax, QWORD PTR 48[rsp]
	mov	rdi, rbx
	mov	QWORD PTR 48[rsp], 0
	mov	QWORD PTR 56[rsp], rax
.LEHB57:
	call	_ZN9benchmark8internal25RegisterBenchmarkInternalESt10unique_ptrINS_9BenchmarkESt14default_deleteIS2_EE@PLT
.LEHE57:
	mov	rdi, QWORD PTR 56[rsp]
	test	rdi, rdi
	je	.L361
	mov	rax, QWORD PTR [rdi]
	call	[QWORD PTR 8[rax]]
.L361:
	mov	edi, 312
.LEHB58:
	call	_Znwm@PLT
.LEHE58:
	mov	QWORD PTR 64[rsp], r15
	mov	edi, 18
	mov	QWORD PTR 24[rsp], rax
.LEHB59:
	call	_Znwm@PLT
.LEHE59:
	vmovdqa	xmm0, XMMWORD PTR .LC71[rip]
	mov	rdi, QWORD PTR 24[rsp]
	mov	BYTE PTR 16[rax], 100
	mov	rsi, r14
	mov	QWORD PTR 64[rsp], rax
	mov	QWORD PTR 80[rsp], 17
	mov	QWORD PTR 72[rsp], 17
	mov	BYTE PTR 17[rax], 0
	vmovdqu	XMMWORD PTR [rax], xmm0
.LEHB60:
	call	_ZN9benchmark9BenchmarkC2ERKNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEE@PLT
.LEHE60:
	mov	rax, QWORD PTR 24[rsp]
	lea	rcx, _ZTVN9benchmark8internal17FunctionBenchmarkE[rip+16]
	mov	rdi, QWORD PTR 64[rsp]
	mov	QWORD PTR [rax], rcx
	lea	rcx, _ZL17BM_CppTernary_MedRN9benchmark5StateE[rip]
	mov	QWORD PTR 304[rax], rcx
	cmp	rdi, r15
	je	.L362
	mov	rax, QWORD PTR 80[rsp]
	lea	rsi, 1[rax]
	call	_ZdlPvm@PLT
.L362:
	mov	rax, QWORD PTR 24[rsp]
	mov	rdi, rbx
	mov	QWORD PTR 56[rsp], rax
.LEHB61:
	call	_ZN9benchmark8internal25RegisterBenchmarkInternalESt10unique_ptrINS_9BenchmarkESt14default_deleteIS2_EE@PLT
.LEHE61:
	mov	rdi, QWORD PTR 56[rsp]
	test	rdi, rdi
	je	.L367
	mov	rax, QWORD PTR [rdi]
	call	[QWORD PTR 8[rax]]
.L367:
	lea	rax, _ZL21BM_Hierarchical_LargeRN9benchmark5StateE[rip]
	mov	rdi, r12
	mov	rdx, r13
	mov	QWORD PTR 40[rsp], rax
	lea	rsi, .LC64[rip]
.LEHB62:
	call	_ZSt11make_uniqueIN9benchmark8internal17FunctionBenchmarkEJRA22_KcPFvRNS0_5StateEEEENSt8__detail9_MakeUniqIT_E15__single_objectEDpOT0_
.LEHE62:
	mov	rax, QWORD PTR 48[rsp]
	mov	rdi, rbx
	mov	QWORD PTR 48[rsp], 0
	mov	QWORD PTR 56[rsp], rax
.LEHB63:
	call	_ZN9benchmark8internal25RegisterBenchmarkInternalESt10unique_ptrINS_9BenchmarkESt14default_deleteIS2_EE@PLT
.LEHE63:
	mov	rdi, QWORD PTR 56[rsp]
	test	rdi, rdi
	je	.L368
	mov	rax, QWORD PTR [rdi]
	call	[QWORD PTR 8[rax]]
.L368:
	lea	rax, _ZL15BM_Binary_LargeRN9benchmark5StateE[rip]
	mov	rdi, r12
	mov	rdx, r13
	mov	QWORD PTR 40[rsp], rax
	lea	rsi, .LC65[rip]
.LEHB64:
	call	_ZSt11make_uniqueIN9benchmark8internal17FunctionBenchmarkEJRA16_KcPFvRNS0_5StateEEEENSt8__detail9_MakeUniqIT_E15__single_objectEDpOT0_
.LEHE64:
	mov	rax, QWORD PTR 48[rsp]
	mov	rdi, rbx
	mov	QWORD PTR 48[rsp], 0
	mov	QWORD PTR 56[rsp], rax
.LEHB65:
	call	_ZN9benchmark8internal25RegisterBenchmarkInternalESt10unique_ptrINS_9BenchmarkESt14default_deleteIS2_EE@PLT
.LEHE65:
	mov	rdi, QWORD PTR 56[rsp]
	test	rdi, rdi
	je	.L369
	mov	rax, QWORD PTR [rdi]
	call	[QWORD PTR 8[rax]]
.L369:
	lea	rax, _ZL18BM_UltraFast_LargeRN9benchmark5StateE[rip]
	mov	rdi, r12
	mov	rdx, r13
	mov	QWORD PTR 40[rsp], rax
	lea	rsi, .LC66[rip]
.LEHB66:
	call	_ZSt11make_uniqueIN9benchmark8internal17FunctionBenchmarkEJRA19_KcPFvRNS0_5StateEEEENSt8__detail9_MakeUniqIT_E15__single_objectEDpOT0_
.LEHE66:
	mov	rax, QWORD PTR 48[rsp]
	mov	rdi, rbx
	mov	QWORD PTR 48[rsp], 0
	mov	QWORD PTR 56[rsp], rax
.LEHB67:
	call	_ZN9benchmark8internal25RegisterBenchmarkInternalESt10unique_ptrINS_9BenchmarkESt14default_deleteIS2_EE@PLT
.LEHE67:
	mov	rdi, QWORD PTR 56[rsp]
	test	rdi, rdi
	je	.L370
	mov	rax, QWORD PTR [rdi]
	call	[QWORD PTR 8[rax]]
.L370:
	lea	rax, _ZL16BM_AsmCmov_LargeRN9benchmark5StateE[rip]
	mov	rdi, r12
	mov	rdx, r13
	mov	QWORD PTR 40[rsp], rax
	lea	rsi, .LC67[rip]
.LEHB68:
	call	_ZSt11make_uniqueIN9benchmark8internal17FunctionBenchmarkEJRA17_KcPFvRNS0_5StateEEEENSt8__detail9_MakeUniqIT_E15__single_objectEDpOT0_
.LEHE68:
	mov	rax, QWORD PTR 48[rsp]
	mov	rdi, rbx
	mov	QWORD PTR 48[rsp], 0
	mov	QWORD PTR 56[rsp], rax
.LEHB69:
	call	_ZN9benchmark8internal25RegisterBenchmarkInternalESt10unique_ptrINS_9BenchmarkESt14default_deleteIS2_EE@PLT
.LEHE69:
	mov	rdi, QWORD PTR 56[rsp]
	test	rdi, rdi
	je	.L371
	mov	rax, QWORD PTR [rdi]
	call	[QWORD PTR 8[rax]]
.L371:
	lea	rax, _ZL20BM_AsmUnrolled_LargeRN9benchmark5StateE[rip]
	mov	rdi, r12
	mov	rdx, r13
	mov	QWORD PTR 40[rsp], rax
	lea	rsi, .LC68[rip]
.LEHB70:
	call	_ZSt11make_uniqueIN9benchmark8internal17FunctionBenchmarkEJRA21_KcPFvRNS0_5StateEEEENSt8__detail9_MakeUniqIT_E15__single_objectEDpOT0_
.LEHE70:
	mov	rax, QWORD PTR 48[rsp]
	mov	rdi, rbx
	mov	QWORD PTR 48[rsp], 0
	mov	QWORD PTR 56[rsp], rax
.LEHB71:
	call	_ZN9benchmark8internal25RegisterBenchmarkInternalESt10unique_ptrINS_9BenchmarkESt14default_deleteIS2_EE@PLT
.LEHE71:
	mov	rdi, QWORD PTR 56[rsp]
	test	rdi, rdi
	je	.L372
	mov	rax, QWORD PTR [rdi]
	call	[QWORD PTR 8[rax]]
.L372:
	lea	rax, _ZL22BM_CppBranchless_LargeRN9benchmark5StateE[rip]
	mov	rdi, r12
	mov	rdx, r13
	mov	QWORD PTR 40[rsp], rax
	lea	rsi, .LC69[rip]
.LEHB72:
	call	_ZSt11make_uniqueIN9benchmark8internal17FunctionBenchmarkEJRA23_KcPFvRNS0_5StateEEEENSt8__detail9_MakeUniqIT_E15__single_objectEDpOT0_
.LEHE72:
	mov	rax, QWORD PTR 48[rsp]
	mov	rdi, rbx
	mov	QWORD PTR 48[rsp], 0
	mov	QWORD PTR 56[rsp], rax
.LEHB73:
	call	_ZN9benchmark8internal25RegisterBenchmarkInternalESt10unique_ptrINS_9BenchmarkESt14default_deleteIS2_EE@PLT
.LEHE73:
	mov	rdi, QWORD PTR 56[rsp]
	test	rdi, rdi
	je	.L373
	mov	rax, QWORD PTR [rdi]
	call	[QWORD PTR 8[rax]]
.L373:
	lea	rax, _ZL19BM_CppTernary_LargeRN9benchmark5StateE[rip]
	mov	rdi, r12
	mov	rdx, r13
	mov	QWORD PTR 40[rsp], rax
	lea	rsi, .LC70[rip]
.LEHB74:
	call	_ZSt11make_uniqueIN9benchmark8internal17FunctionBenchmarkEJRA20_KcPFvRNS0_5StateEEEENSt8__detail9_MakeUniqIT_E15__single_objectEDpOT0_
.LEHE74:
	mov	rax, QWORD PTR 48[rsp]
	mov	rdi, rbx
	mov	QWORD PTR 48[rsp], 0
	mov	QWORD PTR 56[rsp], rax
.LEHB75:
	call	_ZN9benchmark8internal25RegisterBenchmarkInternalESt10unique_ptrINS_9BenchmarkESt14default_deleteIS2_EE@PLT
.LEHE75:
	mov	rdi, QWORD PTR 56[rsp]
	test	rdi, rdi
	je	.L340
	mov	rax, QWORD PTR [rdi]
	call	[QWORD PTR 8[rax]]
.L340:
	mov	rax, QWORD PTR 536[rsp]
	sub	rax, QWORD PTR fs:40
	jne	.L616
	lea	rsp, -40[rbp]
	pop	rbx
	pop	r12
	pop	r13
	pop	r14
	pop	r15
	pop	rbp
	.cfi_remember_state
	.cfi_def_cfa 7, 8
	ret
.L616:
	.cfi_restore_state
	call	__stack_chk_fail@PLT
.L459:
	endbr64
	mov	rbx, rax
	jmp	.L435
.L458:
	endbr64
	mov	rbx, rax
	jmp	.L432
.L454:
	endbr64
	mov	rbx, rax
	jmp	.L420
.L456:
	endbr64
	mov	rbx, rax
	jmp	.L426
.L452:
	endbr64
	mov	rbx, rax
	jmp	.L414
.L457:
	endbr64
	mov	rbx, rax
	jmp	.L429
.L453:
	endbr64
	mov	rbx, rax
	jmp	.L417
.L455:
	endbr64
	mov	rbx, rax
	jmp	.L423
.L463:
	endbr64
	mov	rbx, rax
	jmp	.L364
.L462:
	endbr64
	mov	rbx, rax
	vzeroupper
	jmp	.L365
.L451:
	endbr64
	mov	rbx, rax
	jmp	.L411
.L450:
	endbr64
	mov	rbx, rax
	jmp	.L408
.L449:
	endbr64
	mov	rbx, rax
	jmp	.L405
.L446:
	endbr64
	mov	rbx, rax
	jmp	.L396
.L445:
	endbr64
	mov	rbx, rax
	jmp	.L393
.L461:
	endbr64
	mov	rbx, rax
	jmp	.L357
.L448:
	endbr64
	mov	rbx, rax
	jmp	.L402
.L442:
	endbr64
	mov	rbx, rax
	jmp	.L384
.L441:
	endbr64
	mov	rbx, rax
	jmp	.L381
.L447:
	endbr64
	mov	rbx, rax
	jmp	.L399
.L460:
	endbr64
	mov	rbx, rax
	jmp	.L351
.L444:
	endbr64
	mov	rbx, rax
	jmp	.L390
.L443:
	endbr64
	mov	rbx, rax
	jmp	.L387
.L440:
	endbr64
	mov	rbx, rax
	jmp	.L378
.L439:
	endbr64
	mov	rbx, rax
	jmp	.L375
	.section	.gcc_except_table
.LLSDA7825:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSE7825-.LLSDACSB7825
.LLSDACSB7825:
	.uleb128 .LEHB30-.LFB7825
	.uleb128 .LEHE30-.LEHB30
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB31-.LFB7825
	.uleb128 .LEHE31-.LEHB31
	.uleb128 .L439-.LFB7825
	.uleb128 0
	.uleb128 .LEHB32-.LFB7825
	.uleb128 .LEHE32-.LEHB32
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB33-.LFB7825
	.uleb128 .LEHE33-.LEHB33
	.uleb128 .L440-.LFB7825
	.uleb128 0
	.uleb128 .LEHB34-.LFB7825
	.uleb128 .LEHE34-.LEHB34
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB35-.LFB7825
	.uleb128 .LEHE35-.LEHB35
	.uleb128 .L441-.LFB7825
	.uleb128 0
	.uleb128 .LEHB36-.LFB7825
	.uleb128 .LEHE36-.LEHB36
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB37-.LFB7825
	.uleb128 .LEHE37-.LEHB37
	.uleb128 .L442-.LFB7825
	.uleb128 0
	.uleb128 .LEHB38-.LFB7825
	.uleb128 .LEHE38-.LEHB38
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB39-.LFB7825
	.uleb128 .LEHE39-.LEHB39
	.uleb128 .L443-.LFB7825
	.uleb128 0
	.uleb128 .LEHB40-.LFB7825
	.uleb128 .LEHE40-.LEHB40
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB41-.LFB7825
	.uleb128 .LEHE41-.LEHB41
	.uleb128 .L444-.LFB7825
	.uleb128 0
	.uleb128 .LEHB42-.LFB7825
	.uleb128 .LEHE42-.LEHB42
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB43-.LFB7825
	.uleb128 .LEHE43-.LEHB43
	.uleb128 .L445-.LFB7825
	.uleb128 0
	.uleb128 .LEHB44-.LFB7825
	.uleb128 .LEHE44-.LEHB44
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB45-.LFB7825
	.uleb128 .LEHE45-.LEHB45
	.uleb128 .L446-.LFB7825
	.uleb128 0
	.uleb128 .LEHB46-.LFB7825
	.uleb128 .LEHE46-.LEHB46
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB47-.LFB7825
	.uleb128 .LEHE47-.LEHB47
	.uleb128 .L460-.LFB7825
	.uleb128 0
	.uleb128 .LEHB48-.LFB7825
	.uleb128 .LEHE48-.LEHB48
	.uleb128 .L447-.LFB7825
	.uleb128 0
	.uleb128 .LEHB49-.LFB7825
	.uleb128 .LEHE49-.LEHB49
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB50-.LFB7825
	.uleb128 .LEHE50-.LEHB50
	.uleb128 .L448-.LFB7825
	.uleb128 0
	.uleb128 .LEHB51-.LFB7825
	.uleb128 .LEHE51-.LEHB51
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB52-.LFB7825
	.uleb128 .LEHE52-.LEHB52
	.uleb128 .L461-.LFB7825
	.uleb128 0
	.uleb128 .LEHB53-.LFB7825
	.uleb128 .LEHE53-.LEHB53
	.uleb128 .L449-.LFB7825
	.uleb128 0
	.uleb128 .LEHB54-.LFB7825
	.uleb128 .LEHE54-.LEHB54
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB55-.LFB7825
	.uleb128 .LEHE55-.LEHB55
	.uleb128 .L450-.LFB7825
	.uleb128 0
	.uleb128 .LEHB56-.LFB7825
	.uleb128 .LEHE56-.LEHB56
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB57-.LFB7825
	.uleb128 .LEHE57-.LEHB57
	.uleb128 .L451-.LFB7825
	.uleb128 0
	.uleb128 .LEHB58-.LFB7825
	.uleb128 .LEHE58-.LEHB58
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB59-.LFB7825
	.uleb128 .LEHE59-.LEHB59
	.uleb128 .L462-.LFB7825
	.uleb128 0
	.uleb128 .LEHB60-.LFB7825
	.uleb128 .LEHE60-.LEHB60
	.uleb128 .L463-.LFB7825
	.uleb128 0
	.uleb128 .LEHB61-.LFB7825
	.uleb128 .LEHE61-.LEHB61
	.uleb128 .L452-.LFB7825
	.uleb128 0
	.uleb128 .LEHB62-.LFB7825
	.uleb128 .LEHE62-.LEHB62
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB63-.LFB7825
	.uleb128 .LEHE63-.LEHB63
	.uleb128 .L453-.LFB7825
	.uleb128 0
	.uleb128 .LEHB64-.LFB7825
	.uleb128 .LEHE64-.LEHB64
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB65-.LFB7825
	.uleb128 .LEHE65-.LEHB65
	.uleb128 .L454-.LFB7825
	.uleb128 0
	.uleb128 .LEHB66-.LFB7825
	.uleb128 .LEHE66-.LEHB66
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB67-.LFB7825
	.uleb128 .LEHE67-.LEHB67
	.uleb128 .L455-.LFB7825
	.uleb128 0
	.uleb128 .LEHB68-.LFB7825
	.uleb128 .LEHE68-.LEHB68
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB69-.LFB7825
	.uleb128 .LEHE69-.LEHB69
	.uleb128 .L456-.LFB7825
	.uleb128 0
	.uleb128 .LEHB70-.LFB7825
	.uleb128 .LEHE70-.LEHB70
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB71-.LFB7825
	.uleb128 .LEHE71-.LEHB71
	.uleb128 .L457-.LFB7825
	.uleb128 0
	.uleb128 .LEHB72-.LFB7825
	.uleb128 .LEHE72-.LEHB72
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB73-.LFB7825
	.uleb128 .LEHE73-.LEHB73
	.uleb128 .L458-.LFB7825
	.uleb128 0
	.uleb128 .LEHB74-.LFB7825
	.uleb128 .LEHE74-.LEHB74
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB75-.LFB7825
	.uleb128 .LEHE75-.LEHB75
	.uleb128 .L459-.LFB7825
	.uleb128 0
.LLSDACSE7825:
	.section	.text.startup
	.cfi_endproc
	.section	.text.unlikely
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gxx_personality_v0
	.cfi_lsda 0x1b,.LLSDAC7825
	.type	_Z41__static_initialization_and_destruction_0v.cold, @function
_Z41__static_initialization_and_destruction_0v.cold:
.LFSB7825:
.L435:
	.cfi_def_cfa 6, 16
	.cfi_offset 3, -56
	.cfi_offset 6, -16
	.cfi_offset 12, -48
	.cfi_offset 13, -40
	.cfi_offset 14, -32
	.cfi_offset 15, -24
	mov	rdi, QWORD PTR 56[rsp]
	test	rdi, rdi
	jne	.L617
	vzeroupper
.L436:
	mov	rax, QWORD PTR 536[rsp]
	sub	rax, QWORD PTR fs:40
	jne	.L618
	mov	rdi, rbx
.LEHB76:
	call	_Unwind_Resume@PLT
.L432:
	mov	rdi, QWORD PTR 56[rsp]
	test	rdi, rdi
	jne	.L619
	vzeroupper
.L433:
	mov	rax, QWORD PTR 536[rsp]
	sub	rax, QWORD PTR fs:40
	jne	.L620
	mov	rdi, rbx
	call	_Unwind_Resume@PLT
.L429:
	mov	rdi, QWORD PTR 56[rsp]
	test	rdi, rdi
	jne	.L621
	vzeroupper
.L430:
	mov	rax, QWORD PTR 536[rsp]
	sub	rax, QWORD PTR fs:40
	jne	.L622
	mov	rdi, rbx
	call	_Unwind_Resume@PLT
.L619:
	mov	rax, QWORD PTR [rdi]
	vzeroupper
	call	[QWORD PTR 8[rax]]
	jmp	.L433
.L620:
	call	__stack_chk_fail@PLT
.L621:
	mov	rax, QWORD PTR [rdi]
	vzeroupper
	call	[QWORD PTR 8[rax]]
	jmp	.L430
.L622:
	call	__stack_chk_fail@PLT
.L420:
	mov	rdi, QWORD PTR 56[rsp]
	test	rdi, rdi
	jne	.L623
	vzeroupper
.L421:
	mov	rax, QWORD PTR 536[rsp]
	sub	rax, QWORD PTR fs:40
	jne	.L624
	mov	rdi, rbx
	call	_Unwind_Resume@PLT
.L417:
	mov	rdi, QWORD PTR 56[rsp]
	test	rdi, rdi
	jne	.L625
	vzeroupper
.L418:
	mov	rax, QWORD PTR 536[rsp]
	sub	rax, QWORD PTR fs:40
	jne	.L626
	mov	rdi, rbx
	call	_Unwind_Resume@PLT
.L623:
	mov	rax, QWORD PTR [rdi]
	vzeroupper
	call	[QWORD PTR 8[rax]]
	jmp	.L421
.L624:
	call	__stack_chk_fail@PLT
.L426:
	mov	rdi, QWORD PTR 56[rsp]
	test	rdi, rdi
	jne	.L627
	vzeroupper
.L427:
	mov	rax, QWORD PTR 536[rsp]
	sub	rax, QWORD PTR fs:40
	jne	.L628
	mov	rdi, rbx
	call	_Unwind_Resume@PLT
.L423:
	mov	rdi, QWORD PTR 56[rsp]
	test	rdi, rdi
	jne	.L629
	vzeroupper
.L424:
	mov	rax, QWORD PTR 536[rsp]
	sub	rax, QWORD PTR fs:40
	jne	.L630
	mov	rdi, rbx
	call	_Unwind_Resume@PLT
.L627:
	mov	rax, QWORD PTR [rdi]
	vzeroupper
	call	[QWORD PTR 8[rax]]
	jmp	.L427
.L628:
	call	__stack_chk_fail@PLT
.L414:
	mov	rdi, QWORD PTR 56[rsp]
	test	rdi, rdi
	jne	.L631
	vzeroupper
.L415:
	mov	rax, QWORD PTR 536[rsp]
	sub	rax, QWORD PTR fs:40
	jne	.L632
	mov	rdi, rbx
	call	_Unwind_Resume@PLT
.L364:
	mov	rdi, r14
	vzeroupper
	call	_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_disposeEv
.L365:
	mov	rdi, QWORD PTR 24[rsp]
	mov	esi, 312
	call	_ZdlPvm@PLT
	mov	rax, QWORD PTR 536[rsp]
	sub	rax, QWORD PTR fs:40
	jne	.L633
	mov	rdi, rbx
	call	_Unwind_Resume@PLT
.L631:
	mov	rax, QWORD PTR [rdi]
	vzeroupper
	call	[QWORD PTR 8[rax]]
	jmp	.L415
.L632:
	call	__stack_chk_fail@PLT
.L617:
	mov	rax, QWORD PTR [rdi]
	vzeroupper
	call	[QWORD PTR 8[rax]]
	jmp	.L436
.L618:
	call	__stack_chk_fail@PLT
.L629:
	mov	rax, QWORD PTR [rdi]
	vzeroupper
	call	[QWORD PTR 8[rax]]
	jmp	.L424
.L630:
	call	__stack_chk_fail@PLT
.L625:
	mov	rax, QWORD PTR [rdi]
	vzeroupper
	call	[QWORD PTR 8[rax]]
	jmp	.L418
.L626:
	call	__stack_chk_fail@PLT
.L633:
	call	__stack_chk_fail@PLT
.L411:
	mov	rdi, QWORD PTR 56[rsp]
	test	rdi, rdi
	jne	.L634
	vzeroupper
.L412:
	mov	rax, QWORD PTR 536[rsp]
	sub	rax, QWORD PTR fs:40
	jne	.L635
	mov	rdi, rbx
	call	_Unwind_Resume@PLT
.L408:
	mov	rdi, QWORD PTR 56[rsp]
	test	rdi, rdi
	jne	.L636
	vzeroupper
.L409:
	mov	rax, QWORD PTR 536[rsp]
	sub	rax, QWORD PTR fs:40
	jne	.L637
	mov	rdi, rbx
	call	_Unwind_Resume@PLT
.L405:
	mov	rdi, QWORD PTR 56[rsp]
	test	rdi, rdi
	jne	.L638
	vzeroupper
.L406:
	mov	rax, QWORD PTR 536[rsp]
	sub	rax, QWORD PTR fs:40
	jne	.L639
	mov	rdi, rbx
	call	_Unwind_Resume@PLT
.L636:
	mov	rax, QWORD PTR [rdi]
	vzeroupper
	call	[QWORD PTR 8[rax]]
	jmp	.L409
.L637:
	call	__stack_chk_fail@PLT
.L396:
	mov	rdi, QWORD PTR 56[rsp]
	test	rdi, rdi
	jne	.L640
	vzeroupper
.L397:
	mov	rax, QWORD PTR 536[rsp]
	sub	rax, QWORD PTR fs:40
	jne	.L641
	mov	rdi, rbx
	call	_Unwind_Resume@PLT
.L393:
	mov	rdi, QWORD PTR 56[rsp]
	test	rdi, rdi
	jne	.L642
	vzeroupper
.L394:
	mov	rax, QWORD PTR 536[rsp]
	sub	rax, QWORD PTR fs:40
	jne	.L643
	mov	rdi, rbx
	call	_Unwind_Resume@PLT
.L640:
	mov	rax, QWORD PTR [rdi]
	vzeroupper
	call	[QWORD PTR 8[rax]]
	jmp	.L397
.L641:
	call	__stack_chk_fail@PLT
.L357:
	mov	rdi, r14
	vzeroupper
	call	_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_disposeEv
	mov	rdi, QWORD PTR 24[rsp]
	mov	esi, 312
	call	_ZdlPvm@PLT
	mov	rax, QWORD PTR 536[rsp]
	sub	rax, QWORD PTR fs:40
	jne	.L644
	mov	rdi, rbx
	call	_Unwind_Resume@PLT
.L402:
	mov	rdi, QWORD PTR 56[rsp]
	test	rdi, rdi
	jne	.L645
	vzeroupper
.L403:
	mov	rax, QWORD PTR 536[rsp]
	sub	rax, QWORD PTR fs:40
	jne	.L646
	mov	rdi, rbx
	call	_Unwind_Resume@PLT
.L644:
	call	__stack_chk_fail@PLT
.L384:
	mov	rdi, QWORD PTR 56[rsp]
	test	rdi, rdi
	jne	.L647
	vzeroupper
.L385:
	mov	rax, QWORD PTR 536[rsp]
	sub	rax, QWORD PTR fs:40
	jne	.L648
	mov	rdi, rbx
	call	_Unwind_Resume@PLT
.L381:
	mov	rdi, QWORD PTR 56[rsp]
	test	rdi, rdi
	jne	.L649
	vzeroupper
.L382:
	mov	rax, QWORD PTR 536[rsp]
	sub	rax, QWORD PTR fs:40
	jne	.L650
	mov	rdi, rbx
	call	_Unwind_Resume@PLT
.L647:
	mov	rax, QWORD PTR [rdi]
	vzeroupper
	call	[QWORD PTR 8[rax]]
	jmp	.L385
.L648:
	call	__stack_chk_fail@PLT
.L634:
	mov	rax, QWORD PTR [rdi]
	vzeroupper
	call	[QWORD PTR 8[rax]]
	jmp	.L412
.L635:
	call	__stack_chk_fail@PLT
.L638:
	mov	rax, QWORD PTR [rdi]
	vzeroupper
	call	[QWORD PTR 8[rax]]
	jmp	.L406
.L639:
	call	__stack_chk_fail@PLT
.L399:
	mov	rdi, QWORD PTR 56[rsp]
	test	rdi, rdi
	jne	.L651
	vzeroupper
.L400:
	mov	rax, QWORD PTR 536[rsp]
	sub	rax, QWORD PTR fs:40
	jne	.L652
	mov	rdi, rbx
	call	_Unwind_Resume@PLT
.L351:
	mov	rdi, r14
	vzeroupper
	call	_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_disposeEv
	mov	rdi, QWORD PTR 24[rsp]
	mov	esi, 312
	call	_ZdlPvm@PLT
	mov	rax, QWORD PTR 536[rsp]
	sub	rax, QWORD PTR fs:40
	jne	.L653
	mov	rdi, rbx
	call	_Unwind_Resume@PLT
.L651:
	mov	rax, QWORD PTR [rdi]
	vzeroupper
	call	[QWORD PTR 8[rax]]
	jmp	.L400
.L652:
	call	__stack_chk_fail@PLT
.L645:
	mov	rax, QWORD PTR [rdi]
	vzeroupper
	call	[QWORD PTR 8[rax]]
	jmp	.L403
.L646:
	call	__stack_chk_fail@PLT
.L653:
	call	__stack_chk_fail@PLT
.L390:
	mov	rdi, QWORD PTR 56[rsp]
	test	rdi, rdi
	jne	.L654
	vzeroupper
.L391:
	mov	rax, QWORD PTR 536[rsp]
	sub	rax, QWORD PTR fs:40
	jne	.L655
	mov	rdi, rbx
	call	_Unwind_Resume@PLT
.L387:
	mov	rdi, QWORD PTR 56[rsp]
	test	rdi, rdi
	jne	.L656
	vzeroupper
.L388:
	mov	rax, QWORD PTR 536[rsp]
	sub	rax, QWORD PTR fs:40
	jne	.L657
	mov	rdi, rbx
	call	_Unwind_Resume@PLT
.L654:
	mov	rax, QWORD PTR [rdi]
	vzeroupper
	call	[QWORD PTR 8[rax]]
	jmp	.L391
.L655:
	call	__stack_chk_fail@PLT
.L378:
	mov	rdi, QWORD PTR 56[rsp]
	test	rdi, rdi
	jne	.L658
	vzeroupper
.L379:
	mov	rax, QWORD PTR 536[rsp]
	sub	rax, QWORD PTR fs:40
	jne	.L659
	mov	rdi, rbx
	call	_Unwind_Resume@PLT
.L375:
	mov	rdi, QWORD PTR 56[rsp]
	test	rdi, rdi
	jne	.L660
	vzeroupper
.L376:
	mov	rax, QWORD PTR 536[rsp]
	sub	rax, QWORD PTR fs:40
	jne	.L661
	mov	rdi, rbx
	call	_Unwind_Resume@PLT
.LEHE76:
.L658:
	mov	rax, QWORD PTR [rdi]
	vzeroupper
	call	[QWORD PTR 8[rax]]
	jmp	.L379
.L659:
	call	__stack_chk_fail@PLT
.L642:
	mov	rax, QWORD PTR [rdi]
	vzeroupper
	call	[QWORD PTR 8[rax]]
	jmp	.L394
.L643:
	call	__stack_chk_fail@PLT
.L656:
	mov	rax, QWORD PTR [rdi]
	vzeroupper
	call	[QWORD PTR 8[rax]]
	jmp	.L388
.L657:
	call	__stack_chk_fail@PLT
.L649:
	mov	rax, QWORD PTR [rdi]
	vzeroupper
	call	[QWORD PTR 8[rax]]
	jmp	.L382
.L650:
	call	__stack_chk_fail@PLT
.L660:
	mov	rax, QWORD PTR [rdi]
	vzeroupper
	call	[QWORD PTR 8[rax]]
	jmp	.L376
.L661:
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE7825:
	.section	.gcc_except_table
.LLSDAC7825:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSEC7825-.LLSDACSBC7825
.LLSDACSBC7825:
	.uleb128 .LEHB76-.LCOLDB72
	.uleb128 .LEHE76-.LEHB76
	.uleb128 0
	.uleb128 0
.LLSDACSEC7825:
	.section	.text.unlikely
	.section	.text.startup
	.size	_Z41__static_initialization_and_destruction_0v, .-_Z41__static_initialization_and_destruction_0v
	.section	.text.unlikely
	.size	_Z41__static_initialization_and_destruction_0v.cold, .-_Z41__static_initialization_and_destruction_0v.cold
.LCOLDE72:
	.section	.text.startup
.LHOTE72:
	.section	.text._ZNSt8_Rb_treeINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESt4pairIKS5_N9benchmark7CounterEESt10_Select1stISA_ESt4lessIS5_ESaISA_EE24_M_get_insert_unique_posERS7_,"axG",@progbits,_ZNSt8_Rb_treeINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESt4pairIKS5_N9benchmark7CounterEESt10_Select1stISA_ESt4lessIS5_ESaISA_EE24_M_get_insert_unique_posERS7_,comdat
	.align 2
	.p2align 4
	.weak	_ZNSt8_Rb_treeINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESt4pairIKS5_N9benchmark7CounterEESt10_Select1stISA_ESt4lessIS5_ESaISA_EE24_M_get_insert_unique_posERS7_
	.type	_ZNSt8_Rb_treeINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESt4pairIKS5_N9benchmark7CounterEESt10_Select1stISA_ESt4lessIS5_ESaISA_EE24_M_get_insert_unique_posERS7_, @function
_ZNSt8_Rb_treeINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESt4pairIKS5_N9benchmark7CounterEESt10_Select1stISA_ESt4lessIS5_ESaISA_EE24_M_get_insert_unique_posERS7_:
.LFB7550:
	.cfi_startproc
	endbr64
	push	r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	push	r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	push	r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	push	r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	push	rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	push	rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	sub	rsp, 40
	.cfi_def_cfa_offset 96
	mov	r15, QWORD PTR 16[rdi]
	mov	QWORD PTR 24[rsp], rdi
	mov	QWORD PTR 16[rsp], rsi
	test	r15, r15
	je	.L689
	mov	rdx, QWORD PTR [rsi]
	mov	r14, QWORD PTR 8[rsi]
	mov	ebp, 2147483648
	mov	QWORD PTR 8[rsp], rdx
	jmp	.L670
	.p2align 4,,10
	.p2align 3
.L668:
	mov	rax, QWORD PTR 16[r15]
	mov	esi, 1
	test	rax, rax
	je	.L690
.L675:
	mov	r15, rax
.L670:
	mov	r12, QWORD PTR 40[r15]
	mov	r13, QWORD PTR 32[r15]
	cmp	r14, r12
	mov	rbx, r12
	cmovbe	rbx, r14
	test	rbx, rbx
	je	.L665
	mov	rdi, QWORD PTR 8[rsp]
	mov	rdx, rbx
	mov	rsi, r13
	call	memcmp@PLT
	test	eax, eax
	jne	.L666
.L665:
	mov	rax, r14
	sub	rax, r12
	cmp	rax, rbp
	jge	.L667
	movabs	rcx, -2147483649
	cmp	rax, rcx
	jle	.L668
.L666:
	test	eax, eax
	js	.L668
.L667:
	mov	rax, QWORD PTR 24[r15]
	xor	esi, esi
	test	rax, rax
	jne	.L675
.L690:
	mov	rbp, r15
	test	sil, sil
	jne	.L664
.L671:
	test	rbx, rbx
	je	.L673
	mov	rsi, QWORD PTR 8[rsp]
	mov	rdx, rbx
	mov	rdi, r13
	call	memcmp@PLT
	test	eax, eax
	je	.L673
.L674:
	xor	edx, edx
	test	eax, eax
	cmovns	rbp, rdx
	cmovs	r15, rdx
.L672:
	add	rsp, 40
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	mov	rax, r15
	pop	rbx
	.cfi_def_cfa_offset 48
	mov	rdx, rbp
	pop	rbp
	.cfi_def_cfa_offset 40
	pop	r12
	.cfi_def_cfa_offset 32
	pop	r13
	.cfi_def_cfa_offset 24
	pop	r14
	.cfi_def_cfa_offset 16
	pop	r15
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L673:
	.cfi_restore_state
	mov	rcx, r12
	sub	rcx, r14
	cmp	rcx, 2147483647
	jg	.L678
	cmp	rcx, -2147483648
	jl	.L679
	mov	eax, ecx
	jmp	.L674
	.p2align 4,,10
	.p2align 3
.L689:
	lea	r15, 8[rdi]
.L664:
	mov	rax, QWORD PTR 24[rsp]
	cmp	QWORD PTR 24[rax], r15
	je	.L677
	mov	rdi, r15
	mov	rbp, r15
	call	_ZSt18_Rb_tree_decrementPSt18_Rb_tree_node_base@PLT
	mov	rdx, QWORD PTR 16[rsp]
	mov	r12, QWORD PTR 40[rax]
	mov	r13, QWORD PTR 32[rax]
	mov	r15, rax
	mov	r14, QWORD PTR 8[rdx]
	mov	rcx, QWORD PTR [rdx]
	mov	rbx, r12
	cmp	r14, r12
	mov	QWORD PTR 8[rsp], rcx
	cmovbe	rbx, r14
	jmp	.L671
	.p2align 4,,10
	.p2align 3
.L677:
	mov	rbp, r15
	xor	r15d, r15d
	jmp	.L672
	.p2align 4,,10
	.p2align 3
.L678:
	xor	ebp, ebp
	jmp	.L672
.L679:
	xor	r15d, r15d
	jmp	.L672
	.cfi_endproc
.LFE7550:
	.size	_ZNSt8_Rb_treeINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESt4pairIKS5_N9benchmark7CounterEESt10_Select1stISA_ESt4lessIS5_ESaISA_EE24_M_get_insert_unique_posERS7_, .-_ZNSt8_Rb_treeINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESt4pairIKS5_N9benchmark7CounterEESt10_Select1stISA_ESt4lessIS5_ESaISA_EE24_M_get_insert_unique_posERS7_
	.section	.text._ZNSt8_Rb_treeINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESt4pairIKS5_N9benchmark7CounterEESt10_Select1stISA_ESt4lessIS5_ESaISA_EE22_M_emplace_hint_uniqueIJRKSt21piecewise_construct_tSt5tupleIJOS5_EESL_IJEEEEESt17_Rb_tree_iteratorISA_ESt23_Rb_tree_const_iteratorISA_EDpOT_,"axG",@progbits,_ZNSt8_Rb_treeINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESt4pairIKS5_N9benchmark7CounterEESt10_Select1stISA_ESt4lessIS5_ESaISA_EE22_M_emplace_hint_uniqueIJRKSt21piecewise_construct_tSt5tupleIJOS5_EESL_IJEEEEESt17_Rb_tree_iteratorISA_ESt23_Rb_tree_const_iteratorISA_EDpOT_,comdat
	.align 2
	.p2align 4
	.weak	_ZNSt8_Rb_treeINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESt4pairIKS5_N9benchmark7CounterEESt10_Select1stISA_ESt4lessIS5_ESaISA_EE22_M_emplace_hint_uniqueIJRKSt21piecewise_construct_tSt5tupleIJOS5_EESL_IJEEEEESt17_Rb_tree_iteratorISA_ESt23_Rb_tree_const_iteratorISA_EDpOT_
	.type	_ZNSt8_Rb_treeINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESt4pairIKS5_N9benchmark7CounterEESt10_Select1stISA_ESt4lessIS5_ESaISA_EE22_M_emplace_hint_uniqueIJRKSt21piecewise_construct_tSt5tupleIJOS5_EESL_IJEEEEESt17_Rb_tree_iteratorISA_ESt23_Rb_tree_const_iteratorISA_EDpOT_, @function
_ZNSt8_Rb_treeINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESt4pairIKS5_N9benchmark7CounterEESt10_Select1stISA_ESt4lessIS5_ESaISA_EE22_M_emplace_hint_uniqueIJRKSt21piecewise_construct_tSt5tupleIJOS5_EESL_IJEEEEESt17_Rb_tree_iteratorISA_ESt23_Rb_tree_const_iteratorISA_EDpOT_:
.LFB7105:
	.cfi_startproc
	endbr64
	push	r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	push	r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	push	r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	mov	r13, rcx
	push	r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	mov	r12, rdi
	mov	edi, 80
	push	rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	mov	rbp, rsi
	push	rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	sub	rsp, 72
	.cfi_def_cfa_offset 128
	call	_Znwm@PLT
	mov	rbx, rax
	mov	rax, QWORD PTR 0[r13]
	lea	r13, 48[rbx]
	mov	QWORD PTR 32[rbx], r13
	mov	rcx, QWORD PTR [rax]
	lea	rdx, 16[rax]
	cmp	rcx, rdx
	je	.L769
	mov	QWORD PTR 32[rbx], rcx
	mov	rcx, QWORD PTR 16[rax]
	mov	QWORD PTR 48[rbx], rcx
.L766:
	mov	rcx, QWORD PTR 8[rax]
.L699:
	mov	QWORD PTR [rax], rdx
	mov	QWORD PTR 8[rax], 0
	mov	QWORD PTR 40[rbx], rcx
	mov	rcx, rbp
	mov	BYTE PTR 16[rax], 0
	movabs	rax, 4294967296000
	mov	QWORD PTR 72[rbx], rax
	lea	rax, 32[rbx]
	mov	QWORD PTR 16[rsp], rax
	lea	rax, 8[r12]
	mov	QWORD PTR 64[rbx], 0x000000000
	mov	QWORD PTR 8[rsp], rax
	cmp	rax, rbp
	je	.L770
	mov	r14, QWORD PTR 40[rbx]
	mov	r15, QWORD PTR 40[rbp]
	mov	rdi, QWORD PTR 32[rbx]
	mov	rsi, QWORD PTR 32[rbp]
	cmp	r14, r15
	mov	r11, r15
	cmovbe	r11, r14
	mov	QWORD PTR 24[rsp], rdi
	mov	QWORD PTR 32[rsp], rsi
	test	r11, r11
	je	.L707
	mov	rdx, r11
	mov	QWORD PTR 40[rsp], r11
	mov	QWORD PTR 48[rsp], rbp
	call	memcmp@PLT
	mov	r11, QWORD PTR 40[rsp]
	mov	rcx, QWORD PTR 48[rsp]
	test	eax, eax
	jne	.L768
	mov	rax, r14
	sub	rax, r15
	cmp	rax, 2147483647
	jg	.L712
	cmp	rax, -2147483648
	jl	.L710
	test	eax, eax
.L768:
	js	.L710
.L712:
	mov	rsi, QWORD PTR 24[rsp]
	mov	rdi, QWORD PTR 32[rsp]
	mov	rdx, r11
	mov	QWORD PTR 48[rsp], rcx
	mov	QWORD PTR 40[rsp], r11
	call	memcmp@PLT
	mov	r11, QWORD PTR 40[rsp]
	mov	rcx, QWORD PTR 48[rsp]
	test	eax, eax
	jne	.L718
.L711:
	mov	rax, r15
	sub	rax, r14
	cmp	rax, 2147483647
	jg	.L719
	cmp	rax, -2147483648
	jl	.L720
.L718:
	test	eax, eax
	js	.L720
.L719:
	mov	rdi, QWORD PTR 32[rbx]
	mov	rbp, rcx
	cmp	r13, rdi
	je	.L730
	mov	rax, QWORD PTR 48[rbx]
	lea	rsi, 1[rax]
	call	_ZdlPvm@PLT
.L730:
	mov	esi, 80
	mov	rdi, rbx
	call	_ZdlPvm@PLT
.L762:
	add	rsp, 72
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	mov	rax, rbp
	pop	rbx
	.cfi_def_cfa_offset 48
	pop	rbp
	.cfi_def_cfa_offset 40
	pop	r12
	.cfi_def_cfa_offset 32
	pop	r13
	.cfi_def_cfa_offset 24
	pop	r14
	.cfi_def_cfa_offset 16
	pop	r15
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L707:
	.cfi_restore_state
	mov	rax, r14
	sub	rax, r15
	cmp	rax, 2147483647
	jg	.L711
	cmp	rax, -2147483648
	jl	.L710
	test	eax, eax
	jns	.L711
.L710:
	cmp	QWORD PTR 24[r12], rbp
	je	.L736
	mov	rdi, rbp
	call	_ZSt18_Rb_tree_decrementPSt18_Rb_tree_node_base@PLT
	mov	r15, QWORD PTR 40[rax]
	mov	rdi, QWORD PTR 32[rax]
	mov	r8, rax
	cmp	r14, r15
	mov	rdx, r15
	cmovbe	rdx, r14
	test	rdx, rdx
	je	.L714
	mov	rsi, QWORD PTR 24[rsp]
	mov	QWORD PTR 32[rsp], rax
	call	memcmp@PLT
	mov	r8, QWORD PTR 32[rsp]
	test	eax, eax
	jne	.L715
.L714:
	mov	rcx, r15
	sub	rcx, r14
	cmp	rcx, 2147483647
	jg	.L724
	cmp	rcx, -2147483648
	jl	.L717
	mov	eax, ecx
.L715:
	test	eax, eax
	jns	.L724
.L717:
	cmp	QWORD PTR 24[r8], 0
	je	.L737
.L736:
	mov	r8, rbp
	mov	edi, 1
	jmp	.L713
	.p2align 4,,10
	.p2align 3
.L770:
	cmp	QWORD PTR 40[r12], 0
	jne	.L771
.L724:
	mov	rsi, QWORD PTR 16[rsp]
	mov	rdi, r12
	call	_ZNSt8_Rb_treeINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESt4pairIKS5_N9benchmark7CounterEESt10_Select1stISA_ESt4lessIS5_ESaISA_EE24_M_get_insert_unique_posERS7_
	mov	rcx, rax
	mov	r8, rdx
.L706:
	test	r8, r8
	je	.L719
.L721:
	test	rcx, rcx
	setne	al
.L703:
	cmp	QWORD PTR 8[rsp], r8
	je	.L742
	test	al, al
	je	.L772
.L742:
	mov	edi, 1
.L713:
	mov	rcx, QWORD PTR 8[rsp]
	mov	rdx, r8
	mov	rsi, rbx
	mov	rbp, rbx
	call	_ZSt29_Rb_tree_insert_and_rebalancebPSt18_Rb_tree_node_baseS0_RS_@PLT
	add	QWORD PTR 40[r12], 1
	jmp	.L762
	.p2align 4,,10
	.p2align 3
.L720:
	mov	QWORD PTR 40[rsp], r11
	cmp	QWORD PTR 32[r12], rbp
	je	.L738
	mov	rdi, rbp
	call	_ZSt18_Rb_tree_incrementPSt18_Rb_tree_node_base@PLT
	mov	r11, QWORD PTR 40[rsp]
	mov	rcx, QWORD PTR 40[rax]
	mov	rsi, QWORD PTR 32[rax]
	mov	r8, rax
	cmp	r14, rcx
	mov	rdx, rcx
	cmovbe	rdx, r14
	test	rdx, rdx
	je	.L722
	mov	rdi, QWORD PTR 24[rsp]
	mov	QWORD PTR 48[rsp], r11
	mov	QWORD PTR 40[rsp], rcx
	mov	QWORD PTR 56[rsp], rax
	call	memcmp@PLT
	mov	rcx, QWORD PTR 40[rsp]
	mov	r11, QWORD PTR 48[rsp]
	test	eax, eax
	mov	r8, QWORD PTR 56[rsp]
	jne	.L723
.L722:
	mov	rax, r14
	sub	rax, rcx
	cmp	rax, 2147483647
	jg	.L724
	cmp	rax, -2147483648
	jl	.L725
.L723:
	test	eax, eax
	jns	.L724
.L725:
	cmp	QWORD PTR 24[rbp], 0
	mov	rcx, r8
	jne	.L706
	mov	r8, rbp
	jmp	.L726
	.p2align 4,,10
	.p2align 3
.L771:
	mov	r8, QWORD PTR 32[r12]
	mov	r15, QWORD PTR 40[rbx]
	mov	rsi, QWORD PTR 32[rbx]
	mov	rbp, QWORD PTR 40[r8]
	mov	rdx, r15
	mov	rdi, QWORD PTR 32[r8]
	cmp	rbp, r15
	cmovbe	rdx, rbp
	test	rdx, rdx
	je	.L773
	mov	QWORD PTR 24[rsp], r8
	call	memcmp@PLT
	mov	r8, QWORD PTR 24[rsp]
	test	eax, eax
	jne	.L705
	sub	rbp, r15
	cmp	rbp, 2147483647
	jg	.L724
	cmp	rbp, -2147483648
	jl	.L734
.L704:
	mov	eax, ebp
.L705:
	xor	ecx, ecx
	test	eax, eax
	jns	.L724
	jmp	.L706
	.p2align 4,,10
	.p2align 3
.L772:
	mov	rax, QWORD PTR 32[rbx]
	mov	r14, QWORD PTR 40[rbx]
	mov	r15, QWORD PTR 40[r8]
	mov	QWORD PTR 24[rsp], rax
	mov	rax, QWORD PTR 32[r8]
	cmp	r14, r15
	mov	r11, r15
	mov	QWORD PTR 32[rsp], rax
	cmovbe	r11, r14
.L726:
	test	r11, r11
	je	.L727
	mov	rdi, QWORD PTR 24[rsp]
	mov	rsi, QWORD PTR 32[rsp]
	mov	rdx, r11
	mov	QWORD PTR 16[rsp], r8
	call	memcmp@PLT
	mov	r8, QWORD PTR 16[rsp]
	test	eax, eax
	mov	edi, eax
	jne	.L728
.L727:
	mov	r9, r14
	xor	edi, edi
	sub	r9, r15
	cmp	r9, 2147483647
	jg	.L713
	cmp	r9, -2147483648
	jl	.L742
	mov	edi, r9d
.L728:
	shr	edi, 31
	jmp	.L713
	.p2align 4,,10
	.p2align 3
.L769:
	mov	rcx, QWORD PTR 8[rax]
	lea	rsi, 1[rcx]
	cmp	esi, 8
	jnb	.L693
	test	sil, 4
	jne	.L774
	test	esi, esi
	je	.L699
	movzx	ecx, BYTE PTR 16[rax]
	mov	BYTE PTR 48[rbx], cl
	test	sil, 2
	je	.L766
	mov	esi, esi
	movzx	ecx, WORD PTR -2[rdx+rsi]
	mov	WORD PTR -2[r13+rsi], cx
	mov	rcx, QWORD PTR 8[rax]
	jmp	.L699
	.p2align 4,,10
	.p2align 3
.L693:
	mov	rcx, QWORD PTR 16[rax]
	lea	r8, 56[rbx]
	mov	r10, rdx
	and	r8, -8
	mov	QWORD PTR 48[rbx], rcx
	mov	ecx, esi
	mov	rdi, QWORD PTR -8[rdx+rcx]
	mov	QWORD PTR -8[r13+rcx], rdi
	mov	rcx, r13
	sub	rcx, r8
	add	esi, ecx
	sub	r10, rcx
	and	esi, -8
	cmp	esi, 8
	jb	.L766
	and	esi, -8
	xor	ecx, ecx
.L697:
	mov	edi, ecx
	add	ecx, 8
	mov	r9, QWORD PTR [r10+rdi]
	mov	QWORD PTR [r8+rdi], r9
	cmp	ecx, esi
	jb	.L697
	jmp	.L766
.L734:
	xor	ecx, ecx
	jmp	.L706
	.p2align 4,,10
	.p2align 3
.L773:
	sub	rbp, r15
	cmp	rbp, 2147483647
	jg	.L724
	cmp	rbp, -2147483648
	jge	.L704
	.p2align 4,,10
	.p2align 3
.L737:
	xor	eax, eax
	jmp	.L703
	.p2align 4,,10
	.p2align 3
.L738:
	mov	r8, rbp
	xor	ecx, ecx
	jmp	.L721
.L774:
	mov	ecx, DWORD PTR 16[rax]
	mov	esi, esi
	mov	DWORD PTR 48[rbx], ecx
	mov	ecx, DWORD PTR -4[rdx+rsi]
	mov	DWORD PTR -4[r13+rsi], ecx
	mov	rcx, QWORD PTR 8[rax]
	jmp	.L699
	.cfi_endproc
.LFE7105:
	.size	_ZNSt8_Rb_treeINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESt4pairIKS5_N9benchmark7CounterEESt10_Select1stISA_ESt4lessIS5_ESaISA_EE22_M_emplace_hint_uniqueIJRKSt21piecewise_construct_tSt5tupleIJOS5_EESL_IJEEEEESt17_Rb_tree_iteratorISA_ESt23_Rb_tree_const_iteratorISA_EDpOT_, .-_ZNSt8_Rb_treeINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESt4pairIKS5_N9benchmark7CounterEESt10_Select1stISA_ESt4lessIS5_ESaISA_EE22_M_emplace_hint_uniqueIJRKSt21piecewise_construct_tSt5tupleIJOS5_EESL_IJEEEEESt17_Rb_tree_iteratorISA_ESt23_Rb_tree_const_iteratorISA_EDpOT_
	.section	.rodata.str1.8
	.align 8
.LC74:
	.string	"benchmark::State::StateIterator& benchmark::State::StateIterator::operator++()"
	.align 8
.LC75:
	.string	"/home/sbstndbs/.local/include/benchmark/state.h"
	.section	.rodata.str1.1
.LC76:
	.string	"cached_ > 0"
	.section	.text.unlikely
.LCOLDB78:
	.text
.LHOTB78:
	.p2align 4
	.type	_Z6BM_PowIXadL_ZL15pow_cpp_ternarymmEEEvRN9benchmark5StateERKSt6vectorISt4pairImmESaIS5_EE, @function
_Z6BM_PowIXadL_ZL15pow_cpp_ternarymmEEEvRN9benchmark5StateERKSt6vectorISt4pairImmESaIS5_EE:
.LFB6922:
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gxx_personality_v0
	.cfi_lsda 0x1b,.LLSDA6922
	push	r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	push	r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	push	r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	push	r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	push	rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	mov	rbp, rdi
	push	rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	mov	rbx, rsi
	sub	rsp, 88
	.cfi_def_cfa_offset 144
	mov	rax, QWORD PTR fs:40
	mov	QWORD PTR 72[rsp], rax
	xor	eax, eax
	mov	eax, DWORD PTR 28[rdi]
	test	eax, eax
	je	.L776
.LEHB77:
	call	_ZN9benchmark5State16StartKeepRunningEv@PLT
.L777:
	mov	rdi, rbp
	call	_ZN9benchmark5State17FinishKeepRunningEv@PLT
	cmp	BYTE PTR 24[rbp], 0
	je	.L804
	mov	rdx, QWORD PTR 16[rbp]
	sub	rdx, QWORD PTR 0[rbp]
	add	rdx, QWORD PTR 8[rbp]
.L783:
	mov	rax, QWORD PTR 8[rbx]
	sub	rax, QWORD PTR [rbx]
	vxorps	xmm0, xmm0, xmm0
	lea	r14, 48[rsp]
	sar	rax, 4
	mov	edi, 17
	mov	QWORD PTR 32[rsp], r14
	imul	rax, rdx
	vcvtsi2sd	xmm0, xmm0, rax
	vmovsd	QWORD PTR 8[rsp], xmm0
	call	_Znwm@PLT
.LEHE77:
	vmovdqa	xmm0, XMMWORD PTR .LC77[rip]
	mov	r15, QWORD PTR 80[rbp]
	mov	QWORD PTR 48[rsp], 16
	mov	QWORD PTR 32[rsp], rax
	mov	rbx, rax
	mov	BYTE PTR 16[rax], 0
	vmovdqu	XMMWORD PTR [rax], xmm0
	lea	rax, 72[rbp]
	mov	QWORD PTR 40[rsp], 16
	mov	r12, rax
	mov	QWORD PTR [rsp], rax
	test	r15, r15
	jne	.L791
	jmp	.L784
	.p2align 4,,10
	.p2align 3
.L831:
	test	r13, r13
	jne	.L829
.L786:
	mov	r15, QWORD PTR 24[r15]
	test	r15, r15
	je	.L830
.L791:
	mov	r13, QWORD PTR 40[r15]
	mov	rdi, QWORD PTR 32[r15]
	cmp	r13, 16
	jbe	.L831
	mov	edx, 16
	mov	rsi, rbx
	call	memcmp@PLT
	test	eax, eax
	jne	.L788
	lea	rax, -16[r13]
	cmp	rax, 2147483647
	jg	.L789
	cmp	rax, -2147483648
	jl	.L786
	.p2align 4,,10
	.p2align 3
.L788:
	test	eax, eax
	js	.L786
.L789:
	mov	r12, r15
	mov	r15, QWORD PTR 16[r15]
	test	r15, r15
	jne	.L791
.L830:
	cmp	QWORD PTR [rsp], r12
	je	.L784
	mov	r13, QWORD PTR 40[r12]
	mov	rsi, QWORD PTR 32[r12]
	cmp	r13, 15
	jbe	.L832
	mov	edx, 16
	mov	rdi, rbx
	call	memcmp@PLT
	test	eax, eax
	je	.L833
.L795:
	test	eax, eax
	jns	.L793
.L784:
	lea	rbx, 32[rsp]
	lea	rcx, 24[rsp]
	mov	rsi, r12
	lea	rdi, 64[rbp]
	lea	r8, 23[rsp]
	mov	QWORD PTR 24[rsp], rbx
	lea	rdx, _ZSt19piecewise_construct[rip]
.LEHB78:
	call	_ZNSt8_Rb_treeINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESt4pairIKS5_N9benchmark7CounterEESt10_Select1stISA_ESt4lessIS5_ESaISA_EE22_M_emplace_hint_uniqueIJRKSt21piecewise_construct_tSt5tupleIJOS5_EESL_IJEEEEESt17_Rb_tree_iteratorISA_ESt23_Rb_tree_const_iteratorISA_EDpOT_
.LEHE78:
	vmovsd	xmm1, QWORD PTR 8[rsp]
	mov	rbx, QWORD PTR 32[rsp]
	movabs	rcx, 4294967296001
	mov	QWORD PTR 72[rax], rcx
	vmovsd	QWORD PTR 64[rax], xmm1
	cmp	rbx, r14
	je	.L775
.L801:
	mov	rax, QWORD PTR 48[rsp]
	mov	rdi, rbx
	lea	rsi, 1[rax]
	call	_ZdlPvm@PLT
.L775:
	mov	rax, QWORD PTR 72[rsp]
	sub	rax, QWORD PTR fs:40
	jne	.L834
	add	rsp, 88
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	pop	rbx
	.cfi_def_cfa_offset 48
	pop	rbp
	.cfi_def_cfa_offset 40
	pop	r12
	.cfi_def_cfa_offset 32
	pop	r13
	.cfi_def_cfa_offset 24
	pop	r14
	.cfi_def_cfa_offset 16
	pop	r15
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L829:
	.cfi_restore_state
	mov	rdx, r13
	mov	rsi, rbx
	call	memcmp@PLT
	test	eax, eax
	jne	.L788
	lea	rax, -16[r13]
	test	eax, eax
	jns	.L789
	jmp	.L786
.L776:
	mov	r12, QWORD PTR 16[rdi]
.LEHB79:
	call	_ZN9benchmark5State16StartKeepRunningEv@PLT
.LEHE79:
	test	r12, r12
	je	.L777
	mov	rdx, QWORD PTR [rbx]
	mov	r8, QWORD PTR 8[rbx]
	cmp	r8, rdx
	je	.L803
	.p2align 4,,10
	.p2align 3
.L782:
	xor	ecx, ecx
	.p2align 4,,10
	.p2align 3
.L780:
	mov	rsi, QWORD PTR 8[rdx]
	mov	rdi, QWORD PTR [rdx]
	add	rdx, 16
	call	_ZL15pow_cpp_ternarymm
	add	rcx, rax
	cmp	rdx, r8
	jne	.L780
.L779:
	test	r12, r12
	jle	.L835
.L781:
	sub	r12, 1
	je	.L777
	mov	rdx, QWORD PTR [rbx]
	mov	r8, QWORD PTR 8[rbx]
	cmp	r8, rdx
	jne	.L782
	xor	eax, eax
	jmp	.L781
.L833:
	mov	eax, 16
	sub	rax, r13
	cmp	rax, 2147483647
	jg	.L793
	cmp	rax, -2147483648
	jl	.L784
	test	eax, eax
	js	.L784
.L793:
	movabs	rax, 4294967296001
	vmovsd	xmm2, QWORD PTR 8[rsp]
	mov	QWORD PTR 72[r12], rax
	vmovsd	QWORD PTR 64[r12], xmm2
	jmp	.L801
.L832:
	test	r13, r13
	je	.L793
	mov	rdx, r13
	mov	rdi, rbx
	call	memcmp@PLT
	test	eax, eax
	je	.L793
	jmp	.L795
.L803:
	xor	ecx, ecx
	jmp	.L779
.L804:
	xor	edx, edx
	jmp	.L783
.L834:
	call	__stack_chk_fail@PLT
.L835:
	lea	rcx, .LC74[rip]
	mov	edx, 234
	lea	rsi, .LC75[rip]
	lea	rdi, .LC76[rip]
	call	__assert_fail@PLT
.L806:
	endbr64
	mov	rbp, rax
	jmp	.L797
	.section	.gcc_except_table
.LLSDA6922:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSE6922-.LLSDACSB6922
.LLSDACSB6922:
	.uleb128 .LEHB77-.LFB6922
	.uleb128 .LEHE77-.LEHB77
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB78-.LFB6922
	.uleb128 .LEHE78-.LEHB78
	.uleb128 .L806-.LFB6922
	.uleb128 0
	.uleb128 .LEHB79-.LFB6922
	.uleb128 .LEHE79-.LEHB79
	.uleb128 0
	.uleb128 0
.LLSDACSE6922:
	.text
	.cfi_endproc
	.section	.text.unlikely
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gxx_personality_v0
	.cfi_lsda 0x1b,.LLSDAC6922
	.type	_Z6BM_PowIXadL_ZL15pow_cpp_ternarymmEEEvRN9benchmark5StateERKSt6vectorISt4pairImmESaIS5_EE.cold, @function
_Z6BM_PowIXadL_ZL15pow_cpp_ternarymmEEEvRN9benchmark5StateERKSt6vectorISt4pairImmESaIS5_EE.cold:
.LFSB6922:
.L797:
	.cfi_def_cfa_offset 144
	.cfi_offset 3, -56
	.cfi_offset 6, -48
	.cfi_offset 12, -40
	.cfi_offset 13, -32
	.cfi_offset 14, -24
	.cfi_offset 15, -16
	mov	rdi, rbx
	vzeroupper
	call	_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_disposeEv
	mov	rax, QWORD PTR 72[rsp]
	sub	rax, QWORD PTR fs:40
	jne	.L836
	mov	rdi, rbp
.LEHB80:
	call	_Unwind_Resume@PLT
.LEHE80:
.L836:
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE6922:
	.section	.gcc_except_table
.LLSDAC6922:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSEC6922-.LLSDACSBC6922
.LLSDACSBC6922:
	.uleb128 .LEHB80-.LCOLDB78
	.uleb128 .LEHE80-.LEHB80
	.uleb128 0
	.uleb128 0
.LLSDACSEC6922:
	.section	.text.unlikely
	.text
	.size	_Z6BM_PowIXadL_ZL15pow_cpp_ternarymmEEEvRN9benchmark5StateERKSt6vectorISt4pairImmESaIS5_EE, .-_Z6BM_PowIXadL_ZL15pow_cpp_ternarymmEEEvRN9benchmark5StateERKSt6vectorISt4pairImmESaIS5_EE
	.section	.text.unlikely
	.size	_Z6BM_PowIXadL_ZL15pow_cpp_ternarymmEEEvRN9benchmark5StateERKSt6vectorISt4pairImmESaIS5_EE.cold, .-_Z6BM_PowIXadL_ZL15pow_cpp_ternarymmEEEvRN9benchmark5StateERKSt6vectorISt4pairImmESaIS5_EE.cold
.LCOLDE78:
	.text
.LHOTE78:
	.p2align 4
	.type	_ZL19BM_CppTernary_LargeRN9benchmark5StateE, @function
_ZL19BM_CppTernary_LargeRN9benchmark5StateE:
.LFB6371:
	.cfi_startproc
	endbr64
	lea	rsi, _ZL9kLargeExp[rip]
	jmp	_Z6BM_PowIXadL_ZL15pow_cpp_ternarymmEEEvRN9benchmark5StateERKSt6vectorISt4pairImmESaIS5_EE
	.cfi_endproc
.LFE6371:
	.size	_ZL19BM_CppTernary_LargeRN9benchmark5StateE, .-_ZL19BM_CppTernary_LargeRN9benchmark5StateE
	.p2align 4
	.type	_ZL17BM_CppTernary_MedRN9benchmark5StateE, @function
_ZL17BM_CppTernary_MedRN9benchmark5StateE:
.LFB6364:
	.cfi_startproc
	endbr64
	lea	rsi, _ZL7kMedExp[rip]
	jmp	_Z6BM_PowIXadL_ZL15pow_cpp_ternarymmEEEvRN9benchmark5StateERKSt6vectorISt4pairImmESaIS5_EE
	.cfi_endproc
.LFE6364:
	.size	_ZL17BM_CppTernary_MedRN9benchmark5StateE, .-_ZL17BM_CppTernary_MedRN9benchmark5StateE
	.p2align 4
	.type	_ZL19BM_CppTernary_SmallRN9benchmark5StateE, @function
_ZL19BM_CppTernary_SmallRN9benchmark5StateE:
.LFB6357:
	.cfi_startproc
	endbr64
	lea	rsi, _ZL9kSmallExp[rip]
	jmp	_Z6BM_PowIXadL_ZL15pow_cpp_ternarymmEEEvRN9benchmark5StateERKSt6vectorISt4pairImmESaIS5_EE
	.cfi_endproc
.LFE6357:
	.size	_ZL19BM_CppTernary_SmallRN9benchmark5StateE, .-_ZL19BM_CppTernary_SmallRN9benchmark5StateE
	.section	.text.unlikely
.LCOLDB79:
	.text
.LHOTB79:
	.p2align 4
	.type	_Z6BM_PowIXadL_ZL18pow_cpp_branchlessmmEEEvRN9benchmark5StateERKSt6vectorISt4pairImmESaIS5_EE, @function
_Z6BM_PowIXadL_ZL18pow_cpp_branchlessmmEEEvRN9benchmark5StateERKSt6vectorISt4pairImmESaIS5_EE:
.LFB6921:
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gxx_personality_v0
	.cfi_lsda 0x1b,.LLSDA6921
	push	r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	push	r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	push	r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	push	r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	push	rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	mov	rbp, rdi
	push	rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	mov	rbx, rsi
	sub	rsp, 88
	.cfi_def_cfa_offset 144
	mov	rax, QWORD PTR fs:40
	mov	QWORD PTR 72[rsp], rax
	xor	eax, eax
	mov	eax, DWORD PTR 28[rdi]
	test	eax, eax
	je	.L841
.LEHB81:
	call	_ZN9benchmark5State16StartKeepRunningEv@PLT
.L842:
	mov	rdi, rbp
	call	_ZN9benchmark5State17FinishKeepRunningEv@PLT
	cmp	BYTE PTR 24[rbp], 0
	je	.L869
	mov	rdx, QWORD PTR 16[rbp]
	sub	rdx, QWORD PTR 0[rbp]
	add	rdx, QWORD PTR 8[rbp]
.L848:
	mov	rax, QWORD PTR 8[rbx]
	sub	rax, QWORD PTR [rbx]
	vxorps	xmm0, xmm0, xmm0
	lea	r14, 48[rsp]
	sar	rax, 4
	mov	edi, 17
	mov	QWORD PTR 32[rsp], r14
	imul	rax, rdx
	vcvtsi2sd	xmm0, xmm0, rax
	vmovsd	QWORD PTR 8[rsp], xmm0
	call	_Znwm@PLT
.LEHE81:
	vmovdqa	xmm0, XMMWORD PTR .LC77[rip]
	mov	r15, QWORD PTR 80[rbp]
	mov	QWORD PTR 48[rsp], 16
	mov	QWORD PTR 32[rsp], rax
	mov	rbx, rax
	mov	BYTE PTR 16[rax], 0
	vmovdqu	XMMWORD PTR [rax], xmm0
	lea	rax, 72[rbp]
	mov	QWORD PTR 40[rsp], 16
	mov	r12, rax
	mov	QWORD PTR [rsp], rax
	test	r15, r15
	jne	.L856
	jmp	.L849
	.p2align 4,,10
	.p2align 3
.L896:
	test	r13, r13
	jne	.L894
.L851:
	mov	r15, QWORD PTR 24[r15]
	test	r15, r15
	je	.L895
.L856:
	mov	r13, QWORD PTR 40[r15]
	mov	rdi, QWORD PTR 32[r15]
	cmp	r13, 16
	jbe	.L896
	mov	edx, 16
	mov	rsi, rbx
	call	memcmp@PLT
	test	eax, eax
	jne	.L853
	lea	rax, -16[r13]
	cmp	rax, 2147483647
	jg	.L854
	cmp	rax, -2147483648
	jl	.L851
	.p2align 4,,10
	.p2align 3
.L853:
	test	eax, eax
	js	.L851
.L854:
	mov	r12, r15
	mov	r15, QWORD PTR 16[r15]
	test	r15, r15
	jne	.L856
.L895:
	cmp	QWORD PTR [rsp], r12
	je	.L849
	mov	r13, QWORD PTR 40[r12]
	mov	rsi, QWORD PTR 32[r12]
	cmp	r13, 15
	jbe	.L897
	mov	edx, 16
	mov	rdi, rbx
	call	memcmp@PLT
	test	eax, eax
	je	.L898
.L860:
	test	eax, eax
	jns	.L858
.L849:
	lea	rbx, 32[rsp]
	lea	rcx, 24[rsp]
	mov	rsi, r12
	lea	rdi, 64[rbp]
	lea	r8, 23[rsp]
	mov	QWORD PTR 24[rsp], rbx
	lea	rdx, _ZSt19piecewise_construct[rip]
.LEHB82:
	call	_ZNSt8_Rb_treeINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESt4pairIKS5_N9benchmark7CounterEESt10_Select1stISA_ESt4lessIS5_ESaISA_EE22_M_emplace_hint_uniqueIJRKSt21piecewise_construct_tSt5tupleIJOS5_EESL_IJEEEEESt17_Rb_tree_iteratorISA_ESt23_Rb_tree_const_iteratorISA_EDpOT_
.LEHE82:
	vmovsd	xmm1, QWORD PTR 8[rsp]
	mov	rbx, QWORD PTR 32[rsp]
	movabs	rcx, 4294967296001
	mov	QWORD PTR 72[rax], rcx
	vmovsd	QWORD PTR 64[rax], xmm1
	cmp	rbx, r14
	je	.L840
.L866:
	mov	rax, QWORD PTR 48[rsp]
	mov	rdi, rbx
	lea	rsi, 1[rax]
	call	_ZdlPvm@PLT
.L840:
	mov	rax, QWORD PTR 72[rsp]
	sub	rax, QWORD PTR fs:40
	jne	.L899
	add	rsp, 88
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	pop	rbx
	.cfi_def_cfa_offset 48
	pop	rbp
	.cfi_def_cfa_offset 40
	pop	r12
	.cfi_def_cfa_offset 32
	pop	r13
	.cfi_def_cfa_offset 24
	pop	r14
	.cfi_def_cfa_offset 16
	pop	r15
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L894:
	.cfi_restore_state
	mov	rdx, r13
	mov	rsi, rbx
	call	memcmp@PLT
	test	eax, eax
	jne	.L853
	lea	rax, -16[r13]
	test	eax, eax
	jns	.L854
	jmp	.L851
.L841:
	mov	r12, QWORD PTR 16[rdi]
.LEHB83:
	call	_ZN9benchmark5State16StartKeepRunningEv@PLT
.LEHE83:
	test	r12, r12
	je	.L842
	mov	rdx, QWORD PTR [rbx]
	mov	r8, QWORD PTR 8[rbx]
	cmp	r8, rdx
	je	.L868
	.p2align 4,,10
	.p2align 3
.L847:
	xor	ecx, ecx
	.p2align 4,,10
	.p2align 3
.L845:
	mov	rsi, QWORD PTR 8[rdx]
	mov	rdi, QWORD PTR [rdx]
	add	rdx, 16
	call	_ZL18pow_cpp_branchlessmm
	add	rcx, rax
	cmp	rdx, r8
	jne	.L845
.L844:
	test	r12, r12
	jle	.L900
.L846:
	sub	r12, 1
	je	.L842
	mov	rdx, QWORD PTR [rbx]
	mov	r8, QWORD PTR 8[rbx]
	cmp	r8, rdx
	jne	.L847
	xor	eax, eax
	jmp	.L846
.L898:
	mov	eax, 16
	sub	rax, r13
	cmp	rax, 2147483647
	jg	.L858
	cmp	rax, -2147483648
	jl	.L849
	test	eax, eax
	js	.L849
.L858:
	movabs	rax, 4294967296001
	vmovsd	xmm2, QWORD PTR 8[rsp]
	mov	QWORD PTR 72[r12], rax
	vmovsd	QWORD PTR 64[r12], xmm2
	jmp	.L866
.L897:
	test	r13, r13
	je	.L858
	mov	rdx, r13
	mov	rdi, rbx
	call	memcmp@PLT
	test	eax, eax
	je	.L858
	jmp	.L860
.L868:
	xor	ecx, ecx
	jmp	.L844
.L869:
	xor	edx, edx
	jmp	.L848
.L899:
	call	__stack_chk_fail@PLT
.L900:
	lea	rcx, .LC74[rip]
	mov	edx, 234
	lea	rsi, .LC75[rip]
	lea	rdi, .LC76[rip]
	call	__assert_fail@PLT
.L871:
	endbr64
	mov	rbp, rax
	jmp	.L862
	.section	.gcc_except_table
.LLSDA6921:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSE6921-.LLSDACSB6921
.LLSDACSB6921:
	.uleb128 .LEHB81-.LFB6921
	.uleb128 .LEHE81-.LEHB81
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB82-.LFB6921
	.uleb128 .LEHE82-.LEHB82
	.uleb128 .L871-.LFB6921
	.uleb128 0
	.uleb128 .LEHB83-.LFB6921
	.uleb128 .LEHE83-.LEHB83
	.uleb128 0
	.uleb128 0
.LLSDACSE6921:
	.text
	.cfi_endproc
	.section	.text.unlikely
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gxx_personality_v0
	.cfi_lsda 0x1b,.LLSDAC6921
	.type	_Z6BM_PowIXadL_ZL18pow_cpp_branchlessmmEEEvRN9benchmark5StateERKSt6vectorISt4pairImmESaIS5_EE.cold, @function
_Z6BM_PowIXadL_ZL18pow_cpp_branchlessmmEEEvRN9benchmark5StateERKSt6vectorISt4pairImmESaIS5_EE.cold:
.LFSB6921:
.L862:
	.cfi_def_cfa_offset 144
	.cfi_offset 3, -56
	.cfi_offset 6, -48
	.cfi_offset 12, -40
	.cfi_offset 13, -32
	.cfi_offset 14, -24
	.cfi_offset 15, -16
	mov	rdi, rbx
	vzeroupper
	call	_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_disposeEv
	mov	rax, QWORD PTR 72[rsp]
	sub	rax, QWORD PTR fs:40
	jne	.L901
	mov	rdi, rbp
.LEHB84:
	call	_Unwind_Resume@PLT
.LEHE84:
.L901:
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE6921:
	.section	.gcc_except_table
.LLSDAC6921:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSEC6921-.LLSDACSBC6921
.LLSDACSBC6921:
	.uleb128 .LEHB84-.LCOLDB79
	.uleb128 .LEHE84-.LEHB84
	.uleb128 0
	.uleb128 0
.LLSDACSEC6921:
	.section	.text.unlikely
	.text
	.size	_Z6BM_PowIXadL_ZL18pow_cpp_branchlessmmEEEvRN9benchmark5StateERKSt6vectorISt4pairImmESaIS5_EE, .-_Z6BM_PowIXadL_ZL18pow_cpp_branchlessmmEEEvRN9benchmark5StateERKSt6vectorISt4pairImmESaIS5_EE
	.section	.text.unlikely
	.size	_Z6BM_PowIXadL_ZL18pow_cpp_branchlessmmEEEvRN9benchmark5StateERKSt6vectorISt4pairImmESaIS5_EE.cold, .-_Z6BM_PowIXadL_ZL18pow_cpp_branchlessmmEEEvRN9benchmark5StateERKSt6vectorISt4pairImmESaIS5_EE.cold
.LCOLDE79:
	.text
.LHOTE79:
	.p2align 4
	.type	_ZL22BM_CppBranchless_LargeRN9benchmark5StateE, @function
_ZL22BM_CppBranchless_LargeRN9benchmark5StateE:
.LFB6370:
	.cfi_startproc
	endbr64
	lea	rsi, _ZL9kLargeExp[rip]
	jmp	_Z6BM_PowIXadL_ZL18pow_cpp_branchlessmmEEEvRN9benchmark5StateERKSt6vectorISt4pairImmESaIS5_EE
	.cfi_endproc
.LFE6370:
	.size	_ZL22BM_CppBranchless_LargeRN9benchmark5StateE, .-_ZL22BM_CppBranchless_LargeRN9benchmark5StateE
	.p2align 4
	.type	_ZL20BM_CppBranchless_MedRN9benchmark5StateE, @function
_ZL20BM_CppBranchless_MedRN9benchmark5StateE:
.LFB6363:
	.cfi_startproc
	endbr64
	lea	rsi, _ZL7kMedExp[rip]
	jmp	_Z6BM_PowIXadL_ZL18pow_cpp_branchlessmmEEEvRN9benchmark5StateERKSt6vectorISt4pairImmESaIS5_EE
	.cfi_endproc
.LFE6363:
	.size	_ZL20BM_CppBranchless_MedRN9benchmark5StateE, .-_ZL20BM_CppBranchless_MedRN9benchmark5StateE
	.p2align 4
	.type	_ZL22BM_CppBranchless_SmallRN9benchmark5StateE, @function
_ZL22BM_CppBranchless_SmallRN9benchmark5StateE:
.LFB6356:
	.cfi_startproc
	endbr64
	lea	rsi, _ZL9kSmallExp[rip]
	jmp	_Z6BM_PowIXadL_ZL18pow_cpp_branchlessmmEEEvRN9benchmark5StateERKSt6vectorISt4pairImmESaIS5_EE
	.cfi_endproc
.LFE6356:
	.size	_ZL22BM_CppBranchless_SmallRN9benchmark5StateE, .-_ZL22BM_CppBranchless_SmallRN9benchmark5StateE
	.section	.text.unlikely
.LCOLDB80:
	.text
.LHOTB80:
	.p2align 4
	.type	_Z6BM_PowIXadL_ZL15wrap_ultra_fastmmEEEvRN9benchmark5StateERKSt6vectorISt4pairImmESaIS5_EE, @function
_Z6BM_PowIXadL_ZL15wrap_ultra_fastmmEEEvRN9benchmark5StateERKSt6vectorISt4pairImmESaIS5_EE:
.LFB6918:
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gxx_personality_v0
	.cfi_lsda 0x1b,.LLSDA6918
	push	r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	push	r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	push	r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	push	r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	push	rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	mov	rbp, rdi
	push	rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	mov	rbx, rsi
	sub	rsp, 88
	.cfi_def_cfa_offset 144
	mov	rax, QWORD PTR fs:40
	mov	QWORD PTR 72[rsp], rax
	xor	eax, eax
	mov	eax, DWORD PTR 28[rdi]
	test	eax, eax
	je	.L906
.LEHB85:
	call	_ZN9benchmark5State16StartKeepRunningEv@PLT
.L907:
	mov	rdi, rbp
	call	_ZN9benchmark5State17FinishKeepRunningEv@PLT
	cmp	BYTE PTR 24[rbp], 0
	je	.L934
	mov	rdx, QWORD PTR 16[rbp]
	sub	rdx, QWORD PTR 0[rbp]
	add	rdx, QWORD PTR 8[rbp]
.L913:
	mov	rax, QWORD PTR 8[rbx]
	sub	rax, QWORD PTR [rbx]
	vxorps	xmm0, xmm0, xmm0
	lea	r14, 48[rsp]
	sar	rax, 4
	mov	edi, 17
	mov	QWORD PTR 32[rsp], r14
	imul	rax, rdx
	vcvtsi2sd	xmm0, xmm0, rax
	vmovsd	QWORD PTR 8[rsp], xmm0
	call	_Znwm@PLT
.LEHE85:
	vmovdqa	xmm0, XMMWORD PTR .LC77[rip]
	mov	r15, QWORD PTR 80[rbp]
	mov	QWORD PTR 48[rsp], 16
	mov	QWORD PTR 32[rsp], rax
	mov	rbx, rax
	mov	BYTE PTR 16[rax], 0
	vmovdqu	XMMWORD PTR [rax], xmm0
	lea	rax, 72[rbp]
	mov	QWORD PTR 40[rsp], 16
	mov	r12, rax
	mov	QWORD PTR [rsp], rax
	test	r15, r15
	jne	.L921
	jmp	.L914
	.p2align 4,,10
	.p2align 3
.L961:
	test	r13, r13
	jne	.L959
.L916:
	mov	r15, QWORD PTR 24[r15]
	test	r15, r15
	je	.L960
.L921:
	mov	r13, QWORD PTR 40[r15]
	mov	rdi, QWORD PTR 32[r15]
	cmp	r13, 16
	jbe	.L961
	mov	edx, 16
	mov	rsi, rbx
	call	memcmp@PLT
	test	eax, eax
	jne	.L918
	lea	rax, -16[r13]
	cmp	rax, 2147483647
	jg	.L919
	cmp	rax, -2147483648
	jl	.L916
	.p2align 4,,10
	.p2align 3
.L918:
	test	eax, eax
	js	.L916
.L919:
	mov	r12, r15
	mov	r15, QWORD PTR 16[r15]
	test	r15, r15
	jne	.L921
.L960:
	cmp	QWORD PTR [rsp], r12
	je	.L914
	mov	r13, QWORD PTR 40[r12]
	mov	rsi, QWORD PTR 32[r12]
	cmp	r13, 15
	jbe	.L962
	mov	edx, 16
	mov	rdi, rbx
	call	memcmp@PLT
	test	eax, eax
	je	.L963
.L925:
	test	eax, eax
	jns	.L923
.L914:
	lea	rbx, 32[rsp]
	lea	rcx, 24[rsp]
	mov	rsi, r12
	lea	rdi, 64[rbp]
	lea	r8, 23[rsp]
	mov	QWORD PTR 24[rsp], rbx
	lea	rdx, _ZSt19piecewise_construct[rip]
.LEHB86:
	call	_ZNSt8_Rb_treeINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESt4pairIKS5_N9benchmark7CounterEESt10_Select1stISA_ESt4lessIS5_ESaISA_EE22_M_emplace_hint_uniqueIJRKSt21piecewise_construct_tSt5tupleIJOS5_EESL_IJEEEEESt17_Rb_tree_iteratorISA_ESt23_Rb_tree_const_iteratorISA_EDpOT_
.LEHE86:
	vmovsd	xmm1, QWORD PTR 8[rsp]
	mov	rbx, QWORD PTR 32[rsp]
	movabs	rdx, 4294967296001
	mov	QWORD PTR 72[rax], rdx
	vmovsd	QWORD PTR 64[rax], xmm1
	cmp	rbx, r14
	je	.L905
.L931:
	mov	rax, QWORD PTR 48[rsp]
	mov	rdi, rbx
	lea	rsi, 1[rax]
	call	_ZdlPvm@PLT
.L905:
	mov	rax, QWORD PTR 72[rsp]
	sub	rax, QWORD PTR fs:40
	jne	.L964
	add	rsp, 88
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	pop	rbx
	.cfi_def_cfa_offset 48
	pop	rbp
	.cfi_def_cfa_offset 40
	pop	r12
	.cfi_def_cfa_offset 32
	pop	r13
	.cfi_def_cfa_offset 24
	pop	r14
	.cfi_def_cfa_offset 16
	pop	r15
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L959:
	.cfi_restore_state
	mov	rdx, r13
	mov	rsi, rbx
	call	memcmp@PLT
	test	eax, eax
	jne	.L918
	lea	rax, -16[r13]
	test	eax, eax
	jns	.L919
	jmp	.L916
.L906:
	mov	r12, QWORD PTR 16[rdi]
.LEHB87:
	call	_ZN9benchmark5State16StartKeepRunningEv@PLT
.LEHE87:
	test	r12, r12
	je	.L907
	mov	rcx, QWORD PTR [rbx]
	mov	r9, QWORD PTR 8[rbx]
	cmp	r9, rcx
	je	.L933
	.p2align 4,,10
	.p2align 3
.L912:
	xor	r8d, r8d
	.p2align 4,,10
	.p2align 3
.L910:
	mov	rsi, QWORD PTR 8[rcx]
	mov	rdi, QWORD PTR [rcx]
	add	rcx, 16
	call	_ZL15wrap_ultra_fastmm
	add	r8, rax
	cmp	rcx, r9
	jne	.L910
.L909:
	test	r12, r12
	jle	.L965
.L911:
	sub	r12, 1
	je	.L907
	mov	rcx, QWORD PTR [rbx]
	mov	r9, QWORD PTR 8[rbx]
	cmp	r9, rcx
	jne	.L912
	xor	eax, eax
	jmp	.L911
.L963:
	mov	eax, 16
	sub	rax, r13
	cmp	rax, 2147483647
	jg	.L923
	cmp	rax, -2147483648
	jl	.L914
	test	eax, eax
	js	.L914
.L923:
	movabs	rax, 4294967296001
	vmovsd	xmm2, QWORD PTR 8[rsp]
	mov	QWORD PTR 72[r12], rax
	vmovsd	QWORD PTR 64[r12], xmm2
	jmp	.L931
.L962:
	test	r13, r13
	je	.L923
	mov	rdx, r13
	mov	rdi, rbx
	call	memcmp@PLT
	test	eax, eax
	je	.L923
	jmp	.L925
.L934:
	xor	edx, edx
	jmp	.L913
.L933:
	xor	r8d, r8d
	jmp	.L909
.L964:
	call	__stack_chk_fail@PLT
.L965:
	lea	rcx, .LC74[rip]
	mov	edx, 234
	lea	rsi, .LC75[rip]
	lea	rdi, .LC76[rip]
	call	__assert_fail@PLT
.L936:
	endbr64
	mov	rbp, rax
	jmp	.L927
	.section	.gcc_except_table
.LLSDA6918:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSE6918-.LLSDACSB6918
.LLSDACSB6918:
	.uleb128 .LEHB85-.LFB6918
	.uleb128 .LEHE85-.LEHB85
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB86-.LFB6918
	.uleb128 .LEHE86-.LEHB86
	.uleb128 .L936-.LFB6918
	.uleb128 0
	.uleb128 .LEHB87-.LFB6918
	.uleb128 .LEHE87-.LEHB87
	.uleb128 0
	.uleb128 0
.LLSDACSE6918:
	.text
	.cfi_endproc
	.section	.text.unlikely
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gxx_personality_v0
	.cfi_lsda 0x1b,.LLSDAC6918
	.type	_Z6BM_PowIXadL_ZL15wrap_ultra_fastmmEEEvRN9benchmark5StateERKSt6vectorISt4pairImmESaIS5_EE.cold, @function
_Z6BM_PowIXadL_ZL15wrap_ultra_fastmmEEEvRN9benchmark5StateERKSt6vectorISt4pairImmESaIS5_EE.cold:
.LFSB6918:
.L927:
	.cfi_def_cfa_offset 144
	.cfi_offset 3, -56
	.cfi_offset 6, -48
	.cfi_offset 12, -40
	.cfi_offset 13, -32
	.cfi_offset 14, -24
	.cfi_offset 15, -16
	mov	rdi, rbx
	vzeroupper
	call	_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_disposeEv
	mov	rax, QWORD PTR 72[rsp]
	sub	rax, QWORD PTR fs:40
	jne	.L966
	mov	rdi, rbp
.LEHB88:
	call	_Unwind_Resume@PLT
.LEHE88:
.L966:
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE6918:
	.section	.gcc_except_table
.LLSDAC6918:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSEC6918-.LLSDACSBC6918
.LLSDACSBC6918:
	.uleb128 .LEHB88-.LCOLDB80
	.uleb128 .LEHE88-.LEHB88
	.uleb128 0
	.uleb128 0
.LLSDACSEC6918:
	.section	.text.unlikely
	.text
	.size	_Z6BM_PowIXadL_ZL15wrap_ultra_fastmmEEEvRN9benchmark5StateERKSt6vectorISt4pairImmESaIS5_EE, .-_Z6BM_PowIXadL_ZL15wrap_ultra_fastmmEEEvRN9benchmark5StateERKSt6vectorISt4pairImmESaIS5_EE
	.section	.text.unlikely
	.size	_Z6BM_PowIXadL_ZL15wrap_ultra_fastmmEEEvRN9benchmark5StateERKSt6vectorISt4pairImmESaIS5_EE.cold, .-_Z6BM_PowIXadL_ZL15wrap_ultra_fastmmEEEvRN9benchmark5StateERKSt6vectorISt4pairImmESaIS5_EE.cold
.LCOLDE80:
	.text
.LHOTE80:
	.p2align 4
	.type	_ZL18BM_UltraFast_LargeRN9benchmark5StateE, @function
_ZL18BM_UltraFast_LargeRN9benchmark5StateE:
.LFB6367:
	.cfi_startproc
	endbr64
	lea	rsi, _ZL9kLargeExp[rip]
	jmp	_Z6BM_PowIXadL_ZL15wrap_ultra_fastmmEEEvRN9benchmark5StateERKSt6vectorISt4pairImmESaIS5_EE
	.cfi_endproc
.LFE6367:
	.size	_ZL18BM_UltraFast_LargeRN9benchmark5StateE, .-_ZL18BM_UltraFast_LargeRN9benchmark5StateE
	.p2align 4
	.type	_ZL16BM_UltraFast_MedRN9benchmark5StateE, @function
_ZL16BM_UltraFast_MedRN9benchmark5StateE:
.LFB6360:
	.cfi_startproc
	endbr64
	lea	rsi, _ZL7kMedExp[rip]
	jmp	_Z6BM_PowIXadL_ZL15wrap_ultra_fastmmEEEvRN9benchmark5StateERKSt6vectorISt4pairImmESaIS5_EE
	.cfi_endproc
.LFE6360:
	.size	_ZL16BM_UltraFast_MedRN9benchmark5StateE, .-_ZL16BM_UltraFast_MedRN9benchmark5StateE
	.p2align 4
	.type	_ZL18BM_UltraFast_SmallRN9benchmark5StateE, @function
_ZL18BM_UltraFast_SmallRN9benchmark5StateE:
.LFB6353:
	.cfi_startproc
	endbr64
	lea	rsi, _ZL9kSmallExp[rip]
	jmp	_Z6BM_PowIXadL_ZL15wrap_ultra_fastmmEEEvRN9benchmark5StateERKSt6vectorISt4pairImmESaIS5_EE
	.cfi_endproc
.LFE6353:
	.size	_ZL18BM_UltraFast_SmallRN9benchmark5StateE, .-_ZL18BM_UltraFast_SmallRN9benchmark5StateE
	.section	.text.unlikely
.LCOLDB81:
	.text
.LHOTB81:
	.p2align 4
	.type	_Z6BM_PowIXadL_ZL17wrap_hierarchicalmmEEEvRN9benchmark5StateERKSt6vectorISt4pairImmESaIS5_EE, @function
_Z6BM_PowIXadL_ZL17wrap_hierarchicalmmEEEvRN9benchmark5StateERKSt6vectorISt4pairImmESaIS5_EE:
.LFB6910:
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gxx_personality_v0
	.cfi_lsda 0x1b,.LLSDA6910
	push	r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	push	r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	mov	r14, rdi
	push	r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	mov	r13, rsi
	push	r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	push	rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	push	rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	sub	rsp, 88
	.cfi_def_cfa_offset 144
	mov	rax, QWORD PTR fs:40
	mov	QWORD PTR 72[rsp], rax
	xor	eax, eax
	mov	eax, DWORD PTR 28[rdi]
	test	eax, eax
	je	.L971
.LEHB89:
	call	_ZN9benchmark5State16StartKeepRunningEv@PLT
.L972:
	mov	rdi, r14
	call	_ZN9benchmark5State17FinishKeepRunningEv@PLT
	cmp	BYTE PTR 24[r14], 0
	je	.L999
	mov	rdx, QWORD PTR 16[r14]
	sub	rdx, QWORD PTR [r14]
	add	rdx, QWORD PTR 8[r14]
.L978:
	mov	rax, QWORD PTR 8[r13]
	sub	rax, QWORD PTR 0[r13]
	vxorps	xmm0, xmm0, xmm0
	lea	r15, 48[rsp]
	sar	rax, 4
	mov	edi, 17
	mov	QWORD PTR 32[rsp], r15
	imul	rax, rdx
	vcvtsi2sd	xmm0, xmm0, rax
	vmovsd	QWORD PTR 8[rsp], xmm0
	call	_Znwm@PLT
.LEHE89:
	vmovdqa	xmm0, XMMWORD PTR .LC77[rip]
	mov	r12, QWORD PTR 80[r14]
	mov	QWORD PTR 48[rsp], 16
	mov	QWORD PTR 32[rsp], rax
	mov	rbx, rax
	mov	BYTE PTR 16[rax], 0
	vmovdqu	XMMWORD PTR [rax], xmm0
	lea	rax, 72[r14]
	mov	QWORD PTR 40[rsp], 16
	mov	rbp, rax
	mov	QWORD PTR [rsp], rax
	test	r12, r12
	jne	.L986
	jmp	.L979
	.p2align 4,,10
	.p2align 3
.L1026:
	test	r13, r13
	jne	.L1024
.L981:
	mov	r12, QWORD PTR 24[r12]
	test	r12, r12
	je	.L1025
.L986:
	mov	r13, QWORD PTR 40[r12]
	mov	rdi, QWORD PTR 32[r12]
	cmp	r13, 16
	jbe	.L1026
	mov	edx, 16
	mov	rsi, rbx
	call	memcmp@PLT
	test	eax, eax
	jne	.L983
	lea	rax, -16[r13]
	cmp	rax, 2147483647
	jg	.L984
	cmp	rax, -2147483648
	jl	.L981
	.p2align 4,,10
	.p2align 3
.L983:
	test	eax, eax
	js	.L981
.L984:
	mov	rbp, r12
	mov	r12, QWORD PTR 16[r12]
	test	r12, r12
	jne	.L986
.L1025:
	cmp	QWORD PTR [rsp], rbp
	je	.L979
	mov	r13, QWORD PTR 40[rbp]
	mov	rsi, QWORD PTR 32[rbp]
	cmp	r13, 15
	jbe	.L1027
	mov	edx, 16
	mov	rdi, rbx
	call	memcmp@PLT
	test	eax, eax
	je	.L1028
.L990:
	test	eax, eax
	jns	.L988
.L979:
	lea	rbx, 32[rsp]
	lea	rcx, 24[rsp]
	mov	rsi, rbp
	lea	rdi, 64[r14]
	lea	r8, 23[rsp]
	mov	QWORD PTR 24[rsp], rbx
	lea	rdx, _ZSt19piecewise_construct[rip]
.LEHB90:
	call	_ZNSt8_Rb_treeINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESt4pairIKS5_N9benchmark7CounterEESt10_Select1stISA_ESt4lessIS5_ESaISA_EE22_M_emplace_hint_uniqueIJRKSt21piecewise_construct_tSt5tupleIJOS5_EESL_IJEEEEESt17_Rb_tree_iteratorISA_ESt23_Rb_tree_const_iteratorISA_EDpOT_
.LEHE90:
	vmovsd	xmm1, QWORD PTR 8[rsp]
	mov	rbx, QWORD PTR 32[rsp]
	movabs	rcx, 4294967296001
	mov	QWORD PTR 72[rax], rcx
	vmovsd	QWORD PTR 64[rax], xmm1
	cmp	rbx, r15
	je	.L970
.L996:
	mov	rax, QWORD PTR 48[rsp]
	mov	rdi, rbx
	lea	rsi, 1[rax]
	call	_ZdlPvm@PLT
.L970:
	mov	rax, QWORD PTR 72[rsp]
	sub	rax, QWORD PTR fs:40
	jne	.L1029
	add	rsp, 88
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	pop	rbx
	.cfi_def_cfa_offset 48
	pop	rbp
	.cfi_def_cfa_offset 40
	pop	r12
	.cfi_def_cfa_offset 32
	pop	r13
	.cfi_def_cfa_offset 24
	pop	r14
	.cfi_def_cfa_offset 16
	pop	r15
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L1024:
	.cfi_restore_state
	mov	rdx, r13
	mov	rsi, rbx
	call	memcmp@PLT
	test	eax, eax
	jne	.L983
	lea	rax, -16[r13]
	test	eax, eax
	jns	.L984
	jmp	.L981
.L971:
	mov	r12, QWORD PTR 16[rdi]
.LEHB91:
	call	_ZN9benchmark5State16StartKeepRunningEv@PLT
.LEHE91:
	test	r12, r12
	je	.L972
	mov	rbx, QWORD PTR 0[r13]
	mov	rbp, QWORD PTR 8[r13]
	cmp	rbp, rbx
	je	.L998
	.p2align 4,,10
	.p2align 3
.L977:
	xor	r15d, r15d
	.p2align 4,,10
	.p2align 3
.L975:
	mov	rsi, QWORD PTR 8[rbx]
	mov	rdi, QWORD PTR [rbx]
	add	rbx, 16
	call	_ZL17wrap_hierarchicalmm
	add	r15, rax
	cmp	rbp, rbx
	jne	.L975
.L974:
	test	r12, r12
	jle	.L1030
.L976:
	sub	r12, 1
	je	.L972
	mov	rbx, QWORD PTR 0[r13]
	mov	rbp, QWORD PTR 8[r13]
	cmp	rbp, rbx
	jne	.L977
	xor	eax, eax
	jmp	.L976
.L1028:
	mov	eax, 16
	sub	rax, r13
	cmp	rax, 2147483647
	jg	.L988
	cmp	rax, -2147483648
	jl	.L979
	test	eax, eax
	js	.L979
.L988:
	movabs	rax, 4294967296001
	vmovsd	xmm2, QWORD PTR 8[rsp]
	mov	QWORD PTR 72[rbp], rax
	vmovsd	QWORD PTR 64[rbp], xmm2
	jmp	.L996
.L1027:
	test	r13, r13
	je	.L988
	mov	rdx, r13
	mov	rdi, rbx
	call	memcmp@PLT
	test	eax, eax
	je	.L988
	jmp	.L990
.L999:
	xor	edx, edx
	jmp	.L978
.L998:
	xor	r15d, r15d
	jmp	.L974
.L1029:
	call	__stack_chk_fail@PLT
.L1030:
	lea	rcx, .LC74[rip]
	mov	edx, 234
	lea	rsi, .LC75[rip]
	lea	rdi, .LC76[rip]
	call	__assert_fail@PLT
.L1001:
	endbr64
	mov	rbp, rax
	jmp	.L992
	.section	.gcc_except_table
.LLSDA6910:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSE6910-.LLSDACSB6910
.LLSDACSB6910:
	.uleb128 .LEHB89-.LFB6910
	.uleb128 .LEHE89-.LEHB89
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB90-.LFB6910
	.uleb128 .LEHE90-.LEHB90
	.uleb128 .L1001-.LFB6910
	.uleb128 0
	.uleb128 .LEHB91-.LFB6910
	.uleb128 .LEHE91-.LEHB91
	.uleb128 0
	.uleb128 0
.LLSDACSE6910:
	.text
	.cfi_endproc
	.section	.text.unlikely
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gxx_personality_v0
	.cfi_lsda 0x1b,.LLSDAC6910
	.type	_Z6BM_PowIXadL_ZL17wrap_hierarchicalmmEEEvRN9benchmark5StateERKSt6vectorISt4pairImmESaIS5_EE.cold, @function
_Z6BM_PowIXadL_ZL17wrap_hierarchicalmmEEEvRN9benchmark5StateERKSt6vectorISt4pairImmESaIS5_EE.cold:
.LFSB6910:
.L992:
	.cfi_def_cfa_offset 144
	.cfi_offset 3, -56
	.cfi_offset 6, -48
	.cfi_offset 12, -40
	.cfi_offset 13, -32
	.cfi_offset 14, -24
	.cfi_offset 15, -16
	mov	rdi, rbx
	vzeroupper
	call	_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_disposeEv
	mov	rax, QWORD PTR 72[rsp]
	sub	rax, QWORD PTR fs:40
	jne	.L1031
	mov	rdi, rbp
.LEHB92:
	call	_Unwind_Resume@PLT
.LEHE92:
.L1031:
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE6910:
	.section	.gcc_except_table
.LLSDAC6910:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSEC6910-.LLSDACSBC6910
.LLSDACSBC6910:
	.uleb128 .LEHB92-.LCOLDB81
	.uleb128 .LEHE92-.LEHB92
	.uleb128 0
	.uleb128 0
.LLSDACSEC6910:
	.section	.text.unlikely
	.text
	.size	_Z6BM_PowIXadL_ZL17wrap_hierarchicalmmEEEvRN9benchmark5StateERKSt6vectorISt4pairImmESaIS5_EE, .-_Z6BM_PowIXadL_ZL17wrap_hierarchicalmmEEEvRN9benchmark5StateERKSt6vectorISt4pairImmESaIS5_EE
	.section	.text.unlikely
	.size	_Z6BM_PowIXadL_ZL17wrap_hierarchicalmmEEEvRN9benchmark5StateERKSt6vectorISt4pairImmESaIS5_EE.cold, .-_Z6BM_PowIXadL_ZL17wrap_hierarchicalmmEEEvRN9benchmark5StateERKSt6vectorISt4pairImmESaIS5_EE.cold
.LCOLDE81:
	.text
.LHOTE81:
	.p2align 4
	.type	_ZL21BM_Hierarchical_LargeRN9benchmark5StateE, @function
_ZL21BM_Hierarchical_LargeRN9benchmark5StateE:
.LFB6365:
	.cfi_startproc
	endbr64
	lea	rsi, _ZL9kLargeExp[rip]
	jmp	_Z6BM_PowIXadL_ZL17wrap_hierarchicalmmEEEvRN9benchmark5StateERKSt6vectorISt4pairImmESaIS5_EE
	.cfi_endproc
.LFE6365:
	.size	_ZL21BM_Hierarchical_LargeRN9benchmark5StateE, .-_ZL21BM_Hierarchical_LargeRN9benchmark5StateE
	.p2align 4
	.type	_ZL19BM_Hierarchical_MedRN9benchmark5StateE, @function
_ZL19BM_Hierarchical_MedRN9benchmark5StateE:
.LFB6358:
	.cfi_startproc
	endbr64
	lea	rsi, _ZL7kMedExp[rip]
	jmp	_Z6BM_PowIXadL_ZL17wrap_hierarchicalmmEEEvRN9benchmark5StateERKSt6vectorISt4pairImmESaIS5_EE
	.cfi_endproc
.LFE6358:
	.size	_ZL19BM_Hierarchical_MedRN9benchmark5StateE, .-_ZL19BM_Hierarchical_MedRN9benchmark5StateE
	.p2align 4
	.type	_ZL21BM_Hierarchical_SmallRN9benchmark5StateE, @function
_ZL21BM_Hierarchical_SmallRN9benchmark5StateE:
.LFB6351:
	.cfi_startproc
	endbr64
	lea	rsi, _ZL9kSmallExp[rip]
	jmp	_Z6BM_PowIXadL_ZL17wrap_hierarchicalmmEEEvRN9benchmark5StateERKSt6vectorISt4pairImmESaIS5_EE
	.cfi_endproc
.LFE6351:
	.size	_ZL21BM_Hierarchical_SmallRN9benchmark5StateE, .-_ZL21BM_Hierarchical_SmallRN9benchmark5StateE
	.section	.text.unlikely
.LCOLDB82:
	.text
.LHOTB82:
	.p2align 4
	.type	_Z6BM_PowIXadL_ZL18pow_asm_unrolled64mmEEEvRN9benchmark5StateERKSt6vectorISt4pairImmESaIS5_EE, @function
_Z6BM_PowIXadL_ZL18pow_asm_unrolled64mmEEEvRN9benchmark5StateERKSt6vectorISt4pairImmESaIS5_EE:
.LFB6920:
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gxx_personality_v0
	.cfi_lsda 0x1b,.LLSDA6920
	push	r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	push	r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	push	r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	push	r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	push	rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	mov	rbp, rdi
	push	rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	mov	rbx, rsi
	sub	rsp, 88
	.cfi_def_cfa_offset 144
	mov	rax, QWORD PTR fs:40
	mov	QWORD PTR 72[rsp], rax
	xor	eax, eax
	mov	eax, DWORD PTR 28[rdi]
	test	eax, eax
	je	.L1036
.LEHB93:
	call	_ZN9benchmark5State16StartKeepRunningEv@PLT
.L1037:
	mov	rdi, rbp
	call	_ZN9benchmark5State17FinishKeepRunningEv@PLT
	cmp	BYTE PTR 24[rbp], 0
	je	.L1064
	mov	rdx, QWORD PTR 16[rbp]
	sub	rdx, QWORD PTR 0[rbp]
	add	rdx, QWORD PTR 8[rbp]
.L1043:
	mov	rax, QWORD PTR 8[rbx]
	sub	rax, QWORD PTR [rbx]
	vxorps	xmm0, xmm0, xmm0
	lea	r14, 48[rsp]
	sar	rax, 4
	mov	edi, 17
	mov	QWORD PTR 32[rsp], r14
	imul	rax, rdx
	vcvtsi2sd	xmm0, xmm0, rax
	vmovsd	QWORD PTR 8[rsp], xmm0
	call	_Znwm@PLT
.LEHE93:
	vmovdqa	xmm0, XMMWORD PTR .LC77[rip]
	mov	r15, QWORD PTR 80[rbp]
	mov	QWORD PTR 48[rsp], 16
	mov	QWORD PTR 32[rsp], rax
	mov	rbx, rax
	mov	BYTE PTR 16[rax], 0
	vmovdqu	XMMWORD PTR [rax], xmm0
	lea	rax, 72[rbp]
	mov	QWORD PTR 40[rsp], 16
	mov	r12, rax
	mov	QWORD PTR [rsp], rax
	test	r15, r15
	jne	.L1051
	jmp	.L1044
	.p2align 4,,10
	.p2align 3
.L1091:
	test	r13, r13
	jne	.L1089
.L1046:
	mov	r15, QWORD PTR 24[r15]
	test	r15, r15
	je	.L1090
.L1051:
	mov	r13, QWORD PTR 40[r15]
	mov	rdi, QWORD PTR 32[r15]
	cmp	r13, 16
	jbe	.L1091
	mov	edx, 16
	mov	rsi, rbx
	call	memcmp@PLT
	test	eax, eax
	jne	.L1048
	lea	rax, -16[r13]
	cmp	rax, 2147483647
	jg	.L1049
	cmp	rax, -2147483648
	jl	.L1046
	.p2align 4,,10
	.p2align 3
.L1048:
	test	eax, eax
	js	.L1046
.L1049:
	mov	r12, r15
	mov	r15, QWORD PTR 16[r15]
	test	r15, r15
	jne	.L1051
.L1090:
	cmp	QWORD PTR [rsp], r12
	je	.L1044
	mov	r13, QWORD PTR 40[r12]
	mov	rsi, QWORD PTR 32[r12]
	cmp	r13, 15
	jbe	.L1092
	mov	edx, 16
	mov	rdi, rbx
	call	memcmp@PLT
	test	eax, eax
	je	.L1093
.L1055:
	test	eax, eax
	jns	.L1053
.L1044:
	lea	rbx, 32[rsp]
	lea	rcx, 24[rsp]
	mov	rsi, r12
	lea	rdi, 64[rbp]
	lea	r8, 23[rsp]
	mov	QWORD PTR 24[rsp], rbx
	lea	rdx, _ZSt19piecewise_construct[rip]
.LEHB94:
	call	_ZNSt8_Rb_treeINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESt4pairIKS5_N9benchmark7CounterEESt10_Select1stISA_ESt4lessIS5_ESaISA_EE22_M_emplace_hint_uniqueIJRKSt21piecewise_construct_tSt5tupleIJOS5_EESL_IJEEEEESt17_Rb_tree_iteratorISA_ESt23_Rb_tree_const_iteratorISA_EDpOT_
.LEHE94:
	vmovsd	xmm1, QWORD PTR 8[rsp]
	mov	rbx, QWORD PTR 32[rsp]
	movabs	rcx, 4294967296001
	mov	QWORD PTR 72[rax], rcx
	vmovsd	QWORD PTR 64[rax], xmm1
	cmp	rbx, r14
	je	.L1035
.L1061:
	mov	rax, QWORD PTR 48[rsp]
	mov	rdi, rbx
	lea	rsi, 1[rax]
	call	_ZdlPvm@PLT
.L1035:
	mov	rax, QWORD PTR 72[rsp]
	sub	rax, QWORD PTR fs:40
	jne	.L1094
	add	rsp, 88
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	pop	rbx
	.cfi_def_cfa_offset 48
	pop	rbp
	.cfi_def_cfa_offset 40
	pop	r12
	.cfi_def_cfa_offset 32
	pop	r13
	.cfi_def_cfa_offset 24
	pop	r14
	.cfi_def_cfa_offset 16
	pop	r15
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L1089:
	.cfi_restore_state
	mov	rdx, r13
	mov	rsi, rbx
	call	memcmp@PLT
	test	eax, eax
	jne	.L1048
	lea	rax, -16[r13]
	test	eax, eax
	jns	.L1049
	jmp	.L1046
.L1036:
	mov	r12, QWORD PTR 16[rdi]
.LEHB95:
	call	_ZN9benchmark5State16StartKeepRunningEv@PLT
.LEHE95:
	test	r12, r12
	je	.L1037
	mov	rdx, QWORD PTR [rbx]
	mov	r9, QWORD PTR 8[rbx]
	cmp	r9, rdx
	je	.L1063
	.p2align 4,,10
	.p2align 3
.L1042:
	xor	r8d, r8d
	.p2align 4,,10
	.p2align 3
.L1040:
	mov	rsi, QWORD PTR 8[rdx]
	mov	rdi, QWORD PTR [rdx]
	add	rdx, 16
	call	_ZL18pow_asm_unrolled64mm
	add	r8, rax
	cmp	r9, rdx
	jne	.L1040
.L1039:
	test	r12, r12
	jle	.L1095
.L1041:
	sub	r12, 1
	je	.L1037
	mov	rdx, QWORD PTR [rbx]
	mov	r9, QWORD PTR 8[rbx]
	cmp	r9, rdx
	jne	.L1042
	xor	eax, eax
	jmp	.L1041
.L1093:
	mov	eax, 16
	sub	rax, r13
	cmp	rax, 2147483647
	jg	.L1053
	cmp	rax, -2147483648
	jl	.L1044
	test	eax, eax
	js	.L1044
.L1053:
	movabs	rax, 4294967296001
	vmovsd	xmm2, QWORD PTR 8[rsp]
	mov	QWORD PTR 72[r12], rax
	vmovsd	QWORD PTR 64[r12], xmm2
	jmp	.L1061
.L1092:
	test	r13, r13
	je	.L1053
	mov	rdx, r13
	mov	rdi, rbx
	call	memcmp@PLT
	test	eax, eax
	je	.L1053
	jmp	.L1055
.L1064:
	xor	edx, edx
	jmp	.L1043
.L1063:
	xor	r8d, r8d
	jmp	.L1039
.L1094:
	call	__stack_chk_fail@PLT
.L1095:
	lea	rcx, .LC74[rip]
	mov	edx, 234
	lea	rsi, .LC75[rip]
	lea	rdi, .LC76[rip]
	call	__assert_fail@PLT
.L1066:
	endbr64
	mov	rbp, rax
	jmp	.L1057
	.section	.gcc_except_table
.LLSDA6920:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSE6920-.LLSDACSB6920
.LLSDACSB6920:
	.uleb128 .LEHB93-.LFB6920
	.uleb128 .LEHE93-.LEHB93
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB94-.LFB6920
	.uleb128 .LEHE94-.LEHB94
	.uleb128 .L1066-.LFB6920
	.uleb128 0
	.uleb128 .LEHB95-.LFB6920
	.uleb128 .LEHE95-.LEHB95
	.uleb128 0
	.uleb128 0
.LLSDACSE6920:
	.text
	.cfi_endproc
	.section	.text.unlikely
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gxx_personality_v0
	.cfi_lsda 0x1b,.LLSDAC6920
	.type	_Z6BM_PowIXadL_ZL18pow_asm_unrolled64mmEEEvRN9benchmark5StateERKSt6vectorISt4pairImmESaIS5_EE.cold, @function
_Z6BM_PowIXadL_ZL18pow_asm_unrolled64mmEEEvRN9benchmark5StateERKSt6vectorISt4pairImmESaIS5_EE.cold:
.LFSB6920:
.L1057:
	.cfi_def_cfa_offset 144
	.cfi_offset 3, -56
	.cfi_offset 6, -48
	.cfi_offset 12, -40
	.cfi_offset 13, -32
	.cfi_offset 14, -24
	.cfi_offset 15, -16
	mov	rdi, rbx
	vzeroupper
	call	_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_disposeEv
	mov	rax, QWORD PTR 72[rsp]
	sub	rax, QWORD PTR fs:40
	jne	.L1096
	mov	rdi, rbp
.LEHB96:
	call	_Unwind_Resume@PLT
.LEHE96:
.L1096:
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE6920:
	.section	.gcc_except_table
.LLSDAC6920:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSEC6920-.LLSDACSBC6920
.LLSDACSBC6920:
	.uleb128 .LEHB96-.LCOLDB82
	.uleb128 .LEHE96-.LEHB96
	.uleb128 0
	.uleb128 0
.LLSDACSEC6920:
	.section	.text.unlikely
	.text
	.size	_Z6BM_PowIXadL_ZL18pow_asm_unrolled64mmEEEvRN9benchmark5StateERKSt6vectorISt4pairImmESaIS5_EE, .-_Z6BM_PowIXadL_ZL18pow_asm_unrolled64mmEEEvRN9benchmark5StateERKSt6vectorISt4pairImmESaIS5_EE
	.section	.text.unlikely
	.size	_Z6BM_PowIXadL_ZL18pow_asm_unrolled64mmEEEvRN9benchmark5StateERKSt6vectorISt4pairImmESaIS5_EE.cold, .-_Z6BM_PowIXadL_ZL18pow_asm_unrolled64mmEEEvRN9benchmark5StateERKSt6vectorISt4pairImmESaIS5_EE.cold
.LCOLDE82:
	.text
.LHOTE82:
	.p2align 4
	.type	_ZL20BM_AsmUnrolled_LargeRN9benchmark5StateE, @function
_ZL20BM_AsmUnrolled_LargeRN9benchmark5StateE:
.LFB6369:
	.cfi_startproc
	endbr64
	lea	rsi, _ZL9kLargeExp[rip]
	jmp	_Z6BM_PowIXadL_ZL18pow_asm_unrolled64mmEEEvRN9benchmark5StateERKSt6vectorISt4pairImmESaIS5_EE
	.cfi_endproc
.LFE6369:
	.size	_ZL20BM_AsmUnrolled_LargeRN9benchmark5StateE, .-_ZL20BM_AsmUnrolled_LargeRN9benchmark5StateE
	.p2align 4
	.type	_ZL18BM_AsmUnrolled_MedRN9benchmark5StateE, @function
_ZL18BM_AsmUnrolled_MedRN9benchmark5StateE:
.LFB6362:
	.cfi_startproc
	endbr64
	lea	rsi, _ZL7kMedExp[rip]
	jmp	_Z6BM_PowIXadL_ZL18pow_asm_unrolled64mmEEEvRN9benchmark5StateERKSt6vectorISt4pairImmESaIS5_EE
	.cfi_endproc
.LFE6362:
	.size	_ZL18BM_AsmUnrolled_MedRN9benchmark5StateE, .-_ZL18BM_AsmUnrolled_MedRN9benchmark5StateE
	.p2align 4
	.type	_ZL20BM_AsmUnrolled_SmallRN9benchmark5StateE, @function
_ZL20BM_AsmUnrolled_SmallRN9benchmark5StateE:
.LFB6355:
	.cfi_startproc
	endbr64
	lea	rsi, _ZL9kSmallExp[rip]
	jmp	_Z6BM_PowIXadL_ZL18pow_asm_unrolled64mmEEEvRN9benchmark5StateERKSt6vectorISt4pairImmESaIS5_EE
	.cfi_endproc
.LFE6355:
	.size	_ZL20BM_AsmUnrolled_SmallRN9benchmark5StateE, .-_ZL20BM_AsmUnrolled_SmallRN9benchmark5StateE
	.section	.text.unlikely
.LCOLDB83:
	.text
.LHOTB83:
	.p2align 4
	.type	_Z6BM_PowIXadL_ZL11wrap_binarymmEEEvRN9benchmark5StateERKSt6vectorISt4pairImmESaIS5_EE, @function
_Z6BM_PowIXadL_ZL11wrap_binarymmEEEvRN9benchmark5StateERKSt6vectorISt4pairImmESaIS5_EE:
.LFB6917:
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gxx_personality_v0
	.cfi_lsda 0x1b,.LLSDA6917
	push	r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	push	r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	push	r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	push	r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	push	rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	mov	rbp, rdi
	push	rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	mov	rbx, rsi
	sub	rsp, 88
	.cfi_def_cfa_offset 144
	mov	rax, QWORD PTR fs:40
	mov	QWORD PTR 72[rsp], rax
	xor	eax, eax
	mov	eax, DWORD PTR 28[rdi]
	test	eax, eax
	je	.L1101
.LEHB97:
	call	_ZN9benchmark5State16StartKeepRunningEv@PLT
.L1102:
	mov	rdi, rbp
	call	_ZN9benchmark5State17FinishKeepRunningEv@PLT
	cmp	BYTE PTR 24[rbp], 0
	je	.L1129
	mov	rdx, QWORD PTR 16[rbp]
	sub	rdx, QWORD PTR 0[rbp]
	add	rdx, QWORD PTR 8[rbp]
.L1108:
	mov	rax, QWORD PTR 8[rbx]
	sub	rax, QWORD PTR [rbx]
	vxorps	xmm0, xmm0, xmm0
	lea	r14, 48[rsp]
	sar	rax, 4
	mov	edi, 17
	mov	QWORD PTR 32[rsp], r14
	imul	rax, rdx
	vcvtsi2sd	xmm0, xmm0, rax
	vmovsd	QWORD PTR 8[rsp], xmm0
	call	_Znwm@PLT
.LEHE97:
	vmovdqa	xmm0, XMMWORD PTR .LC77[rip]
	mov	r15, QWORD PTR 80[rbp]
	mov	QWORD PTR 48[rsp], 16
	mov	QWORD PTR 32[rsp], rax
	mov	rbx, rax
	mov	BYTE PTR 16[rax], 0
	vmovdqu	XMMWORD PTR [rax], xmm0
	lea	rax, 72[rbp]
	mov	QWORD PTR 40[rsp], 16
	mov	r12, rax
	mov	QWORD PTR [rsp], rax
	test	r15, r15
	jne	.L1116
	jmp	.L1109
	.p2align 4,,10
	.p2align 3
.L1156:
	test	r13, r13
	jne	.L1154
.L1111:
	mov	r15, QWORD PTR 24[r15]
	test	r15, r15
	je	.L1155
.L1116:
	mov	r13, QWORD PTR 40[r15]
	mov	rdi, QWORD PTR 32[r15]
	cmp	r13, 16
	jbe	.L1156
	mov	edx, 16
	mov	rsi, rbx
	call	memcmp@PLT
	test	eax, eax
	jne	.L1113
	lea	rax, -16[r13]
	cmp	rax, 2147483647
	jg	.L1114
	cmp	rax, -2147483648
	jl	.L1111
	.p2align 4,,10
	.p2align 3
.L1113:
	test	eax, eax
	js	.L1111
.L1114:
	mov	r12, r15
	mov	r15, QWORD PTR 16[r15]
	test	r15, r15
	jne	.L1116
.L1155:
	cmp	QWORD PTR [rsp], r12
	je	.L1109
	mov	r13, QWORD PTR 40[r12]
	mov	rsi, QWORD PTR 32[r12]
	cmp	r13, 15
	jbe	.L1157
	mov	edx, 16
	mov	rdi, rbx
	call	memcmp@PLT
	test	eax, eax
	je	.L1158
.L1120:
	test	eax, eax
	jns	.L1118
.L1109:
	lea	rbx, 32[rsp]
	lea	rcx, 24[rsp]
	mov	rsi, r12
	lea	rdi, 64[rbp]
	lea	r8, 23[rsp]
	mov	QWORD PTR 24[rsp], rbx
	lea	rdx, _ZSt19piecewise_construct[rip]
.LEHB98:
	call	_ZNSt8_Rb_treeINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESt4pairIKS5_N9benchmark7CounterEESt10_Select1stISA_ESt4lessIS5_ESaISA_EE22_M_emplace_hint_uniqueIJRKSt21piecewise_construct_tSt5tupleIJOS5_EESL_IJEEEEESt17_Rb_tree_iteratorISA_ESt23_Rb_tree_const_iteratorISA_EDpOT_
.LEHE98:
	vmovsd	xmm1, QWORD PTR 8[rsp]
	mov	rbx, QWORD PTR 32[rsp]
	movabs	rcx, 4294967296001
	mov	QWORD PTR 72[rax], rcx
	vmovsd	QWORD PTR 64[rax], xmm1
	cmp	rbx, r14
	je	.L1100
.L1126:
	mov	rax, QWORD PTR 48[rsp]
	mov	rdi, rbx
	lea	rsi, 1[rax]
	call	_ZdlPvm@PLT
.L1100:
	mov	rax, QWORD PTR 72[rsp]
	sub	rax, QWORD PTR fs:40
	jne	.L1159
	add	rsp, 88
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	pop	rbx
	.cfi_def_cfa_offset 48
	pop	rbp
	.cfi_def_cfa_offset 40
	pop	r12
	.cfi_def_cfa_offset 32
	pop	r13
	.cfi_def_cfa_offset 24
	pop	r14
	.cfi_def_cfa_offset 16
	pop	r15
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L1154:
	.cfi_restore_state
	mov	rdx, r13
	mov	rsi, rbx
	call	memcmp@PLT
	test	eax, eax
	jne	.L1113
	lea	rax, -16[r13]
	test	eax, eax
	jns	.L1114
	jmp	.L1111
.L1101:
	mov	r12, QWORD PTR 16[rdi]
.LEHB99:
	call	_ZN9benchmark5State16StartKeepRunningEv@PLT
.LEHE99:
	test	r12, r12
	je	.L1102
	mov	rdx, QWORD PTR [rbx]
	mov	r8, QWORD PTR 8[rbx]
	cmp	r8, rdx
	je	.L1128
	.p2align 4,,10
	.p2align 3
.L1107:
	xor	ecx, ecx
	.p2align 4,,10
	.p2align 3
.L1105:
	mov	rsi, QWORD PTR 8[rdx]
	mov	rdi, QWORD PTR [rdx]
	add	rdx, 16
	call	_ZL11wrap_binarymm
	add	rcx, rax
	cmp	rdx, r8
	jne	.L1105
.L1104:
	test	r12, r12
	jle	.L1160
.L1106:
	sub	r12, 1
	je	.L1102
	mov	rdx, QWORD PTR [rbx]
	mov	r8, QWORD PTR 8[rbx]
	cmp	r8, rdx
	jne	.L1107
	xor	eax, eax
	jmp	.L1106
.L1158:
	mov	eax, 16
	sub	rax, r13
	cmp	rax, 2147483647
	jg	.L1118
	cmp	rax, -2147483648
	jl	.L1109
	test	eax, eax
	js	.L1109
.L1118:
	movabs	rax, 4294967296001
	vmovsd	xmm2, QWORD PTR 8[rsp]
	mov	QWORD PTR 72[r12], rax
	vmovsd	QWORD PTR 64[r12], xmm2
	jmp	.L1126
.L1157:
	test	r13, r13
	je	.L1118
	mov	rdx, r13
	mov	rdi, rbx
	call	memcmp@PLT
	test	eax, eax
	je	.L1118
	jmp	.L1120
.L1128:
	xor	ecx, ecx
	jmp	.L1104
.L1129:
	xor	edx, edx
	jmp	.L1108
.L1159:
	call	__stack_chk_fail@PLT
.L1160:
	lea	rcx, .LC74[rip]
	mov	edx, 234
	lea	rsi, .LC75[rip]
	lea	rdi, .LC76[rip]
	call	__assert_fail@PLT
.L1131:
	endbr64
	mov	rbp, rax
	jmp	.L1122
	.section	.gcc_except_table
.LLSDA6917:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSE6917-.LLSDACSB6917
.LLSDACSB6917:
	.uleb128 .LEHB97-.LFB6917
	.uleb128 .LEHE97-.LEHB97
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB98-.LFB6917
	.uleb128 .LEHE98-.LEHB98
	.uleb128 .L1131-.LFB6917
	.uleb128 0
	.uleb128 .LEHB99-.LFB6917
	.uleb128 .LEHE99-.LEHB99
	.uleb128 0
	.uleb128 0
.LLSDACSE6917:
	.text
	.cfi_endproc
	.section	.text.unlikely
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gxx_personality_v0
	.cfi_lsda 0x1b,.LLSDAC6917
	.type	_Z6BM_PowIXadL_ZL11wrap_binarymmEEEvRN9benchmark5StateERKSt6vectorISt4pairImmESaIS5_EE.cold, @function
_Z6BM_PowIXadL_ZL11wrap_binarymmEEEvRN9benchmark5StateERKSt6vectorISt4pairImmESaIS5_EE.cold:
.LFSB6917:
.L1122:
	.cfi_def_cfa_offset 144
	.cfi_offset 3, -56
	.cfi_offset 6, -48
	.cfi_offset 12, -40
	.cfi_offset 13, -32
	.cfi_offset 14, -24
	.cfi_offset 15, -16
	mov	rdi, rbx
	vzeroupper
	call	_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_disposeEv
	mov	rax, QWORD PTR 72[rsp]
	sub	rax, QWORD PTR fs:40
	jne	.L1161
	mov	rdi, rbp
.LEHB100:
	call	_Unwind_Resume@PLT
.LEHE100:
.L1161:
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE6917:
	.section	.gcc_except_table
.LLSDAC6917:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSEC6917-.LLSDACSBC6917
.LLSDACSBC6917:
	.uleb128 .LEHB100-.LCOLDB83
	.uleb128 .LEHE100-.LEHB100
	.uleb128 0
	.uleb128 0
.LLSDACSEC6917:
	.section	.text.unlikely
	.text
	.size	_Z6BM_PowIXadL_ZL11wrap_binarymmEEEvRN9benchmark5StateERKSt6vectorISt4pairImmESaIS5_EE, .-_Z6BM_PowIXadL_ZL11wrap_binarymmEEEvRN9benchmark5StateERKSt6vectorISt4pairImmESaIS5_EE
	.section	.text.unlikely
	.size	_Z6BM_PowIXadL_ZL11wrap_binarymmEEEvRN9benchmark5StateERKSt6vectorISt4pairImmESaIS5_EE.cold, .-_Z6BM_PowIXadL_ZL11wrap_binarymmEEEvRN9benchmark5StateERKSt6vectorISt4pairImmESaIS5_EE.cold
.LCOLDE83:
	.text
.LHOTE83:
	.p2align 4
	.type	_ZL15BM_Binary_LargeRN9benchmark5StateE, @function
_ZL15BM_Binary_LargeRN9benchmark5StateE:
.LFB6366:
	.cfi_startproc
	endbr64
	lea	rsi, _ZL9kLargeExp[rip]
	jmp	_Z6BM_PowIXadL_ZL11wrap_binarymmEEEvRN9benchmark5StateERKSt6vectorISt4pairImmESaIS5_EE
	.cfi_endproc
.LFE6366:
	.size	_ZL15BM_Binary_LargeRN9benchmark5StateE, .-_ZL15BM_Binary_LargeRN9benchmark5StateE
	.p2align 4
	.type	_ZL13BM_Binary_MedRN9benchmark5StateE, @function
_ZL13BM_Binary_MedRN9benchmark5StateE:
.LFB6359:
	.cfi_startproc
	endbr64
	lea	rsi, _ZL7kMedExp[rip]
	jmp	_Z6BM_PowIXadL_ZL11wrap_binarymmEEEvRN9benchmark5StateERKSt6vectorISt4pairImmESaIS5_EE
	.cfi_endproc
.LFE6359:
	.size	_ZL13BM_Binary_MedRN9benchmark5StateE, .-_ZL13BM_Binary_MedRN9benchmark5StateE
	.p2align 4
	.type	_ZL15BM_Binary_SmallRN9benchmark5StateE, @function
_ZL15BM_Binary_SmallRN9benchmark5StateE:
.LFB6352:
	.cfi_startproc
	endbr64
	lea	rsi, _ZL9kSmallExp[rip]
	jmp	_Z6BM_PowIXadL_ZL11wrap_binarymmEEEvRN9benchmark5StateERKSt6vectorISt4pairImmESaIS5_EE
	.cfi_endproc
.LFE6352:
	.size	_ZL15BM_Binary_SmallRN9benchmark5StateE, .-_ZL15BM_Binary_SmallRN9benchmark5StateE
	.section	.text.unlikely
.LCOLDB84:
	.text
.LHOTB84:
	.p2align 4
	.type	_Z6BM_PowIXadL_ZL12pow_asm_cmovmmEEEvRN9benchmark5StateERKSt6vectorISt4pairImmESaIS5_EE, @function
_Z6BM_PowIXadL_ZL12pow_asm_cmovmmEEEvRN9benchmark5StateERKSt6vectorISt4pairImmESaIS5_EE:
.LFB6919:
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gxx_personality_v0
	.cfi_lsda 0x1b,.LLSDA6919
	push	r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	push	r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	push	r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	push	r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	push	rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	mov	rbp, rdi
	push	rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	mov	rbx, rsi
	sub	rsp, 88
	.cfi_def_cfa_offset 144
	mov	rax, QWORD PTR fs:40
	mov	QWORD PTR 72[rsp], rax
	xor	eax, eax
	mov	eax, DWORD PTR 28[rdi]
	test	eax, eax
	je	.L1166
.LEHB101:
	call	_ZN9benchmark5State16StartKeepRunningEv@PLT
.L1167:
	mov	rdi, rbp
	call	_ZN9benchmark5State17FinishKeepRunningEv@PLT
	cmp	BYTE PTR 24[rbp], 0
	je	.L1194
	mov	rdx, QWORD PTR 16[rbp]
	sub	rdx, QWORD PTR 0[rbp]
	add	rdx, QWORD PTR 8[rbp]
.L1173:
	mov	rax, QWORD PTR 8[rbx]
	sub	rax, QWORD PTR [rbx]
	vxorps	xmm0, xmm0, xmm0
	lea	r14, 48[rsp]
	sar	rax, 4
	mov	edi, 17
	mov	QWORD PTR 32[rsp], r14
	imul	rax, rdx
	vcvtsi2sd	xmm0, xmm0, rax
	vmovsd	QWORD PTR 8[rsp], xmm0
	call	_Znwm@PLT
.LEHE101:
	vmovdqa	xmm0, XMMWORD PTR .LC77[rip]
	mov	r15, QWORD PTR 80[rbp]
	mov	QWORD PTR 48[rsp], 16
	mov	QWORD PTR 32[rsp], rax
	mov	rbx, rax
	mov	BYTE PTR 16[rax], 0
	vmovdqu	XMMWORD PTR [rax], xmm0
	lea	rax, 72[rbp]
	mov	QWORD PTR 40[rsp], 16
	mov	r12, rax
	mov	QWORD PTR [rsp], rax
	test	r15, r15
	jne	.L1181
	jmp	.L1174
	.p2align 4,,10
	.p2align 3
.L1221:
	test	r13, r13
	jne	.L1219
.L1176:
	mov	r15, QWORD PTR 24[r15]
	test	r15, r15
	je	.L1220
.L1181:
	mov	r13, QWORD PTR 40[r15]
	mov	rdi, QWORD PTR 32[r15]
	cmp	r13, 16
	jbe	.L1221
	mov	edx, 16
	mov	rsi, rbx
	call	memcmp@PLT
	test	eax, eax
	jne	.L1178
	lea	rax, -16[r13]
	cmp	rax, 2147483647
	jg	.L1179
	cmp	rax, -2147483648
	jl	.L1176
	.p2align 4,,10
	.p2align 3
.L1178:
	test	eax, eax
	js	.L1176
.L1179:
	mov	r12, r15
	mov	r15, QWORD PTR 16[r15]
	test	r15, r15
	jne	.L1181
.L1220:
	cmp	QWORD PTR [rsp], r12
	je	.L1174
	mov	r13, QWORD PTR 40[r12]
	mov	rsi, QWORD PTR 32[r12]
	cmp	r13, 15
	jbe	.L1222
	mov	edx, 16
	mov	rdi, rbx
	call	memcmp@PLT
	test	eax, eax
	je	.L1223
.L1185:
	test	eax, eax
	jns	.L1183
.L1174:
	lea	rbx, 32[rsp]
	lea	rcx, 24[rsp]
	mov	rsi, r12
	lea	rdi, 64[rbp]
	lea	r8, 23[rsp]
	mov	QWORD PTR 24[rsp], rbx
	lea	rdx, _ZSt19piecewise_construct[rip]
.LEHB102:
	call	_ZNSt8_Rb_treeINSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESt4pairIKS5_N9benchmark7CounterEESt10_Select1stISA_ESt4lessIS5_ESaISA_EE22_M_emplace_hint_uniqueIJRKSt21piecewise_construct_tSt5tupleIJOS5_EESL_IJEEEEESt17_Rb_tree_iteratorISA_ESt23_Rb_tree_const_iteratorISA_EDpOT_
.LEHE102:
	vmovsd	xmm1, QWORD PTR 8[rsp]
	mov	rbx, QWORD PTR 32[rsp]
	movabs	rcx, 4294967296001
	mov	QWORD PTR 72[rax], rcx
	vmovsd	QWORD PTR 64[rax], xmm1
	cmp	rbx, r14
	je	.L1165
.L1191:
	mov	rax, QWORD PTR 48[rsp]
	mov	rdi, rbx
	lea	rsi, 1[rax]
	call	_ZdlPvm@PLT
.L1165:
	mov	rax, QWORD PTR 72[rsp]
	sub	rax, QWORD PTR fs:40
	jne	.L1224
	add	rsp, 88
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	pop	rbx
	.cfi_def_cfa_offset 48
	pop	rbp
	.cfi_def_cfa_offset 40
	pop	r12
	.cfi_def_cfa_offset 32
	pop	r13
	.cfi_def_cfa_offset 24
	pop	r14
	.cfi_def_cfa_offset 16
	pop	r15
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L1219:
	.cfi_restore_state
	mov	rdx, r13
	mov	rsi, rbx
	call	memcmp@PLT
	test	eax, eax
	jne	.L1178
	lea	rax, -16[r13]
	test	eax, eax
	jns	.L1179
	jmp	.L1176
.L1166:
	mov	r12, QWORD PTR 16[rdi]
.LEHB103:
	call	_ZN9benchmark5State16StartKeepRunningEv@PLT
.LEHE103:
	test	r12, r12
	je	.L1167
	mov	rdx, QWORD PTR [rbx]
	mov	r9, QWORD PTR 8[rbx]
	cmp	r9, rdx
	je	.L1193
	.p2align 4,,10
	.p2align 3
.L1172:
	xor	r8d, r8d
	.p2align 4,,10
	.p2align 3
.L1170:
	mov	rsi, QWORD PTR 8[rdx]
	mov	rdi, QWORD PTR [rdx]
	add	rdx, 16
	call	_ZL12pow_asm_cmovmm
	add	r8, rax
	cmp	r9, rdx
	jne	.L1170
.L1169:
	test	r12, r12
	jle	.L1225
.L1171:
	sub	r12, 1
	je	.L1167
	mov	rdx, QWORD PTR [rbx]
	mov	r9, QWORD PTR 8[rbx]
	cmp	r9, rdx
	jne	.L1172
	xor	eax, eax
	jmp	.L1171
.L1223:
	mov	eax, 16
	sub	rax, r13
	cmp	rax, 2147483647
	jg	.L1183
	cmp	rax, -2147483648
	jl	.L1174
	test	eax, eax
	js	.L1174
.L1183:
	movabs	rax, 4294967296001
	vmovsd	xmm2, QWORD PTR 8[rsp]
	mov	QWORD PTR 72[r12], rax
	vmovsd	QWORD PTR 64[r12], xmm2
	jmp	.L1191
.L1222:
	test	r13, r13
	je	.L1183
	mov	rdx, r13
	mov	rdi, rbx
	call	memcmp@PLT
	test	eax, eax
	je	.L1183
	jmp	.L1185
.L1194:
	xor	edx, edx
	jmp	.L1173
.L1193:
	xor	r8d, r8d
	jmp	.L1169
.L1224:
	call	__stack_chk_fail@PLT
.L1225:
	lea	rcx, .LC74[rip]
	mov	edx, 234
	lea	rsi, .LC75[rip]
	lea	rdi, .LC76[rip]
	call	__assert_fail@PLT
.L1196:
	endbr64
	mov	rbp, rax
	jmp	.L1187
	.section	.gcc_except_table
.LLSDA6919:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSE6919-.LLSDACSB6919
.LLSDACSB6919:
	.uleb128 .LEHB101-.LFB6919
	.uleb128 .LEHE101-.LEHB101
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB102-.LFB6919
	.uleb128 .LEHE102-.LEHB102
	.uleb128 .L1196-.LFB6919
	.uleb128 0
	.uleb128 .LEHB103-.LFB6919
	.uleb128 .LEHE103-.LEHB103
	.uleb128 0
	.uleb128 0
.LLSDACSE6919:
	.text
	.cfi_endproc
	.section	.text.unlikely
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gxx_personality_v0
	.cfi_lsda 0x1b,.LLSDAC6919
	.type	_Z6BM_PowIXadL_ZL12pow_asm_cmovmmEEEvRN9benchmark5StateERKSt6vectorISt4pairImmESaIS5_EE.cold, @function
_Z6BM_PowIXadL_ZL12pow_asm_cmovmmEEEvRN9benchmark5StateERKSt6vectorISt4pairImmESaIS5_EE.cold:
.LFSB6919:
.L1187:
	.cfi_def_cfa_offset 144
	.cfi_offset 3, -56
	.cfi_offset 6, -48
	.cfi_offset 12, -40
	.cfi_offset 13, -32
	.cfi_offset 14, -24
	.cfi_offset 15, -16
	mov	rdi, rbx
	vzeroupper
	call	_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_disposeEv
	mov	rax, QWORD PTR 72[rsp]
	sub	rax, QWORD PTR fs:40
	jne	.L1226
	mov	rdi, rbp
.LEHB104:
	call	_Unwind_Resume@PLT
.LEHE104:
.L1226:
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE6919:
	.section	.gcc_except_table
.LLSDAC6919:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSEC6919-.LLSDACSBC6919
.LLSDACSBC6919:
	.uleb128 .LEHB104-.LCOLDB84
	.uleb128 .LEHE104-.LEHB104
	.uleb128 0
	.uleb128 0
.LLSDACSEC6919:
	.section	.text.unlikely
	.text
	.size	_Z6BM_PowIXadL_ZL12pow_asm_cmovmmEEEvRN9benchmark5StateERKSt6vectorISt4pairImmESaIS5_EE, .-_Z6BM_PowIXadL_ZL12pow_asm_cmovmmEEEvRN9benchmark5StateERKSt6vectorISt4pairImmESaIS5_EE
	.section	.text.unlikely
	.size	_Z6BM_PowIXadL_ZL12pow_asm_cmovmmEEEvRN9benchmark5StateERKSt6vectorISt4pairImmESaIS5_EE.cold, .-_Z6BM_PowIXadL_ZL12pow_asm_cmovmmEEEvRN9benchmark5StateERKSt6vectorISt4pairImmESaIS5_EE.cold
.LCOLDE84:
	.text
.LHOTE84:
	.p2align 4
	.type	_ZL16BM_AsmCmov_LargeRN9benchmark5StateE, @function
_ZL16BM_AsmCmov_LargeRN9benchmark5StateE:
.LFB6368:
	.cfi_startproc
	endbr64
	lea	rsi, _ZL9kLargeExp[rip]
	jmp	_Z6BM_PowIXadL_ZL12pow_asm_cmovmmEEEvRN9benchmark5StateERKSt6vectorISt4pairImmESaIS5_EE
	.cfi_endproc
.LFE6368:
	.size	_ZL16BM_AsmCmov_LargeRN9benchmark5StateE, .-_ZL16BM_AsmCmov_LargeRN9benchmark5StateE
	.p2align 4
	.type	_ZL14BM_AsmCmov_MedRN9benchmark5StateE, @function
_ZL14BM_AsmCmov_MedRN9benchmark5StateE:
.LFB6361:
	.cfi_startproc
	endbr64
	lea	rsi, _ZL7kMedExp[rip]
	jmp	_Z6BM_PowIXadL_ZL12pow_asm_cmovmmEEEvRN9benchmark5StateERKSt6vectorISt4pairImmESaIS5_EE
	.cfi_endproc
.LFE6361:
	.size	_ZL14BM_AsmCmov_MedRN9benchmark5StateE, .-_ZL14BM_AsmCmov_MedRN9benchmark5StateE
	.p2align 4
	.type	_ZL16BM_AsmCmov_SmallRN9benchmark5StateE, @function
_ZL16BM_AsmCmov_SmallRN9benchmark5StateE:
.LFB6354:
	.cfi_startproc
	endbr64
	lea	rsi, _ZL9kSmallExp[rip]
	jmp	_Z6BM_PowIXadL_ZL12pow_asm_cmovmmEEEvRN9benchmark5StateERKSt6vectorISt4pairImmESaIS5_EE
	.cfi_endproc
.LFE6354:
	.size	_ZL16BM_AsmCmov_SmallRN9benchmark5StateE, .-_ZL16BM_AsmCmov_SmallRN9benchmark5StateE
	.section	.text.startup
	.p2align 4
	.type	_GLOBAL__sub_I_main, @function
_GLOBAL__sub_I_main:
.LFB7830:
	.cfi_startproc
	endbr64
	jmp	_Z41__static_initialization_and_destruction_0v
	.cfi_endproc
.LFE7830:
	.size	_GLOBAL__sub_I_main, .-_GLOBAL__sub_I_main
	.section	.init_array,"aw"
	.align 8
	.quad	_GLOBAL__sub_I_main
	.local	_ZL9kLargeExp
	.comm	_ZL9kLargeExp,24,16
	.local	_ZL7kMedExp
	.comm	_ZL7kMedExp,24,16
	.local	_ZL9kSmallExp
	.comm	_ZL9kSmallExp,24,16
	.weak	_ZSt19piecewise_construct
	.section	.rodata._ZSt19piecewise_construct,"aG",@progbits,_ZSt19piecewise_construct,comdat
	.type	_ZSt19piecewise_construct, @gnu_unique_object
	.size	_ZSt19piecewise_construct, 1
_ZSt19piecewise_construct:
	.zero	1
	.section	.rodata.cst32,"aM",@progbits,32
	.align 32
.LC3:
	.quad	0
	.quad	1
	.quad	2
	.quad	3
	.align 32
.LC4:
	.quad	5
	.quad	7
	.quad	10
	.quad	13
	.section	.rodata.cst16,"aM",@progbits,16
	.align 16
.LC5:
	.quad	100
	.quad	12345
	.section	.rodata.cst32
	.align 32
.LC6:
	.quad	4
	.quad	5
	.quad	8
	.quad	10
	.align 32
.LC7:
	.quad	13
	.quad	20
	.quad	30
	.quad	40
	.align 32
.LC23:
	.quad	2
	.quad	1
	.quad	2
	.quad	2
	.align 32
.LC24:
	.quad	2
	.quad	3
	.quad	2
	.quad	5
	.align 32
.LC25:
	.quad	2
	.quad	8
	.quad	2
	.quad	10
	.align 32
.LC26:
	.quad	3
	.quad	1
	.quad	3
	.quad	2
	.align 32
.LC27:
	.quad	3
	.quad	3
	.quad	3
	.quad	5
	.align 32
.LC28:
	.quad	3
	.quad	8
	.quad	3
	.quad	10
	.align 32
.LC29:
	.quad	5
	.quad	1
	.quad	5
	.quad	2
	.align 32
.LC30:
	.quad	5
	.quad	3
	.quad	5
	.quad	5
	.align 32
.LC31:
	.quad	5
	.quad	8
	.quad	5
	.quad	10
	.align 32
.LC32:
	.quad	7
	.quad	1
	.quad	7
	.quad	2
	.align 32
.LC33:
	.quad	7
	.quad	3
	.quad	7
	.quad	5
	.align 32
.LC34:
	.quad	7
	.quad	8
	.quad	7
	.quad	10
	.align 32
.LC35:
	.quad	2
	.quad	10
	.quad	2
	.quad	15
	.align 32
.LC36:
	.quad	2
	.quad	20
	.quad	2
	.quad	25
	.align 32
.LC37:
	.quad	2
	.quad	30
	.quad	3
	.quad	10
	.align 32
.LC38:
	.quad	3
	.quad	15
	.quad	3
	.quad	20
	.align 32
.LC39:
	.quad	3
	.quad	25
	.quad	3
	.quad	30
	.align 32
.LC40:
	.quad	5
	.quad	10
	.quad	5
	.quad	15
	.align 32
.LC41:
	.quad	5
	.quad	20
	.quad	5
	.quad	25
	.align 32
.LC42:
	.quad	5
	.quad	30
	.quad	7
	.quad	10
	.align 32
.LC43:
	.quad	7
	.quad	15
	.quad	7
	.quad	20
	.align 32
.LC44:
	.quad	7
	.quad	25
	.quad	7
	.quad	30
	.align 32
.LC45:
	.quad	2
	.quad	30
	.quad	2
	.quad	40
	.align 32
.LC46:
	.quad	2
	.quad	50
	.quad	2
	.quad	60
	.align 32
.LC47:
	.quad	2
	.quad	63
	.quad	3
	.quad	30
	.align 32
.LC48:
	.quad	3
	.quad	35
	.quad	3
	.quad	40
	.align 32
.LC49:
	.quad	5
	.quad	25
	.quad	5
	.quad	27
	.align 32
.LC50:
	.quad	7
	.quad	20
	.quad	7
	.quad	22
	.align 32
.LC51:
	.quad	13
	.quad	15
	.quad	13
	.quad	17
	.section	.rodata.cst16
	.align 16
.LC52:
	.quad	100
	.quad	9
	.align 16
.LC71:
	.quad	7301584523343383874
	.quad	7299595546252111474
	.align 16
.LC77:
	.quad	7309447144583558249
	.quad	7236844123925471090
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
