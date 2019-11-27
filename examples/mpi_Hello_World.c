#include <unistd.h>
#include "mpi.h"
#include <stdio.h>

int main( int argc, char *argv[] )
{
    double t1,t2;

    int rank, size;

    MPI_Init( &argc, &argv );
    MPI_Comm_rank( MPI_COMM_WORLD, &rank );
    MPI_Comm_size( MPI_COMM_WORLD, &size );

    t1 = MPI_Wtime();
    printf( "Hello World from process %d of %d\n", rank, size );
    sleep(rank*2);
    t2 = MPI_Wtime();
    printf( "Elapsed time process %d of %d: %1.2f\n", rank, size, (t2-t1));

    
    MPI_Finalize();

    return 0;

}