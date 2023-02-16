library(glmnet)
library(microbenchmark)

# model parameters 
settings <- expand.grid(n = c(100, 200, 400, 800), d = c(32, 64, 128, 256, 512))
n_settings <- nrow(settings)

# settings for simulation 
seed <- 123
alpha <- 0.5
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
    times = 5
  )
  
  # save results 
  all_results[[i]]$input <- list(seed = seed,
                                 alpha = alpha,
                                 n = n,
                                 d = d
                                 )
  
  all_results[[i]]$output <- mbm
}


