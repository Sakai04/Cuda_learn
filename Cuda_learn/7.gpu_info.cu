#include "cuda_runtime.h"
#include "device_launch_parameters.h"

#include <stdio.h>

#define _1MB (1024 * 1024)

// SM ������ �ھ� ���� ��ȯ�ϴ� �Լ�
int ConvertSMVer2Cores(int major, int minor)
{
    // GPU ��Ű��ó ������ ���� (SM ������ ����Ͽ� SM�� �ھ� ���� ����)
    typedef struct {
        int SM; // 0xMm (16���� ǥ���), M = SM �ֿ� ����, m = SM �� ����
        int Cores;
    } sSMtoCores;

    sSMtoCores nGpuArchCoresPerSM[] = {
        { 0x30, 192 }, // Kepler ���� (SM 3.0) GK10x Ŭ����
        { 0x32, 192 }, // Kepler ���� (SM 3.2) GK10x Ŭ����
        { 0x35, 192 }, // Kepler ���� (SM 3.5) GK11x Ŭ����
        { 0x37, 192 }, // Kepler ���� (SM 3.7) GK21x Ŭ����
        { 0x50, 128 }, // Maxwell ���� (SM 5.0) GM10x Ŭ����
        { 0x52, 128 }, // Maxwell ���� (SM 5.2) GM20x Ŭ����
        { 0x53, 128 }, // Maxwell ���� (SM 5.3) GM20x Ŭ����
        { 0x60, 64  }, // Pascal ���� (SM 6.0) GP100 Ŭ����
        { 0x61, 128 }, // Pascal ���� (SM 6.1) GP10x Ŭ����
        { 0x62, 128 }, // Pascal ���� (SM 6.2) GP10x Ŭ����
        { 0x70, 64  }, // Volta ���� (SM 7.0) GV100 Ŭ����
        { 0x72, 64  }, // Volta ���� (SM 7.2) GV11b Ŭ����
        { 0x75, 64  }, // Turing ���� (SM 7.5) TU10x Ŭ����
        { 0x80, 64  }, // Ampere ���� (SM 8.0) GA100 Ŭ����
        { 0x86, 128 }, // Ampere ���� (SM 8.6) GA10x Ŭ����
        { -1, -1 }
    };

    int index = 0;

    while (nGpuArchCoresPerSM[index].SM != -1) {
        if (nGpuArchCoresPerSM[index].SM == ((major << 4) + minor)) {
            return nGpuArchCoresPerSM[index].Cores;
        }
        index++;
    }

    // ���� ã�� ���� ���, ���� ���� ����Ͽ� ����� ����ǵ��� �⺻���� ���
    printf("SM %d.%d�� ���� MapSMtoCores�� ���ǵ��� �ʾҽ��ϴ�. �⺻������ %d Cores/SM�� ����մϴ�\n", major, minor, nGpuArchCoresPerSM[13].Cores);
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
        printf("\tCUDA �ھ� ��: %d\n", ConvertSMVer2Cores(devProp.major, devProp.minor) * devProp.multiProcessorCount);
        printf("\t�۷ι� �޸� ũ��: %.2f MB\n", (float)devProp.totalGlobalMem / _1MB);
    }

    return 0;
}