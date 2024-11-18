/*#include "cuda_runtime.h"
#include "device_launch_parameters.h"


#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// The size of vector
#define NUM_DATA 1024

// Simple vector sum kernel
__global__ void vecAdd(int* _a, int* _b, int* _c)
{
    int tID = threadIdx.x;
    _c[tID] = _a[tID] + _b[tID];
}

int main(void)
{
    
    int* a, * b, * c, * hc; // vectors on the host
    int* da, * db, * dc; // vectors on the device

    int memSize = sizeof(int) * NUM_DATA;
    printf("%d elements, memSize = %d bytes\n", NUM_DATA, memSize);

    // memory allocation on the host-side
    a = new int[NUM_DATA]; memset(a, 0, memSize);
    b = new int[NUM_DATA]; memset(b, 0, memSize);
    c = new int[NUM_DATA]; memset(c, 0, memSize);
    hc = new int[NUM_DATA]; memset(hc, 0, memSize);

    // data generation
    for (int i = 0; i < NUM_DATA; i++)
    {
        a[i] = rand() % 10;
        b[i] = rand() % 10;
    }

    // vector sum on host
    for (int i = 0; i < NUM_DATA; i++)
        hc[i] = a[i] + b[i];

    // memory allocation on the device-side
    cudaMalloc(&da, memSize); cudaMemset(da, 0, memSize);
    cudaMalloc(&db, memSize); cudaMemset(db, 0, memSize);
    cudaMalloc(&dc, memSize); cudaMemset(dc, 0, memSize);

    // data copy : host to device
    cudaMemcpy(da, a, memSize, cudaMemcpyHostToDevice);
    cudaMemcpy(db, b, memSize, cudaMemcpyHostToDevice);

    // kernel call
    vecAdd<<<1, NUM_DATA>>>(da, db, dc);

    // copy results : device to host
    cudaMemcpy(c, dc, memSize, cudaMemcpyDeviceToHost);

    // release device memory
    cudaFree(da); cudaFree(db); cudaFree(dc);

    // check results
    bool result = true;
    for (int i = 0; i < NUM_DATA; i++)
    {
        if (hc[i] != c[i])
        {
            printf("[%d] the result is not matched! (%d, %d)\n", i, hc[i], c[i]);
            result = false;
        }
    }

    if (result)
        printf("gpu works well\n");

    // release host memory
    delete[] a; delete[] b; delete[] c; delete[] hc;

    return 0;
}*/