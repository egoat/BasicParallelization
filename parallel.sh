#!/bin/sh

# serial
#make serial
#gcc -O3 -o parallel_OpenMP parallel_OpenMP.c -lm
#./parallel_non

echo 'Threads\tCPU time\tError'

# serial
echo '  Serial'
gcc -o parallel_non parallel_non.c -lm
./parallel_non

# openMP
echo '  OpenMP'
set OMP_NUM_THREADS=1
OMP_THREADS=1
OMP_THREADS_MAX=12
while [ $OMP_THREADS -le $OMP_THREADS_MAX ]
do
    gcc -fopenmp -o parallel_OpenMP parallel_OpenMP.c -lm -DOMP_THREADS=${OMP_THREADS}
    set OMP_NUM_THREADS=${OMP_THREADS}
    ./parallel_OpenMP
    OMP_THREADS=`expr $OMP_THREADS + 1`
done

# MPI
echo '  MPI'
mpicc.mpich -o parallel_MPI parallel_MPI.c
mpirun.mpich -np 4 ./parallel_MPI

# MP + openMP

# CUDA
