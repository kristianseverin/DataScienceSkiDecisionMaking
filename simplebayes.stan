// The input data is a vector 'y' of length 'N'.
data {
  int<lower=0> N;  // number of trials
  vector[N] outcome; // rating of safety for each 'N'
  array[N] real<lower=0, upper = 1> Source1;  // rating scaled 0.1 - 0.9
  array[N] real<lower=0, upper = 1> Source2;  // feedback scaled 0.1 - 0.9
  
}

// transformed data
transformed data{
  array[N] real l_Source1;
  array[N] real l_Source2;
  vector[N] l_outcome;
  l_Source1 = logit(Source1);  // get it on a -inf - inf scale
  l_Source2 = logit(Source2);  // get it on a -inf - inf scale
  l_outcome = logit(outcome/3);
}


// The parameters accepted by the model. Our model
// accepts parameters 'bias' and 'sd'
// i.e., do you have a prevaleence of choosing to ski or not when faced with a choice
parameters {
  real bias;
  real sd;
}

model {
  target += normal_lpdf(bias | 0, 1);
  target += normal_lpdf(sd | 0, .5)  - normal_lccdf(0 | 0, .5);
  target += normal_lpdf(outcome | bias + 0.5*to_vector(l_Source1) + 0.5*to_vector(l_Source2), sd);
}

generated quantities{
  real bias_prior;
  real sd_prior;
  array[N] real log_lik;
  
  bias_prior = normal_rng(0, 1);
  sd_prior = normal_rng(1,1);
  
  for (n in 1:N){  
    log_lik[n] = normal_lpdf(outcome[n] | bias + 0.5*l_Source1[n] +  0.5*l_Source2[n], sd);
  }
  
}
