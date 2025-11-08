#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#ifndef N
#define N 1024
#endif

static double A[N][N];
static double B[N][N];
static double C[N][N];

void init_matrices(void) {
    srand(42);
    for (int i = 0; i < N; i++) {
        for (int j = 0; j < N; j++) {
            A[i][j] = (double)rand() / RAND_MAX;
            B[i][j] = (double)rand() / RAND_MAX;
            C[i][j] = 0.0;
        }
    }
}

void matmul(void) {
    for (int i = 0; i < N; i++) {
        for (int k = 0; k < N; k++) {
            double a = A[i][k];
            for (int j = 0; j < N; j++) {
                C[i][j] += a * B[k][j];
            }
        }
    }
}

int main(void) {
    init_matrices();

    clock_t start = clock();
    matmul();
    clock_t end = clock();

    double elapsed = (double)(end - start) / CLOCKS_PER_SEC;
    printf("Elapsed (inside program): %.3f s\n", elapsed);

    double checksum = 0.0;
    for (int i = 0; i < N; i++)
        for (int j = 0; j < N; j++)
            checksum += C[i][j];

    printf("Checksum: %.6f\n", checksum);
    return 0;
}
