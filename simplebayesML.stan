// The input data is a vector 'y' of length 'N'.
data {
  int<lower=0> N;  // number of trials
  int<lower=0> S;  // number of skiers
  array[N,S] int outcome; // rating of safety for each 'N'
  array[N,S] real<lower=0, upper = 1> Source1;  // rating scaled 0.1 - 0.9
  array[N,S] real<lower=0, upper = 1> Source2;  // feedback scaled 0.1 - 0.9
}

// transformed data
transformed data{
  array[N, S] real l_Source1;
  array[N, S] real l_Source2;
  l_Source1 = logit(Source1);  // get it on a -inf - inf scale
  l_Source2 = logit(Source2);  // get it on a -inf - inf scale
}


// The parameters accepted by the model. Our model
// accepts parameters 'bias' and 'sd'
// i.e., do you have a prevaleence of choosing to ski or not when faced with a choice
parameters {
  real biasM;
  real biasSD;
  array[S] real z_bias;
}

transformed parameters{
  vector[S] biasC;
  vector[S] bias;
  biasC = biasSD * to_vector(z_bias);
  bias = biasM + biasC;
}


model {
  target +=  normal_lpdf(biasM | 0, 1);
  target +=  normal_lpdf(biasSD | 0, 1)  - normal_lccdf(0 | 0, 1);
  target += std_normal_lpdf(to_vector(z_bias));
  
  for (s in 1:S){
  target +=  bernoulli_logit_lpmf(outcome[,s] | bias[s] + 
                                          0.5*to_vector(l_Source1[,s]) + 
                                          0.5*to_vector(l_Source2[,s]));

  }
}

generated quantities{
  array[S] int prior_preds; // distribution of skiing/non-skiing choices according to the prior
  array[S] int posterior_preds; // distribution of skiing/non-skiing choices according to the posterior
  array[S, N] real log_lik;
  
  array[S] real bias_prior;
  array[S] real bias_posterior;
  
  for (s in 1:S) {
    bias_prior[s] = inv_logit(normal_rng(0, 1));
    bias_posterior[s] = inv_logit(bias[s]);
    
    for (n in 1:N) {
   
      log_lik[s, n] = bernoulli_logit_lpmf(outcome[n, s] | bias[s] + 0.5*l_Source1[n, s] + 0.5*l_Source2[n, s]);
    }
  }
for (s in 1:S) {
  prior_preds[s] = binomial_rng(1, bias_prior[s]);
  posterior_preds[s] = binomial_rng(1, inv_logit(bias[s]));
  }
}
