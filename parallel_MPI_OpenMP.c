#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <omp.h>
#include <mpi.h>

#include "config.c"

// function to add the elements of two arrays
// MPI + OpenMP parallel
//
void add(int n, float *x, float *y)
{
    #pragma omp parallel for
    for (int i = 0; i < n; i++)
    {
        y[i] = x[i] + y[i];
    }
}

void main()
{
    int rank,rank_total;
    double t1,t2;

    //============================================================
    // Initialize the MPI environment
    //============================================================
    MPI_Init(NULL,NULL);
    MPI_Comm_rank(MPI_COMM_WORLD, &rank);
    MPI_Comm_size(MPI_COMM_WORLD,&rank_total);


    //===============================================================
    // execute task
    //===============================================================

    // remaining elements for last process
    if (rank==rank_total-1)
    {
        N = N - N/rank_total*rank;
    }
    else
    {
        N = N/rank_total;
    }
    
    x = calloc(N,sizeof(*x));
    y = calloc(N,sizeof(*y));

    // initialize x and y arrays on the host
    for (int i = 0; i < N; i++) {
        x[i] = 1.0;
        y[i] = 2.0;
    }

    //=========================================
    // Run kernel on 1M/rank elements on the CPU
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
    //==========================================

    cpu_time_used = ((double) (end-start));

    // Check for errors (all values should be 3.0f)
    float maxError = 0.0;
    for (int i = 0; i < N; i++)
    maxError = fmax(maxError, fabs(y[i]-(2.0+rep)));


    //============================================================
    // MPI send/receive data
    //============================================================
    if (rank_total>0)
    {
        if (rank==0)
        {
            int cpu_time_used_local = 0;
            int maxError_local = 0;

            // receive data from all other processes
            for (int i=1;i<rank_total;i++)
            {
                MPI_Recv(&cpu_time_used_local, 1, MPI_INT, i, 0, MPI_COMM_WORLD, MPI_STATUS_IGNORE);
                MPI_Recv(&maxError_local     , 1, MPI_INT, i, 0, MPI_COMM_WORLD, MPI_STATUS_IGNORE);
                cpu_time_used += cpu_time_used_local;
                maxError = fmax(maxError_local, maxError);
            }
        }
        else
        {
            // send data from 1 to 0
            //MPI_SEND(buf, count, datatype, dest, tag, comm)
            //printf("Rank 1: sending data\n");
            MPI_Send(&cpu_time_used, 1, MPI_INT, 0, 0, MPI_COMM_WORLD);
            MPI_Send(&maxError,      1, MPI_INT, 0, 0, MPI_COMM_WORLD);

        }
    }

    if(rank==0) printf("%d:%d\t%f\t%f\n",rank_total,omp_get_max_threads(),cpu_time_used,maxError);

    // Free memory
    free(x);
    free(y);

    MPI_Finalize();

}