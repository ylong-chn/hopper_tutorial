library(glmnet)
library(microbenchmark)
library(argparser)
library(stringr)

# load argument
args <- arg_parser('Run the simulation study.') %>%
  add_argument('--results-dir', type = 'character', help = 'Result path', default = file.path('glmnet_timer')) %>%
  add_argument('--job', type = 'integer', help = 'job ID.') %>%
  add_argument('--task', type = 'integer', help = 'Task number.') %>%
  add_argument('--alpha', type = 'double', help = 'alpha for simulation.') %>%
  parse_args()

# model parameters 
settings <- expand.grid(n = c(100, 200, 400, 800), d = c(32, 64, 128, 256, 512))
n_settings <- nrow(settings)

# settings for simulation 
seed <- args$task
alpha <- args$alpha
nlambda <- 100
set.seed(seed)

all_results <- vector(mode = "list", length = n_settings)

# generate data
for (i in 1:n_settings) {
  # generate data 
  n <- settings$n[i]
  d <- settings$d[i]
  
  x <- matrix(rnorm(n * d), n, d)
  y <- rnorm(n)
  
  # run glmnet
  mbm <- microbenchmark(
    cvfit <- cv.glmnet(
      x = x, y = y,
      alpha = alpha, 
      nlambda = nlambda
    ),
    times = 10
  )
  
  # save results 
  all_results[[i]]$input <- list(seed = seed,
                                 alpha = alpha,
                                 n = n,
                                 d = d
  )
  
  all_results[[i]]$output <- mbm
}

# create data file name and save result 
job <- args$job
folder_name <- paste(args$results_dir, paste("job=", job, "alpha=", alpha, "_result", sep = ""), sep = "/")
dir.create(file.path(folder_name), showWarnings = F, recursive = T)

job_id <- sprintf('alpha=%1$s-task=%2$s', alpha, seed)
job_file <- file.path(folder_name, paste(job_id, 'rds', sep = '.'))

saveRDS(all_results, file = job_file)