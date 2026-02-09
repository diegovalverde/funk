#include <stdio.h>
#include <stdlib.h>

static double daxpy_sum(const double *x, const double *y, int n, double a) {
    double acc = 0.0;
    for (int i = 0; i < n; i++) {
        acc += a * x[i] + y[i];
    }
    return acc;
}

int main(void) {
    const int n = 2000;
    const int rounds = 200;
    const double a = 1.61803398875;

    double *x = (double *)malloc((size_t)n * sizeof(double));
    double *y = (double *)malloc((size_t)n * sizeof(double));
    if (!x || !y) {
        free(x);
        free(y);
        return 1;
    }

    for (int i = 0; i < n; i++) {
        x[i] = (double)i * 0.5 + 1.1;
        y[i] = (double)i * 0.25 + 2.3;
    }

    double total = 0.0;
    for (int r = 0; r < rounds; r++) {
        total += daxpy_sum(x, y, n, a);
    }

    printf("%.12f\n", total);
    free(x);
    free(y);
    return 0;
}
