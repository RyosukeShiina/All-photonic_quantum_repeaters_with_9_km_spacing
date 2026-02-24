#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=120
#SBATCH --mem-per-cpu=4G
#SBATCH --job-name=Perror_vs_v7_UW3_9km
#SBATCH -p cpu
#SBATCH --time=30:00:00

module load matlab/r2024a

cd /home/rshiina_umass_edu/matlab_simulation

matlab -batch "Perror_vs_v7_UW3_9km"