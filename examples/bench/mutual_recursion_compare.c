#include <stdint.h>
#include <stdio.h>

static int64_t ping(int64_t n, int64_t acc);
static int64_t pong(int64_t n, int64_t acc);

static int64_t ping(int64_t n, int64_t acc) {
    if (n == 0) {
        return acc;
    }
    return pong(n - 1, acc + 1);
}

static int64_t pong(int64_t n, int64_t acc) {
    if (n == 0) {
        return acc;
    }
    return ping(n - 1, acc + 1);
}

int main(void) {
    int64_t n = 800;
    int64_t rounds = 2000;
    int64_t total = 0;
    while (rounds > 0) {
        total += ping(n, 0);
        --rounds;
    }
    printf("%lld\n", (long long)total);
    return 0;
}
