#include <cuda_runtime.h>
#include <iostream>

void printVector(int *ptr, int N)
{
    for(int i=0;i<N;i++)
    {
        std::cout <<*(ptr + i) <<" ";
    }
    std::cout <<std::endl;
}

int main()
{
    int *ptr,  *d_ptr;
    int N = 5;
    ptr = (int*)malloc(sizeof(int) * N);


    for(int i=0;i<N;i++)
    {
        *(ptr + i) = i;
    }

    cudaMalloc((void**)&d_ptr, sizeof(int) * N);
    cudaMemcpy(d_ptr, ptr, sizeof(int)*N, cudaMemcpyHostToDevice);

    std:: cout <<"device contents : ";

    for(int i=0;i<N;i++)
    {
        std::cout <<*(d_ptr + i) <<" ";
    }

    std::cout << std::endl;

    free(ptr);
    cudaFree(d_ptr);
}