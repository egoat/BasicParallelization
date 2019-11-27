#include <time.h>
#include<sys/time.h>

#define OMP_THREADS     4
#define MPI_THREADS     2

int N = 1<<20;  // 1M elements (20)
int rep = 1<<5; // do 2^5 repeats


//clock_t start, end;
long long start, end;
double cpu_time_used;

float *x;
float *y;


long long timeInMilliseconds(void) {
    struct timeval tv;

    gettimeofday(&tv,NULL);
    return (((long long)tv.tv_sec)*1000)+(tv.tv_usec/1000);
}

