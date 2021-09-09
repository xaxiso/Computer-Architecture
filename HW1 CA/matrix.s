.global matrix_mul
.type matrix_mul, %function

.align 2

matrix_mul:                             # @matrix_mul
        addi    sp, sp, -208
        sd      ra, 200(sp)
        sd      s0, 192(sp)
        sd      s1, 184(sp)
        sd      s2, 176(sp)
        sd      s3, 168(sp)
        sd      s4, 160(sp)
        sd      s5, 152(sp)
        sd      s6, 144(sp)
        sd      s7, 136(sp)
        sd      s8, 128(sp)
        sd      s9, 120(sp)
        sd      s10, 112(sp)
        sd      s11, 104(sp)
        sd      a2, 8(sp)
        sd      a0, 48(sp)
        mv      a4, zero
        mv      a2, zero
        addi    s9, a1, 1024
        addi    s8, zero, 16
.LBB0_1:                                # =>This Loop Header: Depth=1
        sd      a2, 16(sp)
        mv      a2, zero
        ori     a0, a4, 1
        sd      a0, 96(sp)
        addi    a0, a0, 1
        sd      a0, 88(sp)
        ori     a0, a4, 3
        addi    a1, a0, 1
        sd      a1, 80(sp)
        addi    a1, a0, 2
        sd      a1, 72(sp)
        add     s6, zero, a0
        addi    a0, a0, 3
        sd      a0, 64(sp)
        ori     a0, a4, 7
        sd      a0, 56(sp)
        sd      s9, 24(sp)
        ld      s10, 8(sp)
.LBB0_2:                                #   Parent Loop BB0_1 Depth=1
        sd      a2, 32(sp)
        mv      s7, zero
        sd      s10, 40(sp)
.LBB0_3:                                #   Parent Loop BB0_1 Depth=1
        mv      a3, zero
        slli    a1, s7, 8
        ld      a0, 48(sp)
        add     a6, a0, a1
        add     s5, zero, a4
        slli    a1, a4, 1
        add     s11, a6, a1
        ld      a0, 96(sp)
        slli    a1, a0, 1
        add     ra, a6, a1
        ld      a0, 88(sp)
        slli    a1, a0, 1
        add     t3, a6, a1
        slli    a4, s6, 1
        add     t4, a6, a4
        ld      a0, 80(sp)
        slli    a4, a0, 1
        add     t5, a6, a4
        ld      a0, 72(sp)
        slli    a5, a0, 1
        add     t6, a6, a5
        ld      a0, 64(sp)
        slli    s1, a0, 1
        add     s4, a6, s1
        ld      a0, 56(sp)
        slli    a2, a0, 1
        add     a6, a6, a2
.LBB0_4:                                #   Parent Loop BB0_1 Depth=1
        add     a2, s10, a3
        lh      a7, 0(a2)
        lh      t0, 0(s11)
        add     s2, s9, a3
        lh      s3, -1024(s2)
        lh      t1, 0(ra)
        lh      t2, -768(s2)
        mul     a0, s3, t0
        add     a0, a0, a7
        mul     a1, t2, t1
        lh      s0, 0(t3)
        lh      a4, -512(s2)
        lh      a5, 0(t4)
        lh      s1, -256(s2)
        add     a0, a0, a1
        mul     a1, a4, s0
        add     a0, a0, a1
        mul     a1, s1, a5
        lh      a4, 0(t5)
        lh      a5, 0(s2)
        lh      s1, 0(t6)
        lh      s0, 256(s2)
        add     a0, a0, a1
        mul     a1, a5, a4
        add     a0, a0, a1
        mul     a1, s0, s1
        lh      a4, 0(s4)
        lh      a5, 512(s2)
        lh      s1, 0(a6)
        lh      s0, 768(s2)
        add     a0, a0, a1
        mul     a1, a5, a4
        add     a0, a0, a1
        mul     a1, s0, s1
        add     a0, a0, a1
        andi    a0, a0, 1023
        addi    a3, a3, 2
        sh      a0, 0(a2)
        bne     a3, s8, .LBB0_4
        addi    s7, s7, 1
        addi    s10, s10, 256
        add     a4, zero, s5
        addi    a0, zero, 128
        bne     s7, a0, .LBB0_3
        ld      a1, 32(sp)
        sext.w  a0, a1
        addi    a1, a1, 8
        ld      s10, 40(sp)
        addi    s10, s10, 16
        addi    s9, s9, 16
        add     a2, zero, a1
        addi    a1, zero, 120
        bltu    a0, a1, .LBB0_2
        ld      a1, 16(sp)
        sext.w  a0, a1
        addi    a1, a1, 8
        addi    a4, a4, 8
        ld      a2, 24(sp)
        addi    a2, a2, 1024
        addi    s9, a2, 1024
        add     a2, zero, a1
        addi    a1, zero, 120
        bltu    a0, a1, .LBB0_1
        ld      s11, 104(sp)
        ld      s10, 112(sp)
        ld      s9, 120(sp)
        ld      s8, 128(sp)
        ld      s7, 136(sp)
        ld      s6, 144(sp)
        ld      s5, 152(sp)
        ld      s4, 160(sp)
        ld      s3, 168(sp)
        ld      s2, 176(sp)
        ld      s1, 184(sp)
        ld      s0, 192(sp)
        ld      ra, 200(sp)
        addi    sp, sp, 208
        ret
