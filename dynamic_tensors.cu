#include <cuda_runtime.h>
#include <stdio.h>
#include <stdlib.h>

__global__ void printTensor(float *tensor, int N)
{
    printf("working!!\n");
    for(int i=0;i<N;i++)
    {
        for(int j=0;j<N;j++)
        {
            printf("%f ", *(tensor + i));
        }

        printf("\n");
    }

}

__global__ void printArray(float *ptr, int N)
{
    for(int i=0;i<N;i++)
    {
        printf("%d ", *(ptr+i));
    }
    printf("\n");
}

int main()
{
    int N=10;
    float arr[10][10];
    float *tensor;

    for(int i=0;i<N;i++)
    {
        for(int j=0;j<N;j++)
        {
            arr[i][j] = 10.0;
        }
    }

    // for(int i=0;i<N;i++)
    // {
    //     for(int j=0;j<N;j++)
    //     {
    //         printf("%f ", arr[i][j]);
    //     }
    // }

    cudaError_t err2 = cudaMalloc(&tensor, sizeof(float) * N * N);
    cudaError_t err = cudaMemcpy(tensor, arr, sizeof(float) * N * N, cudaMemcpyHostToDevice);

    if(err != cudaSuccess || err2 != cudaSuccess)
    {
        printf("loccha!");
    }

    // printTensor<<<1, 1>>>(tensor, N);
    printArray<<<1, 1>>>(tensor, N*N);

}