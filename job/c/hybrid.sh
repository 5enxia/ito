#!/bin/bash


# ito
#-----------------------------------------------------
# sub-system
#PJM -L "rscunit=ito-b"

# resource group
#PJM -L "rscgrp=ito-g-16-dbg"

# number of virtual nodes
#PJM -L "vnode=4"

# number of cores per virtual node
#PJM -L "vnode-core=36"

# elapsed-time limit
#PJM -L "elapse=10:00"

# Output standard error to the same file that standard output
#PJM -j
#-----------------------------------------------------


# intel compiler version
#-----------------------------------------------------
module load intel/2019.4
#-----------------------------------------------------


# Intel MPI
#-----------------------------------------------------
# number of nodes
NUM_NODES=$PJM_VNODES

# number of cores per node
NUM_CORES=36

# number of procs
NUM_PROCS=16

# number of threads per proc
NUM_THREADS=9

# number of MPI procs
export I_MPI_PERHOST=`expr $NUM_CORES / $NUM_THREADS`

# MPI communication means
export I_MPI_FABRICS=shm:ofi

# procs & threads allocation
export I_MPI_PIN_DOMAIN=omp
export I_MPI_PIN_CELL=core

# number of OpenMP threads per proc
export OMP_NUM_THREADS=$NUM_THREADS

# stack size
export KMP_STACKSIZE=8m

# correspondence between threads and cores
export KMP_AFINITY=compact

# Intel MPI boot method
export I_MPI_HYDRA_BOOTSTRAP=rsh
export I_MPI_HYDRA_BOOTSTRAP_EXEC=/bin/pjrsh
export I_MPI_HYDRA_HOST_FILE=${PJM_O_NODEINF}
#-----------------------------------------------------


# run
#-----------------------------------------------------
mpiexec.hydra -n $NUM_PROCS ./a.out
#-----------------------------------------------------
