# Static vs Stack vs Heap Allocation Benchmark

## Objective

Compare the cost of declaring the same large array (1 MiB) in three different places in C++:

1. **Static memory** - a `static` array inside a function
2. **Stack memory** - an ordinary local array
3. **Heap memory** - an array from `malloc` / `free`

Each function is called **300000 times**, and the total time is measured with `clock()`.

## Code

```cpp
void staticArray() { static volatile char arr[SIZE]; }

void stackArray()  { volatile char arr[SIZE]; }

void heapArray() {
    volatile char *arr = (volatile char *)malloc(SIZE);
    free((void *)arr);
}
```

## Results (stack clash protection disabled)

| Method | Total Time |
|---|---|
| Static | 0.77 ms |
| Stack | 1.16 ms |
| Heap | 12.59 ms |

Heap allocation was about 16x slower than static and about 11x slower than stack.

## Explanation

**Static (fastest).** A static array is placed in the program's `.bss` segment and set up once when the program starts. Calling the function again costs no allocation work, so each call is almost an empty function call.

**Stack (close to static).** Allocating a local array only moves the stack pointer, and freeing it moves the pointer back. This is a single instruction, so the cost is nearly the same as static.

**Heap (slowest).** `malloc` and `free` run on every call. The allocator has to find a suitable free block and update it. That extra work is small per call, but it is clearly larger than the other two.

## Stack clash protection

My setup uses g++ (Ubuntu 13.3.0-6ubuntu2~24.04.1) 13.3.0
which enables `-fstack-clash-protection` by default. For a large stack frame, the compiler touches every 4 KiB page (256 pages) each time the function is called, to make sure a stack overflow cannot skip over the guard page.

Without disabling the protection the benchmark is a lot different for stack.

| Method | Total Time |
| --- | --- |
| Static | 0.32 ms |
| Stack | 268.52 ms |
| Heap  | 5.20 ms |

This protection is a security feature and should normally stay enabled. It was only disabled here to measure the plain cost of stack allocation.

To run the program **without stack clash protection** use `g++ -fno-stack-clash-protection MemoryAlloc.cpp -o MemoryAlloc`

## Limitations

- **The arrays are never read or written.** The benchmark measures allocation cost only. With `-O2` the compiler removes unused arrays and all three times become about 0 ms, so these results are only valid without optimization.
- **Allocation is not the whole picture.** If the program actually used the array, memory access time would dominate and the three methods would look much closer together.

## Conclusion

Static and stack allocation are nearly free, while heap allocation costs more because `malloc` and `free` run on every call. A very large stack array can lose its advantage on systems that enable stack clash protection by default.
