.section .bss
.align 16
stack_bottom:
.skip 16384
stack_top:

.section .text.boot
.global _start
.type _start, @function
_start:
    cli
    lea stack_top(%rip), %rsp
    xor %rbp, %rbp
    call kernel_main
.hang:
    cli
    hlt
    jmp .hang
.size _start, . - _start
