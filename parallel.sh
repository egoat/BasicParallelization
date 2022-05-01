#!/bin/sh

echo 'Threads\tCPU time\tError'

# serial
echo '  Serial'
##gcc -o parallel_non parallel_non.c -lm
make serial -s
./parallel_non
 
# openMP
echo '  OpenMP'
set OMP_NUM_THREADS=1
OMP_THREADS=1
OMP_THREADS_MAX=8
while [ $OMP_THREADS -le $OMP_THREADS_MAX ]
do
    ##gcc -fopenmp -o parallel_OpenMP parallel_OpenMP.c -lm -DOMP_THREADS=${OMP_THREADS}
    make openMP -s
    export OMP_NUM_THREADS=${OMP_THREADS}
    ./parallel_OpenMP
    OMP_THREADS=`expr $OMP_THREADS + 1`
done

# MPI
MPI_RANK=1
MPI_RANK_MAX=8
echo '  MPI'
while [ $MPI_RANK -le $MPI_RANK_MAX ]
do
    ##mpicc -O0 -o parallel_MPI parallel_MPI.c -lm
    make MPI -s
    mpirun --mca btl self,vader,tcp -np $MPI_RANK ./parallel_MPI
    MPI_RANK=`expr $MPI_RANK + 1`
done

# MP + openMP
MPI_RANK=2
MPI_RANK_MAX=4
OMP_THREADS=2
OMP_THREADS_MAX=4
set OMP_NUM_THREADS=1
echo '  MPI + openMP'
while [ $MPI_RANK -le $MPI_RANK_MAX ]
do
    while [ $OMP_THREADS -le $OMP_THREADS_MAX ]
    do
        ##mpicc -O0 -fopenmp -o parallel_MPI_OpenMP parallel_MPI_OpenMP.c -lm -DOMP_THREADS=${OMP_THREADS}
        make MPI_openMP -s
        export OMP_NUM_THREADS=${OMP_THREADS}
        mpirun --mca btl self,vader,tcp -np $MPI_RANK ./parallel_MPI_OpenMP
        OMP_THREADS=`expr $OMP_THREADS + 1`
    done
    OMP_THREADS=1;
    MPI_RANK=`expr $MPI_RANK + 1`
done


# CUDA
echo '  CUDA'
make GPU -s
./parallel_GPU