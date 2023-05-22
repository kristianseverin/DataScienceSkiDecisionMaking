# a function that fits different prior values to the simulated data
parameter_recovery <- function(prior_mean, prior_sd) {

# parameter recovery 
parameter_recovery_df <- NULL  
  
  for (biasLvl in unique(sim_wide$bias_1)) {
    
    dataSimpleBayesParam <- sim_wide %>% filter(
      bias_4 == biasLvl
    )  
    
 samples <- mod_simpleBayes$sample(
    data = list(
      N = 100,
      S = nskiers,
      outcome = as.matrix(dataSimpleBayesParam[,2:11])[1:100,],
      Source1 = as.matrix(sim_wide[,12:21])[1:100,],
      Source2 = as.matrix(sim_wide[,22:31])[1:100,],
      prior_mean = prior_mean,
      prior_sd = prior_sd
    ),
    seed = 1000,
    chains = 1,
    parallel_chains = 1,
    threads_per_chain = 1,
    iter_warmup = 1000,
    iter_sampling = 2000,
    refresh = 0,
    max_treedepth = 20,
    adapt_delta = 0.99,
  )
  
 draws_df_param_recov <- as_draws_df(samples$draws()) 
 temp_param <- tibble(
   biasEstScaled1 = inv_logit_scaled(draws_df_param_recov$`bias[1]`), 
   biasTrue1 = biasLvl, 
   biasEst1 = draws_df_param_recov$`bias[1]`,

    
    prior_mean = prior_mean,
    prior_sd = prior_sd,
    )
 
 if (exists("parameter_recovery_df")) {parameter_recovery_df <- rbind(parameter_recovery_df, temp_param)} else {parameter_recovery_df <- temp_param}
 
  }
  
  return(parameter_recovery_df)
  
}
