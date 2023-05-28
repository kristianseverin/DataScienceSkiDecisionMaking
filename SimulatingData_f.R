# this function simulates decision making for n skiers in n trials with a fixed bias

df <- NULL
simulating_skiing <- function(nskiers,ntrials, bias){
  
  for (skier in 1:nskiers){  
    
    
    # saving information
    Source1 <- array(NA, ntrials)
    Source2 <- array(NA, ntrials)
    decision <- array(NA, ntrials)
    assessmentAvi <- array(NA, ntrials)
    assessmentTerrain <- array(NA, ntrials)
    temp_a <- array(NA, ntrials)  # temporary overall assessment
    a <- array(NA, ntrials) # overall assessment
    outcome <- array(NA, ntrials) # did they ski
    bias <- array(NA, ntrials)
    
    # create different bias levels (true parameter values)
    for (biasTrue in seq(0, 1, 0.1)){
    
    
    for (i in 1:ntrials){
      # create random assessment for avi conditions
      assessmentAvi[i] <- sample(accumulatedAviCond, 1, replace = TRUE)
      # make assessment for avi cond on 0-1 space (divide with n+1)
      Source1[i] <- assessmentAvi[i] / 7  # n is 6
      # create random assessment for terrain conditions
      assessmentTerrain[i] <- sample(accumulatedTerrainCond, 1, replace = TRUE)
      # make assessment for terrain cond on 0-1 space (divide with n+1)
      Source2[i] <- assessmentTerrain[i] / 5  # n is 4
      # get temporay overall assessment
      temp_a[i] <- SimpleBayes_f(biasTrue, Source1[i], Source2[i])
    
      
      # this nested ifelse gets an overall assessment on a normal scale
      a[i] <- ifelse(round(temp_a[i]*11,0) < 0, 0,  # a can be an integer from 0-10 
                     ifelse(round(temp_a[i]*11,0) > 10, 10, 
                            round(temp_a[i]*11,0)))
      # this nested ifelse gets the outcome. Did the person ski or not
      outcome[i] <- ifelse(a[i] >= 8, 0, 
                    ifelse(a[i] <= 4, 1, rbinom(1, 1, .5))) # all integers between 4 and 8 are computed as 50/50 
     
    
    
    
    # get everything in a tibble 
    sim_df <- tibble(skier, trial = seq(ntrials), bias = biasTrue, assessmentAvi, assessmentTerrain, Source1, Source2,temp_a, a, outcome)
    }
    if (exists("df")) { df <- rbind(df, sim_df)} else{df <- sim_df}
    
  } 
  }
  return(df)
  
}