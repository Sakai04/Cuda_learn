/*#include "cuda_runtime.h"
#include "device_launch_parameters.h"
#include <stdio.h>

#define ALLOC_SIZE (1024 * 1024 * sizeof(int))

void check_device_memory(void)
{
    size_t free, total;
    cudaMemGetInfo(&free, &total);
    printf("Device memory (free/total = %zu/%zu bytes)\n", free, total);
}

void check_cuda_error(cudaError_t errorCode, const char* action)
{
    if (errorCode != cudaSuccess)
    {
        fprintf(stderr, "Error during %s: %s\n", action, cudaGetErrorString(errorCode));
    }
    else
    {
        printf("%s - %s\n", action, cudaGetErrorName(errorCode));
    }
}

int main(void)
{
    int* dDataPtr;
    cudaError_t errorCode;

    check_device_memory();

    errorCode = cudaMalloc(&dDataPtr, ALLOC_SIZE);
    check_cuda_error(errorCode, "cudaMalloc");
    check_device_memory();

    errorCode = cudaMemset(dDataPtr, 0, ALLOC_SIZE);
    check_cuda_error(errorCode, "cudaMemset");
    check_device_memory();

    errorCode = cudaFree(dDataPtr);
    check_cuda_error(errorCode, "cudaFree");
    check_device_memory();

    return 0;
}*/
