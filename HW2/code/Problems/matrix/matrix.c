#include <stdio.h>
#include <assert.h>
#include <stdlib.h>
#include <time.h>
#define MOD 1024
#define SIZE 128
#define BSIZE 32

// void matrix_mul(unsigned short (*)[SIZE], unsigned short (*)[SIZE], unsigned short (*)[SIZE]);

void matrix_mul(unsigned short A[SIZE][SIZE], unsigned short B[SIZE][SIZE], unsigned short C[SIZE][SIZE]){
	int i, j, k, kk, jj;
	double sum;
	int en = BSIZE * (SIZE/BSIZE); /* Amount that fits evenly into blocks */

	for (i = 0; i < SIZE; i++)
		for (j = 0; j < SIZE; j++)
			C[i][j] = 0;

	for (kk = 0; kk < en; kk += BSIZE) {
		for (jj = 0; jj < en; jj += BSIZE) {
			for (i = 0; i < SIZE; i++) {
				for (j = jj; j < jj + BSIZE; j++) {
					sum = C[i][j];
					for (k = kk; k < kk + BSIZE; k++) {
						sum += A[i][k]*B[k][j];
					}
					C[i][j] = sum;
				}
			}
		}
	}
}

int main () {
    unsigned short A[SIZE][SIZE], B[SIZE][SIZE], C[SIZE][SIZE];
    unsigned long long start, end;

    srand(time(NULL));

    // init
    for (int i = 0; i < SIZE; i++)
        for (int j = 0; j < SIZE; j++)
            A[i][j] = rand() % MOD;

    for (int i = 0; i < SIZE; i++)
        for (int j = 0; j < SIZE; j++)
            B[i][j] = rand() % MOD;

    for (int i = 0; i < SIZE; i++)
        for (int j = 0; j < SIZE; j++)
            C[i][j] = 0;


    asm volatile ("rdcycle %0" : "=r" (start));
    matrix_mul(A, B, C);
    asm volatile ("rdcycle %0" : "=r" (end));


    // check
    unsigned short check[SIZE][SIZE];
    for (int i = 0; i < SIZE; i++)
        for (int j = 0; j < SIZE; j++)
            check[i][j] = 0;
    for (int i = 0; i < SIZE; i++)
        for (int j = 0; j < SIZE; j++)
            for (int k = 0; k < SIZE; k++)
                check[i][j] = (check[i][j] + A[i][k] * B[k][j]) % MOD;

    for (int i = 0; i < SIZE; i++)
        for (int j = 0; j < SIZE; j++)
            assert(check[i][j] == C[i][j]);

    printf("Took %llu cycles\n", end - start);
}
