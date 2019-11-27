# serial
serial: parallel_non.c
	gcc -O3 -o parallel_non parallel_non.c -lm

# openMP
OMP_THREADS = 2
openMP: parallel_OpenMP.c
	gcc -O3 -fopenmp -o parallel_OpenMP parallel_OpenMP.c -lm -DOMP_THREADS=$(OMP_THREADS)