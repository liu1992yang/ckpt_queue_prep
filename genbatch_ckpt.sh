#!/bin/bash

file=$1
dir=$(pwd)
subfolder=$2 #make a subfolder to contain all calculations
initPartition=$3

if [ -z $file ] || [ -z $subfolder ]; then
  echo 'Usage: ./genbatch_ckpt.sh file_list(content has no extension) target_sub_folder desiredInitPartition'
  exit 1
fi

if [ -z $initPartition ]; then
  initPartition='ilahie'
  echo "using ilahie for initial job partition"
fi

dependencyList="dependency_batch.sh"
mkdir ${subfolder}
if [ ! -f $dependencyList ]; then
  touch $dependencyList
else
  rm $dependencyList
  touch $dependencyList
fi

while read -r line
do
  fname=$line
  mkdir $dir/${subfolder}/${fname}_opt
  finit=${fname}.gjf
  cp ${finit}  ${dir}/${subfolder}/${fname}_opt/
  fckpt=${line}_ckpt.gjf
  targetpath=${dir}/${subfolder}/${fname}_opt
  ROUTE=$(echo $(grep '#' $finit))
  CKPT_ROUTE=${ROUTE/opt/opt(restart)}
  cat > "$dir/${subfolder}/${fname}_opt/${fckpt}" << EOF
%mem=100gb
%nproc=28       
%Chk=${fname}.chk
${CKPT_ROUTE}


EOF

  cat >"$dir/${subfolder}/${fname}_opt/${fname}_init.sh" << EOF
#!/bin/bash
#SBATCH --job-name=${fname}
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=28
#SBATCH --time=5:00:00
#SBATCH --mem=118G
#SBATCH --workdir=${dir}/${subfolder}/${fname}_opt/
#SBATCH --partition=ilahie
#SBATCH --account=ilahie

# load Gaussian environment
module load contrib/g16.a03

# debugging information
echo "**** Job Debugging Information ****"
echo "This job will run on \$SLURM_JOB_NODELIST"
echo ""
echo "ENVIRONMENT VARIABLES"
set
echo "**********************************************" 

# run Gaussian
g16 ${finit}

exit 0 
EOF

  cat >"${dir}/${subfolder}/${fname}_opt/${fname}_ckpt.sh" << EOF
#!/bin/bash
#SBATCH --job-name=${fname}
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=28
#SBATCH --time=0:800:00
#SBATCH --mem=118G
#SBATCH --workdir=${dir}/${subfolder}/${fname}_opt/
#SBATCH --partition=ckpt
#SBATCH --account=stf-ckpt

# load Gaussian environment
module load contrib/g16.a03

# debugging information
echo "**** Job Debugging Information ****"
echo "This job will run on \$SLURM_JOB_NODELIST"
echo ""
echo "ENVIRONMENT VARIABLES"
set
echo "**********************************************" 

# copy last log file to another name
num=\`ls -l ${fname}_ckpt*.log | wc -l\`
let "num += 1"
cp ${fname}_ckpt.log ${fname}_ckpt\$num.log

# run Gaussian
g16 ${fckpt}

exit 0 
EOF
  
 
  echo "initjob=\$(sbatch ${targetpath}/${fname}_init.sh) && sbatch --dependency=afterany:\${initjob##* } ${targetpath}/${fname}_ckpt.sh" >> ${dependencyList}



done<${file}

echo "please run bash ${dependencyList} to submit ckpt dependency jobs"






 

