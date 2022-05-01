OPIMIZATIONFLAG = -O0

# serial
serial: parallel_non.c
	gcc $(OPIMIZATIONFLAG) -o parallel_non parallel_non.c -lm

# openMP
OMP_THREADS = 2
openMP: parallel_OpenMP.c
	gcc $(OPIMIZATIONFLAG) -fopenmp -o parallel_OpenMP parallel_OpenMP.c -lm

# MPI
MPI: parallel_MPI.c
	mpicc $(OPIMIZATIONFLAG) -o parallel_MPI parallel_MPI.c -lm

# MPI + OpenMP
MPI_openMP: parallel_MPI_OpenMP.c
	mpicc $(OPIMIZATIONFLAG) -fopenmp -o parallel_MPI_OpenMP parallel_MPI_OpenMP.c -lm

# CUDA
GPU: parallel_GPU.cu
	nvcc -o parallel_GPU parallel_GPU.cu