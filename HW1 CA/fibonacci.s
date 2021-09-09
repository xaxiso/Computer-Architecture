.global fibonacci
.type fibonacci, %function

.align 2
# unsigned long long int fibonacci(int n);
fibonacci:                              # @fibonacci
        addi    sp, sp, -64
        sd      ra, 56(sp)
        sd      s0, 48(sp)
        addi    s0, sp, 64
        sd      a0, -24(s0)
        ld      a0, -24(s0)
        addi    a0, a0, 2
        add     a1, zero, sp
        sd      a1, -32(s0)
        slli    a1, a0, 3
        addi    a1, a1, 15
        andi    a2, a1, -16
        add     a1, zero, sp
        sub     a1, a1, a2
        sd      a1, -56(s0)
        add     sp, zero, a1
        sd      a0, -40(s0)
        mv      a0, zero
        sd      a0, 0(a1)
        addi    a0, zero, 1
        sd      a0, 8(a1)
        addi    a0, zero, 2
        sd      a0, -48(s0)
        j       .LBB0_1
.LBB0_1:                                # =>This Inner Loop Header: Depth=1
        ld      a1, -48(s0)
        ld      a0, -24(s0)
        bltu    a0, a1, .LBB0_4
        j       .LBB0_2
.LBB0_2:                                #   in Loop: Header=BB0_1 Depth=1
        ld      a0, -56(s0)
        ld      a1, -48(s0)
        slli    a1, a1, 3
        add     a1, a1, a0
        ld      a0, -8(a1)
        ld      a2, -16(a1)
        add     a0, a0, a2
        sd      a0, 0(a1)
        j       .LBB0_3
.LBB0_3:                                #   in Loop: Header=BB0_1 Depth=1
        ld      a0, -48(s0)
        addi    a0, a0, 1
        sd      a0, -48(s0)
        j       .LBB0_1
.LBB0_4:
        ld      a0, -56(s0)
        ld      a1, -24(s0)
        slli    a1, a1, 3
        add     a0, a0, a1
        ld      a0, 0(a0)
        ld      a1, -32(s0)
        add     sp, zero, a1
        addi    sp, s0, -64
        ld      s0, 48(sp)
        ld      ra, 56(sp)
        addi    sp, sp, 64
        ret