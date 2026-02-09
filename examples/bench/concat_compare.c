#include <stdio.h>
#include <stdlib.h>

int main(void) {
    const int k = 3000;
    const int n = 8;
    const int total = k * n;
    int *acc = (int *)malloc((size_t)total * sizeof(int));
    if (!acc) {
        return 1;
    }
    for (int i = 0; i < total; i++) {
        acc[i] = 1;
    }
    printf("%d\n", total);
    free(acc);
    return 0;
}
