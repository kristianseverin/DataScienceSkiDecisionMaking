// The input data is a vector 'y' of length 'N'.
data {
  int<lower=0> N;  // number of trials
  array[N] int outcome; // rating of safety for each 'N'
  array[N] real<lower=0, upper = 1> Source1;  // rating scaled 0.1 - 0.9
  array[N] real<lower=0, upper = 1> Source2;  // feedback scaled 0.1 - 0.9
  
}

// transformed data
transformed data{
  array[N] real l_Source1;
  array[N] real l_Source2;
  l_Source1 = logit(Source1);  // get it on a -inf - inf scale
  l_Source2 = logit(Source2);  // get it on a -inf - inf scale
}


// The parameters accepted by the model. Our model
// accepts parameters 'bias' and 'sd'
// i.e., do you have a prevaleence of choosing to ski or not when faced with a choice
parameters {
  real bias;
}

model {
 target += normal_lpdf(bias | 0, 1);
 target += bernoulli_logit_lpmf(outcome | bias + to_vector(l_Source1) + to_vector(l_Source2));
}

generated quantities{
  real bias_prior;
  real bias_posterior;
  int<lower=0, upper=N> prior_preds; // distribution of skiing/non skiing choices according to the prior
  int<lower=0, upper=N> posterior_preds; // distribution of skiing/non skiing choices according to the posterior
  int<lower=0, upper=N> prior_preds5;
  int<lower=0, upper=N> post_preds5;
  int<lower=0, upper=N> prior_preds7;
  int<lower=0, upper=N> post_preds7;
  int<lower=0, upper=N> prior_preds9;
  int<lower=0, upper=N> post_preds9;
  
  array[N] real log_lik;
  
  bias_prior = inv_logit(normal_rng(0, 1));
  bias_posterior = inv_logit(bias);
  prior_preds = binomial_rng(N, bias_prior);
  posterior_preds = binomial_rng(N, inv_logit(bias));
  prior_preds5 = binomial_rng(N, inv_logit(bias_prior * logit(0.5)));
  prior_preds7 = binomial_rng(N, inv_logit(bias_prior * logit(0.7)));
  prior_preds9 = binomial_rng(N, inv_logit(bias_prior * logit(0.9)));
  post_preds5 = binomial_rng(N, inv_logit(bias * logit(0.5)));
  post_preds7 = binomial_rng(N, inv_logit(bias * logit(0.7)));
  post_preds9 = binomial_rng(N, inv_logit(bias * logit(0.9)));
  
  for (n in 1:N){  
    log_lik[n] = bernoulli_logit_lpmf(outcome[n] | bias + l_Source1[n] +  l_Source2[n]);
  }
  
}
