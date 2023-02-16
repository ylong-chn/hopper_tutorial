#!/bin/sh

## Specify the name for your job, this is the job name by which Slurm will
## refer to your job.  This can be different from the name of your executable
## or the name of your script file

#SBATCH --job-name glmnet_timer

## General partitions: all-LoPri, all-HiPri, bigmem-LoPri, bigmem-HiPri, gpuq
##    all-*     Will run jobs on (almost) any node available
##    bigmem-*  Will run jobs only on nodes with 512GB memory
##    *-HiPri   Will run jobs for up to 12 hours
##    *-LoPri   Will run jobs for up to 5 days
##    gpuq      Will run jobs only on nodes with GPUs (40, 50, 55, 56)
## Restricted partitions: CDS_q, CS_q, STATS_q, HH_q, GA_q, ES_q, COS_q
##                        Provide high priority access for contributors

#SBATCH --partition=normal

## Deal with output and errors.  Separate into 2 files (not the default).
## May help to put your result files in a directory: e.g. /scratch/%u/logs/...
## NOTE: %u=userID, %x=jobName, %N=nodeID, %j=jobID, %A=arrayID, %a=arrayTaskID

#SBATCH --output=/scratch/%u/%x-%j.out  # Output file
#SBATCH --error=/scratch/%u/%x-%j.err   # Error file
#SBATCH --mail-type=BEGIN,END,FAIL         # ALL,NONE,BEGIN,END,FAIL,REQUEUE,..
#SBATCH --mail-user=ylong5@gmu.edu     # Put your GMU email address here

## Specifying an upper limit on needed resources will improve your scheduling
## priority, but if you exceed these values, your job will be terminated.
## Check your "Job Ended" emails for actual resource usage info.

#SBATCH --cpus-per-task=2
#SBATCH --mem-per-cpu=8GB         # Total memory needed for your job (suffixes: K,M,G,T)
#SBATCH --time=0-02:00   # Total time needed for your job: Days-Hours:Minutes

## Load the relevant modules needed for the job
module load r

## Start the job
Rscript --no-restore --quiet --no-save glmnet_timer.R \
  --task ${SLURM_ARRAY_TASK_ID}\
  --job ${SLURM_ARRAY_JOB_ID}\
  --alpha 0.5\