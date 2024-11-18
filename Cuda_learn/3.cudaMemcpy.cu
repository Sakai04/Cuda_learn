/*#include "cuda_runtime.h"
#include "device_launch_parameters.h"
#include <stdio.h>

__global__ void print_data(int* _dDataPtr)
{
    printf("%d ", _dDataPtr[threadIdx.x]);
}

__global__ void set_data(int* _dDataPtr)
{
    _dDataPtr[threadIdx.x] = 2;
}

int main(void)
{
    int data[10] = { 0 };
    for (int i = 0; i < 10; i++) data[i] = 1;

    int* dDataPtr;
    cudaError_t errorCode;

    errorCode = cudaMalloc(&dDataPtr, sizeof(int) * 10);
    if (errorCode != cudaSuccess)
    {
        fprintf(stderr, "cudaMalloc failed: %s\n", cudaGetErrorString(errorCode));
        return -1;
    }

    errorCode = cudaMemcpy(dDataPtr, data, sizeof(int) * 10, cudaMemcpyHostToDevice);
    if (errorCode != cudaSuccess)
    {
        fprintf(stderr, "cudaMemcpy (Host to Device) failed: %s\n", cudaGetErrorString(errorCode));
        cudaFree(dDataPtr);
        return -1;
    }

    set_data<<<1, 10>>>(dDataPtr);
    cudaDeviceSynchronize();

    errorCode = cudaMemcpy(data, dDataPtr, sizeof(int) * 10, cudaMemcpyDeviceToHost);
    if (errorCode != cudaSuccess)
    {
        fprintf(stderr, "cudaMemcpy (Device to Host) failed: %s\n", cudaGetErrorString(errorCode));
        cudaFree(dDataPtr);
        return -1;
    }

    print_data<<<1, 10>>>(dDataPtr);
    cudaDeviceSynchronize();

    errorCode = cudaFree(dDataPtr);
    if (errorCode != cudaSuccess)
    {
        fprintf(stderr, "cudaFree failed: %s\n", cudaGetErrorString(errorCode));
        return -1;
    }

    return 0;
}*/