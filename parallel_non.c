#include <stdio.h>
#include <stdlib.h>
#include <math.h>
//#include <omp.h>
//#include <mpi.h>

#include "config.c"

// function to add the elements of two arrays
// serial
//
void add(int n, float *x, float *y)
{
    //
    //
    for (int i = 0; i < n; i++)
    {
        y[i] = x[i] + y[i];
    }
}

int main()
{

    //
    //
    //

    x = calloc(N,sizeof(*x));
    y = calloc(N,sizeof(*y));

    // initialize x and y arrays on the host
    for (int i = 0; i < N; i++) {
        x[i] = 1.0;
        y[i] = 2.0;
    }

    //=========================================================
    // Run kernel on 1M elements on the CPU
    //-------------------------------------
    start = timeInMilliseconds();
    //----------
    for (int i = 0; i<rep; i++)
    {
        add(N, x, y);
    }
    //-----------
    end = timeInMilliseconds();
    //-------------------------------------
    //=========================================================

    cpu_time_used = ((double) (end-start));

    // Check for errors (all values should be 3.0f)
    float maxError = 0.0;
    for (int i = 0; i < N; i++)
    maxError = fmax(maxError, fabs(y[i]-(2.0+rep)));
    printf("1:1\t%f\t%f\n",cpu_time_used,maxError);

    // Free memory
    free(x);
    free(y);

    return 0;

}