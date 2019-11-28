#!/bin/bash

# serial
make serial
gcc -O3 -o parallel_OpenMP parallel_OpenMP.c -lm
./parallel_non

# openMP
#make openMP
echo -e 'Threads\tCPU time\tError'

echo '  Serial'
gcc -O3 -o parallel_non parallel_non.c -lm
./parallel_non

echo '  OpenMP'
OMP_THREADS=1
OMP_THREADS_MAX=12
while [ $OMP_THREADS -le $OMP_THREADS_MAX ]
do
    gcc -O3 -fopenmp -o parallel_OpenMP parallel_OpenMP.c -lm -DOMP_THREADS=${OMP_THREADS}
    ./parallel_OpenMP
    OMP_THREADS=`expr $OMP_THREADS + 1`
done

# MPI
mpicc.mpich -o mpi_hello_world mpi_hello_world.c
mpirun.mpich -np 4 ./mpi_hello_world

# MP + openMP

# CUDA
