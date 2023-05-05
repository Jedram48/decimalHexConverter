DECIMAL equ 123456

section .bss
	digitSpace resb 6
	digitSpacePos resb 4

section .text
	global _start

_start:
	mov eax, DECIMAL
	call _print

	mov eax, 1
	int 0x80

_print:
	mov ecx, digitSpace
	mov ebx, 10
	mov [ecx], ebx
	inc ecx
	mov [digitSpacePos], ecx

_printLoop:
	mov edx, 0
	mov ebx, 16
	div ebx
	push eax

	cmp edx, 9
	jg _addHex
	add edx, 48
	jmp _subPrintLoop

	_addHex:
	add edx, 55

	_subPrintLoop:
	mov ecx, [digitSpacePos]
	mov [ecx], edx
	inc ecx
	mov [digitSpacePos], ecx

	pop eax
	cmp eax, 0
	jne _printLoop

_printLoop2:
	mov ecx, [digitSpacePos]

	mov eax, 4
	mov ebx, 1
	mov edx, 1
	int 0x80

	mov ecx, [digitSpacePos]
	dec ecx
	mov [digitSpacePos], ecx

	cmp ecx, digitSpace
	jge _printLoop2

	ret
