#include <cuda_runtime.h>
#include <stdio.h>
#include <stdlib.h>

__global__ void assign(int **tensor, int N, int M, int value)
{

    // int i = blockIdx.x * blockDim.x + threadIdx.x;
    // int j = blockIdx.y * blockDim.y + threadIdx.y;

    // if(i < N && j < N)
    // {
    //     tensor[i][j] = 88;
    //     printf("Assigned\n");
    // }
    for(int i=0;i<N;i++)
    {
        for(int j=0;j<M;j++)
        {
            tensor[i][j] = value;
        }
    }

}

__global__ void printTensor(int **tensor, int N, int M)
{

    // int i = blockIdx.x * blockDim.x + threadIdx.x;
    // int j = blockIdx.y * blockDim.y + threadIdx.y;

    // if(i < N && j < N)
    // {
    //     printf("%d ", tensor[i][j]);
    //     printf("print\n");
    // }
    
    for(int i=0;i<N;i++)
    {
        for(int j=0;j<M;j++)
        {
            printf("%d ", tensor[i][j]);
        }

        printf("\n");
    }

}

// __host__ __device__ void tensorAllocate(int **tensor, int N, int M)
// {
//     cudaMallocManaged((int ***)&tensor, N * sizeof(int));
//     for(int i=0;i<N;i++)
//     {
//         cudaMallocManaged((int **)&tensor[i], M * sizeof(int));
//     }
// }

int main()
{
    int **tensor;
    int N, M, value;

    while(1)
    {
        scanf("%d", &N);
        scanf("%d", &M);
        scanf("%d", &value);

        cudaDeviceSetLimit(cudaLimitMallocHeapSize, 1024 * 1024 * 1024);

        cudaError_t e1, e2, e3;

        e1 = cudaMallocManaged((int ***)&tensor, N * sizeof(int));

        if(e1 != cudaSuccess)
        {
            printf("e1! \n");
        }

        for(int i=0;i<N;i++)
        {
            e2 = cudaMallocManaged((int **)&tensor[i], M * sizeof(int));
        }

        if(e2 != cudaSuccess)
        {
            printf("e2! \n");
        }

        

        assign<<<1, 1>>>(tensor, N, M, value);
        cudaDeviceSynchronize();

        printTensor<<<1, 1>>>(tensor, N, M);
        cudaDeviceSynchronize();

        e3 = cudaGetLastError();

        if(e3 != cudaSuccess)
        {
            printf("%s", cudaGetErrorString(e3));
        }
    }
}