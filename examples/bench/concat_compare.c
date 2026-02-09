#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main(void) {
    const int k = 3000;
    const int n = 8;

    /*
     * IMPORTANT:
     * This benchmark intentionally mirrors the Funk/Python algorithm:
     *   acc = acc + row(n)
     * on every iteration.
     *
     * So we rebuild a fresh array each round and copy the previous
     * accumulator into it before appending n new elements.
     *
     * A single pre-allocation with one fill pass would be much faster,
     * but it would no longer measure the same workload.
     */
    int *acc = NULL;
    int len = 0;

    for (int i = 0; i < k; i++) {
        int next_len = len + n;
        int *next = (int *)malloc((size_t)next_len * sizeof(int));
        if (!next) {
            free(acc);
            return 1;
        }

        if (len > 0) {
            memcpy(next, acc, (size_t)len * sizeof(int));
        }
        for (int j = 0; j < n; j++) {
            next[len + j] = 1;
        }

        free(acc);
        acc = next;
        len = next_len;
    }

    printf("%d\n", len);
    free(acc);
    return 0;
}
