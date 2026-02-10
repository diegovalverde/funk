#include <stdio.h>
#include <stdint.h>

static int64_t fib(int n) {
    if (n < 2) return n;
    return fib(n - 1) + fib(n - 2);
}

int main(void) {
    const int n = 35;
    printf("%lld\n", (long long)fib(n));
    return 0;
}
