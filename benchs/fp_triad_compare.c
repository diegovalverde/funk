#include <stdio.h>
#include <stdlib.h>

static double triad_sum(const double *b, const double *c, const double *d, int n, double a) {
    double acc = 0.0;
    for (int i = 0; i < n; i++) {
        acc += b[i] + a * c[i] + d[i];
    }
    return acc;
}

int main(void) {
    const int n = 2000;
    const int rounds = 200;
    const double a = 0.31415926535;

    double *b = (double *)malloc((size_t)n * sizeof(double));
    double *c = (double *)malloc((size_t)n * sizeof(double));
    double *d = (double *)malloc((size_t)n * sizeof(double));
    if (!b || !c || !d) {
        free(b);
        free(c);
        free(d);
        return 1;
    }

    for (int i = 0; i < n; i++) {
        b[i] = (double)i * 0.5 + 1.1;
        c[i] = (double)i * 0.25 + 2.3;
        d[i] = (double)i * 0.125 + 3.7;
    }

    double total = 0.0;
    for (int r = 0; r < rounds; r++) {
        total += triad_sum(b, c, d, n, a);
    }

    printf("%.12f\n", total);
    free(b);
    free(c);
    free(d);
    return 0;
}
