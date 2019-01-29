#!/bin/bash
#SBATCH --job-name=s2-H
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=28
#SBATCH --time=0:800:00
#SBATCH --mem=118G
#SBATCH --workdir=/c/Users/Yang/Documents/Research/turecek/ckpt_prep_script/sub_opt/s2-H_opt/
#SBATCH --partition=ckpt
#SBATCH --account=stf-ckpt

# load Gaussian environment
module load contrib/g16.a03

# debugging information
echo "**** Job Debugging Information ****"
echo "This job will run on $SLURM_JOB_NODELIST"
echo ""
echo "ENVIRONMENT VARIABLES"
set
echo "**********************************************" 

# copy last log file to another name
num=`ls -l s2-H_ckpt*.log | wc -l`
let "num += 1"
cp s2-H_ckpt.log s2-H_ckpt$num.log

# run Gaussian
g16 s2-H_ckpt.gjf

exit 0 
