# Mini project to get familiar with Hopper

In this tutorial we will compare the runtime of R package `glmnet` under various settings with the help of GMU's Hopper HPC clusters. 

There are four files in this repository: 

- The R file `pre_hopper.R` contains the code we would like to run multiple times on a larger scale; 
- The R file `glmnet_timer.R` contains the code from previous file but interacts with Hopper to load parameters and save results; 
- The Slurm file `glmnet_timer.slurm` is the scheduler to run jobs on Hopper;
- Finally, the `Rmd` file loads the results and generate the summary plot we need for research. 

Steps to run this simulation on Hopper: 

- step 0: log in and set up R on Hopper: 
  - code for login: `ssh [your Mason NetID]@hopper.orc.gmu.edu` 
  - go to your scratch folder, which is your "personal playground" on Hopper, by using code `cd /scratch/[Mason NetID]`
  - load R: `module load r` 
  - type `R` to load R on Hopper 
  - in R, install the following packages using `install.packages("[package name]")`: `glmnet`, `stringr`, `argparser`, `microbenchmark`

- Step 1: Open Globus and transfer the R file `glmnet_timer.R` and the associated Slurm file `glmnet_timer.slurm` to your Hopper clusters storage space. 
  - to use Globus, log in at https://www.globus.org/ and go to https://www.globus.org/globus-connect-personal to download Globus Connect Personal so Globus can access your local files
  - in the transfer window, select your local space while for the other side, search "gmu ARGO" and select "gmu#ARGO-1.ORC"
  - make sure to transfer all you files to your personal **scratch** folder instead of home directory as there is too much traffic in the home directory that can significantly slow you down
- Step 2: Submit your Slurm job. 
  - To submit the Slurm job, run the following code: 

`sbatch --array=1-10 glmnet_timer.slurm` 

where `--array` specifies how many tasks you want to run in parallel in this job. 

- Step 3: Transfer your result files from your result directory to local using Globus. 
- Step 4: Play around with the `Rmd` file to create simulation output for research. 


