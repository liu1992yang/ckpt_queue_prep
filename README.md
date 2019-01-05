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
## intermediate log files
intermediate log files will be stored in corresponding folder of the initial geometry(generated with this script as well)
