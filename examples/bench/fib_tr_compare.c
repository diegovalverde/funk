#include <stdint.h>
#include <stdio.h>

// Iterative tail-recursive equivalent used as the C baseline.
static int64_t fib_tr(int n, int64_t a, int64_t b) {
    while (n > 0) {
        int64_t next = a + b;
        a = b;
        b = next;
        --n;
    }
    return a;
}

int main(void) {
    const int n = 35;
    printf("%lld\n", (long long)fib_tr(n, 0, 1));
    return 0;
}
