#!/bin/bash
#SBATCH --job-name=s5-H
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=28
#SBATCH --time=5:00:00
#SBATCH --mem=118G
#SBATCH --workdir=/c/Users/Yang/Documents/Research/turecek/ckpt_prep_script/sub_opt/s5-H_opt/
#SBATCH --partition=chem
#SBATCH --account=chem

# load Gaussian environment
module load contrib/g16.a03

# debugging information
echo "**** Job Debugging Information ****"
echo "This job will run on $SLURM_JOB_NODELIST"
echo ""
echo "ENVIRONMENT VARIABLES"
set
echo "**********************************************" 

# run Gaussian
g16 s5-H.gjf

exit 0 
