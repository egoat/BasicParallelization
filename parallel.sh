#!/bin/bash

# serial
make serial
./parallel_non

# openMP
make openMP
./parallel_OpenMP

# MPI

# MP + openMP

# CUDA