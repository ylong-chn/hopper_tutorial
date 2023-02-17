# Mini project to get familiar with Hopper

In this tutorial we are trying to compare the runtime of R package `glmnet` under various settings with the help of GMU's Hopper HPC clusters. 

There are four files in this repository: 

- The R file `pre_hopper.R` contains the code we would like to run multiple times on a larger scale; 
- The R file `glmnet_timer.R` contains the code from previous file but interacts with Hopper to load parameters and save results; 
- The Slurm file `glmnet_timer.slurm` is the scheduler to run jobs on Hopper;
- Finally, the `Rmd` file loads the results and generate the summary plot we need for research. 

Steps to run simulation on Hopper: 

- step 0: log in and set up R on Hopper: 
  - code for login: `ssh [your Mason NetID]@hopper.orc.gmu.edu` 
  - load R: `module load r` 
  - in R, install the following packages using `install.packages("[package name]")`: `glmnet`, `stringr`, `argparser`, `microbenchmark`

- Step 1: Open Globus and transfer the R file `glmnet_timer.R` and the associated Slurm file `glmnet_timer.slurm` to your Hopper clusters storage space. 

To submit the slurm job, run the following code: 

`sbatch --array=1-10 glmnet_timer.slurm` 

where `--array` specifies how many tasks you want to run in parallel in this job. 
