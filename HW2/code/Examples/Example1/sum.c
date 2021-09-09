#include <stdio.h>

int main () {
    int a = 123, b = 456, c = 789, d;
    asm volatile(
        "add %[a_], %[a_], %[b_]\n\t" 	// a = a + b
        "add %[d_], %[a_], %[c_]\n\t" 	// d = a + c
        : [d_] "=r" (d)
        : [a_] "r" (a), [b_] "r" (b), [c_] "r" (c)
    );	
    printf("%d + %d + %d = %d\n", a, b, c, d);
}
