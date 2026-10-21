#include <cstdio>
#include <cstdlib>
#include <ctime>

const int SIZE  = 1024 * 1024;
const int CALLS = 300000;

void staticArray() {
    static volatile char arr[SIZE];
}

void stackArray() {
    volatile char arr[SIZE];
}

void heapArray() {
    volatile char *arr = (volatile char *)malloc(SIZE);
    free((void *)arr);
}

int main() {
    clock_t start;
    double ms;

    start = clock();
    for (int i = 0; i < CALLS; i++) staticArray();
    ms = (clock() - start) * 1000.0 / CLOCKS_PER_SEC;
    printf("Static: %.2f ms\n", ms);

    start = clock();
    for (int i = 0; i < CALLS; i++) stackArray();
    ms = (clock() - start) * 1000.0 / CLOCKS_PER_SEC;
    printf("Stack : %.2f ms\n", ms);

    start = clock();
    for (int i = 0; i < CALLS; i++) heapArray();
    ms = (clock() - start) * 1000.0 / CLOCKS_PER_SEC;
    printf("Heap  : %.2f ms\n", ms);

    return 0;
}