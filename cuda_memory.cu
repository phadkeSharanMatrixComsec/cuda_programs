#include <stdlib.h>


#define N 10000000


__global__ void vector_add(float *out, float *a, float *b, int n) {
    for(int i = 0; i < n; i++){
        out[i] = a[i] + b[i];
    }
}

int main(){
    float *a, *b, *out; 
    float *gpuA, *gpuB, *gpuOut;

    a = (float*)malloc(sizeof(float)*N);
    b = (float*)malloc(sizeof(float)*N);
    out = (float*)malloc(sizeof(float)*N);

    cudaMalloc(&gpuA, sizeof(float)*N);
    cudaMalloc(&gpuB, sizeof(float)*N); 
    cudaMalloc(&gpuOut, sizeof(float)*N); 

    for(int i=0;i<N;i++)
    {
        a[i] = 3.2f;
        b[i] = 2.3f;
    }

    cudaMemcpy(gpuA, a, sizeof(float)*N, cudaMemcpyHostToDevice);
    cudaMemcpy(gpuB, b, sizeof(float)*N, cudaMemcpyHostToDevice);

    vector_add<<<1, 1>>>(gpuOut, gpuA, gpuB, N);

    cudaFree(gpuA);
    cudaFree(gpuB);
    cudaFree(gpuOut);

    free(a);
    free(b);
    free(out);
}