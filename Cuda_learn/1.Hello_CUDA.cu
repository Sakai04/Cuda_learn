/*#include <cstdio>

#include "cuda_runtime.h"
#include "device_launch_parameters.h"

__global__ void helloCuda(void)
{
    printf("hello cuda from gpu\n");
}

int main(void)
{
    printf("hello gpu from cpu!\n");
    helloCuda << <1, 10 >> > ();
    cudaDeviceSynchronize(); // GPU 작업이 완료될 때까지 기다림
    return 0;
}*/
