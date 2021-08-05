#ifdef _WIN32
    #include <windows.h>
#else //__linux__
    #include<sys/time.h>
#endif

//#define OMP_THREADS     12
//#define MPI_THREADS     2

int N = 1<<25; //1<<25;  // 1M elements (20)
int rep = 1<<0; //1<<5; // do 2^5 repeats


//clock_t start, end;
long long start, end;
double cpu_time_used;

float *x;
float *y;


long long timeInMilliseconds(void) {
    #ifdef _WIN32
        SYSTEMTIME tv = {0};
        
        GetSystemTime(&tv);
        return ((tv.wSecond)*1000)+tv.wMilliseconds;
    #else //__linux__
        struct timeval tv;

        gettimeofday(&tv,NULL);
        return (((long long)tv.tv_sec)*1000)+(tv.tv_usec/1000);
    #endif  
}

