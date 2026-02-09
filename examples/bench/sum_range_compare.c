#include <stdint.h>
#include <stdio.h>

static int64_t sum_range(int64_t n) {
    int64_t acc = 0;
    while (n > 0) {
        acc += n;
        --n;
    }
    return acc;
}

int main(void) {
    int64_t n = 12000;
    int64_t rounds = 29;
    int64_t total = 0;
    while (rounds > 0) {
        total += sum_range(n);
        --rounds;
    }
    printf("%lld\n", (long long)total);
    return 0;
}
