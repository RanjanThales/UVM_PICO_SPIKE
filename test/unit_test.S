
.macro init
.endm
.section .text.init
.globl _start
.option norvc
.org 0x00
_start:

li a0, 5
li a1, 10
li a3, 15
add a2, a0, a1
bne a2, a3, csr_fail

li a4, 15
li a5, 15
li a6, 30
add a7, a5, a4
bne a5, a6, csr_fail


csr_pass:
    li x1, 0
    slli x1, x1, 1
    addi x1, x1, 1

csr_fail:
    li x1, 1
    slli x1, x1, 1
    addi x1, x1, 1
    ebreak

