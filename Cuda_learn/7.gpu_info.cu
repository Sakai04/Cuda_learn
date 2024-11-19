#include "cuda_runtime.h"
#include "device_launch_parameters.h"

#include <stdio.h>

#define _1MB (1024 * 1024)

// SM 버전을 코어 수로 변환하는 함수
int ConvertSMVer2Cores(int major, int minor)
{
    // GPU 아키텍처 유형을 정의 (SM 버전을 사용하여 SM당 코어 수를 결정)
    typedef struct {
        int SM; // 0xMm (16진수 표기법), M = SM 주요 버전, m = SM 부 버전
        int Cores;
    } sSMtoCores;

    sSMtoCores nGpuArchCoresPerSM[] = {
        { 0x30, 192 }, // Kepler 세대 (SM 3.0) GK10x 클래스
        { 0x32, 192 }, // Kepler 세대 (SM 3.2) GK10x 클래스
        { 0x35, 192 }, // Kepler 세대 (SM 3.5) GK11x 클래스
        { 0x37, 192 }, // Kepler 세대 (SM 3.7) GK21x 클래스
        { 0x50, 128 }, // Maxwell 세대 (SM 5.0) GM10x 클래스
        { 0x52, 128 }, // Maxwell 세대 (SM 5.2) GM20x 클래스
        { 0x53, 128 }, // Maxwell 세대 (SM 5.3) GM20x 클래스
        { 0x60, 64  }, // Pascal 세대 (SM 6.0) GP100 클래스
        { 0x61, 128 }, // Pascal 세대 (SM 6.1) GP10x 클래스
        { 0x62, 128 }, // Pascal 세대 (SM 6.2) GP10x 클래스
        { 0x70, 64  }, // Volta 세대 (SM 7.0) GV100 클래스
        { 0x72, 64  }, // Volta 세대 (SM 7.2) GV11b 클래스
        { 0x75, 64  }, // Turing 세대 (SM 7.5) TU10x 클래스
        { 0x80, 64  }, // Ampere 세대 (SM 8.0) GA100 클래스
        { 0x86, 128 }, // Ampere 세대 (SM 8.6) GA10x 클래스
        { -1, -1 }
    };

    int index = 0;

    while (nGpuArchCoresPerSM[index].SM != -1) {
        if (nGpuArchCoresPerSM[index].SM == ((major << 4) + minor)) {
            return nGpuArchCoresPerSM[index].Cores;
        }
        index++;
    }

    // 값을 찾지 못한 경우, 이전 값을 사용하여 제대로 실행되도록 기본값을 사용
    printf("SM %d.%d에 대한 MapSMtoCores가 정의되지 않았습니다. 기본값으로 %d Cores/SM을 사용합니다\n", major, minor, nGpuArchCoresPerSM[13].Cores);
    return nGpuArchCoresPerSM[13].Cores;
}

int main(void)
{
    int ngpus;
    cudaGetDeviceCount(&ngpus);

    for (int i = 0; i < ngpus; i++)
    {
        cudaDeviceProp devProp;
        cudaGetDeviceProperties(&devProp, i);

        printf("Device %d: %s\n", i, devProp.name);
        printf("\tCompute Capability: %d.%d\n", devProp.major, devProp.minor);
        printf("\tCUDA 코어 수: %d\n", ConvertSMVer2Cores(devProp.major, devProp.minor) * devProp.multiProcessorCount);
        printf("\t글로벌 메모리 크기: %.2f MB\n", (float)devProp.totalGlobalMem / _1MB);
    }

    return 0;
}