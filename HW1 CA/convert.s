.global convert
.type matrix_mul, %function

.align 2
# int convert(char *);
convert:                                # @convert
        addi    sp, sp, -48
        sd      ra, 40(sp)
        sd      s0, 32(sp)
        addi    s0, sp, 48
        sd      a0, -32(s0)
        mv      a0, zero
        sw      a0, -36(s0)
        sw      a0, -40(s0)
        sw      a0, -44(s0)
        ld      a0, -32(s0)
        lbu     a0, 0(a0)
        addi    a1, zero, 43
        bne     a0, a1, .LBB0_2
        j       .LBB0_1
.LBB0_1:
        addi    a0, zero, 1
        sw      a0, -44(s0)
        j       .LBB0_5
.LBB0_2:
        ld      a0, -32(s0)
        lbu     a0, 0(a0)
        addi    a1, zero, 45
        bne     a0, a1, .LBB0_4
        j       .LBB0_3
.LBB0_3:
        addi    a0, zero, 1
        slli    a0, a0, 32
        addi    a0, a0, -1
        sw      a0, -40(s0)
        j       .LBB0_4
.LBB0_4:
        j       .LBB0_5
.LBB0_5:
        lw      a0, -40(s0)
        addi    a1, zero, -1
        bne     a0, a1, .LBB0_7
        j       .LBB0_6
.LBB0_6:
        addi    a0, zero, 1
        sw      a0, -44(s0)
        j       .LBB0_7
.LBB0_7:
        lw      a0, -44(s0)
        sw      a0, -48(s0)
        j       .LBB0_8
.LBB0_8:                                # =>This Inner Loop Header: Depth=1
        ld      a0, -32(s0)
        lw      a1, -48(s0)
        add     a0, a0, a1
        lbu     a0, 0(a0)
        mv      a1, zero
        beq     a0, a1, .LBB0_14
        j       .LBB0_9
.LBB0_9:                                #   in Loop: Header=BB0_8 Depth=1
        ld      a0, -32(s0)
        lw      a1, -48(s0)
        add     a0, a0, a1
        lbu     a0, 0(a0)
        addi    a1, zero, 48
        blt     a0, a1, .LBB0_11
        j       .LBB0_10
.LBB0_10:                               #   in Loop: Header=BB0_8 Depth=1
        ld      a0, -32(s0)
        lw      a1, -48(s0)
        add     a0, a0, a1
        lbu     a0, 0(a0)
        addi    a1, zero, 58
        blt     a0, a1, .LBB0_12
        j       .LBB0_11
.LBB0_11:
        addi    a0, zero, 1
        slli    a0, a0, 32
        addi    a0, a0, -1
        sw      a0, -20(s0)
        j       .LBB0_17
.LBB0_12:                               #   in Loop: Header=BB0_8 Depth=1
        lw      a0, -36(s0)
        addi    a1, zero, 10
        mul     a1, a0, a1
        ld      a0, -32(s0)
        lw      a2, -48(s0)
        add     a0, a0, a2
        lbu     a0, 0(a0)
        add     a0, a0, a1
        addi    a0, a0, -48
        sw      a0, -36(s0)
        j       .LBB0_13
.LBB0_13:                               #   in Loop: Header=BB0_8 Depth=1
        lw      a0, -48(s0)
        addi    a0, a0, 1
        sw      a0, -48(s0)
        j       .LBB0_8
.LBB0_14:
        lw      a0, -40(s0)
        addi    a1, zero, -1
        bne     a0, a1, .LBB0_16
        j       .LBB0_15
.LBB0_15:
        lw      a1, -36(s0)
        mv      a0, zero
        sub     a0, a0, a1
        sw      a0, -36(s0)
        j       .LBB0_16
.LBB0_16:
        lw      a0, -36(s0)
        sw      a0, -20(s0)
        j       .LBB0_17
.LBB0_17:
        lw      a0, -20(s0)
        ld      s0, 32(sp)
        ld      ra, 40(sp)
        addi    sp, sp, 48
        ret

