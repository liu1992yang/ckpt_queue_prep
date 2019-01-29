# ckpt_queue_prep
to prep a bunch of gaussian input for hyak-ckpt queue geometry optimization
## gaussian job optimization restart
based on previous checkpoint file `.chk` file and keyword `restart` gaussian can continue geometry optimization from 
last checkpoint
## initial jobs
initial jobs has no `.chk` and has to run to some cycles to reach certain checkpoint and therefore allow "restart" from
checkpoint file. Therefore, it is suggested to run 1-2 cycles for the initial jobs 
## job dependency
each initial jobs (submit at the same time) might not finish their cycles at the same time.
Instead of baby-sitting the jobs, job dependency is recommended to set build dependencies based on related job-ids
And restart jobs will use the same functionals as the initial jobs
## intermediate log files
intermediate log files will be stored in corresponding folder of the initial geometry(generated with this script as well)
## usage
#### ./genbatch_ckpt.sh `file_list` `subfolder` `desiredInitialPartition(optional)`  
  e.g.  ./genbatch_ckpt.sh filelist sub_opt chem
  e.g. ./genbatch_ckpt.sh ALL sub_opt 
`filelist` a filename that has a list of selected (.gjf) including filenames but  __without extension__, line by line, see example filelist  
if wish to submit all .gjf files into calculation, simply type `ALL` instead at corresponding field
`subfolder` a subfolder to store all calculations relative to current wdir  
`desiredInitialPartition(optional)` to submit for a short time of optimization that generate .chk file to allow restart later,
if leave blank, ilahie will be used be default  


