@echo off

echo.
echo Threads	CPU time	Error

:: serial
echo   serial
cl parallel_non.c >nul 2>&1
parallel_non
:::::::::::::::::::::::::::::::::::::::::::::::::

:: OpenMP
echo   OpenMP
set OMP_THREADS=1
set OMP_THREADS_MAX=8
::
:LoopStart
::
::echo %OMP_THREADS%
cl /openmp /DOMP_THREADS=%OMP_THREADS% parallel_OpenMP.c >nul 2>&1
parallel_OpenMP
set /A OMP_THREADS=OMP_THREADS+1
::
IF /I %OMP_THREADS% leq %OMP_THREADS_MAX% goto LoopStart 
:LoopEnd
:::::::::::::::::::::::::::::::::::::::::::::::::

