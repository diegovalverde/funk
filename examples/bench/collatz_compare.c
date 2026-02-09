#include <stdint.h>
#include <stdio.h>

static int64_t collatz_steps(int64_t n) {
    int64_t steps = 0;
    while (n != 1) {
        if ((n % 2) == 0) {
            n /= 2;
        } else {
            n = 3 * n + 1;
        }
        ++steps;
    }
    return steps;
}

static int64_t sum_collatz(int64_t n) {
    int64_t acc = 0;
    while (n > 0) {
        acc += collatz_steps(n);
        --n;
    }
    return acc;
}

int main(void) {
    printf("%lld\n", (long long)sum_collatz(15000));
    return 0;
}
