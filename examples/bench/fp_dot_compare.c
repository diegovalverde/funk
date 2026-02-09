#include <stdio.h>
#include <stdlib.h>

static double dot(const double *x, const double *y, int n) {
    double acc = 0.0;
    for (int i = 0; i < n; i++) {
        acc += x[i] * y[i];
    }
    return acc;
}

int main(void) {
    const int n = 2000;
    const int rounds = 200;

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
        total += dot(x, y, n);
    }

    printf("%.12f\n", total);
    free(x);
    free(y);
    return 0;
}
