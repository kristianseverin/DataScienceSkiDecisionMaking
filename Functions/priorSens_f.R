# a function that fits different prior values to the simulated data
prior_sens_S <- function(prior_mean, prior_sd) {
  
  samples_simpleS <- mod_SimpleBayesS$sample(
    data = list(
      N = nrow(sim_wide_simpleS),
      S = nskiers,
      outcome = as.matrix(sim_wide_simpleS[,2:11]),
      Source1 = as.matrix(sim_wide_simpleS[,12:21]),
      Source2 = as.matrix(sim_wide_simpleS[,22:31]),
      bias = as.matrix(sim_wide_simpleS[,32:41]),
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
  
  draws_df_sens <- as_draws_df(samples_simpleS$draws()) 
  temp <- tibble(
    bias_prior1 = draws_df_sens$`bias_prior[1]`, 
    bias_posterior1 = draws_df_sens$`bias_posterior[1]`, 
    prior_preds1 = draws_df_sens$`prior_preds[1]`, 
    posterior_preds1 = draws_df_sens$`posterior_preds[1]`,
    
    bias_prior2 = draws_df_sens$`bias_prior[2]`, 
    bias_posterior2 = draws_df_sens$`bias_posterior[2]`, 
    prior_preds2 = draws_df_sens$`prior_preds[2]`, 
    posterior_preds2 = draws_df_sens$`posterior_preds[2]`,
    
    bias_prior3 = draws_df_sens$`bias_prior[3]`, 
    bias_posterior3 = draws_df_sens$`bias_posterior[3]`, 
    prior_preds3 = draws_df_sens$`prior_preds[3]`, 
    posterior_preds3 = draws_df_sens$`posterior_preds[3]`,
    
    bias_prior4 = draws_df_sens$`bias_prior[4]`, 
    bias_posterior4 = draws_df_sens$`bias_posterior[4]`, 
    prior_preds4 = draws_df_sens$`prior_preds[4]`, 
    posterior_preds4 = draws_df_sens$`posterior_preds[4]`,
    
    bias_prior5 = draws_df_sens$`bias_prior[5]`, 
    bias_posterior5 = draws_df_sens$`bias_posterior[5]`, 
    prior_preds5 = draws_df_sens$`prior_preds[5]`, 
    posterior_preds5 = draws_df_sens$`posterior_preds[5]`,
    
    bias_prior6 = draws_df_sens$`bias_prior[6]`, 
    bias_posterior6 = draws_df_sens$`bias_posterior[6]`, 
    prior_preds6 = draws_df_sens$`prior_preds[6]`, 
    posterior_preds6 = draws_df_sens$`posterior_preds[6]`,
    
    bias_prior7 = draws_df_sens$`bias_prior[7]`, 
    bias_posterior7 = draws_df_sens$`bias_posterior[7]`, 
    prior_preds7 = draws_df_sens$`prior_preds[7]`, 
    posterior_preds7 = draws_df_sens$`posterior_preds[7]`,
    
    bias_prior8 = draws_df_sens$`bias_prior[8]`, 
    bias_posterior8 = draws_df_sens$`bias_posterior[8]`, 
    prior_preds8 = draws_df_sens$`prior_preds[8]`, 
    posterior_preds8 = draws_df_sens$`posterior_preds[8]`,
    
    bias_prior9 = draws_df_sens$`bias_prior[9]`, 
    bias_posterior9 = draws_df_sens$`bias_posterior[9]`, 
    prior_preds9 = draws_df_sens$`prior_preds[9]`, 
    posterior_preds9 = draws_df_sens$`posterior_preds[9]`,
    
    bias_prior10 = draws_df_sens$`bias_prior[10]`, 
    bias_posterior10 = draws_df_sens$`bias_posterior[10]`, 
    prior_preds10 = draws_df_sens$`prior_preds[10]`, 
    posterior_preds10 = draws_df_sens$`posterior_preds[10]`,
    
    prior_mean = prior_mean,
    prior_sd = prior_sd,
    
    
  )
  
  return(temp)
  
}
