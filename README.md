# General

This is the equivalent of a 'Hello World' for numerical code: Vector addition is implemented in 5 different ways:

- Serial
- OpneMP
- MPI
- MPI + OpenMP
- CUDA

More detailed information can be found in [this blogpost](https://blog.egoat.ch/2022/05/19/basic_parallelization.html).

# Setup

Packages neede are, openmpi-bin for MPI and nvidia-cuda-toolit for CUDA

```
sudo apt install openmpi-bin
sudo apt install nvidia-cuda-toolkit
```

# Usage

The `parallel.sh` file compiles each example and runs it for different number of threads and/or processes.

```
./parallel.sh
```