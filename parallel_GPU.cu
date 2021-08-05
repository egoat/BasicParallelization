#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <omp.h>
//#include <mpi.h>
#include <time.h>

#include "config.c"

// function to add the elements of two arrays
// CUDA kernel function to add the elements of two arrays on the GPU
__global__
void add(int n, float *x, float *y)
{
    int i=0;
    //#pragma omp parallel for private(i) num_threads(4)
    for (i = 0; i < n; i++)
    {
        y[i] = x[i] + y[i];
    }
}

int main()
{

    //
    //
    //
    
    cudaMallocManaged(&x,N*sizeof(*x));
    cudaMallocManaged(&y,N*sizeof(*y));

    // initialize x and y arrays on the host
    for (int i = 0; i < N; i++) {
        x[i] = 1.0;
        y[i] = 2.0;
    }

    //=========================================================
    // Run kernel on 1M elements on the CPU
    //-------------------------------------
//    start = timeInMilliseconds();
    //----------
    //for (int i = 0; i<rep; i++)
    //{
        //add(N, x, y);
        add<<<1, 1>>>(N,x,y);
        cudaDeviceSynchronize();
    //}
    //-----------
//    end = timeInMilliseconds();
    //-------------------------------------
    //=========================================================

//    cpu_time_used = ((double) (end-start));
    cpu_time_used = 0;

    // Check for errors (all values should be 3.0f)
    float maxError = 0.0;
    for (int i = 0; i < N; i++)
    maxError = fmax(maxError, fabs(y[i]-(2.0+rep)));
    printf("1\t%f\t%f\n",cpu_time_used,maxError);

    // Free memory
    cudaFree(x);
    cudaFree(y);

    return 0;

}