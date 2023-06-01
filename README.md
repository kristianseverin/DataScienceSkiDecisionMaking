# DataScienceSkiDecisionMaking

This is a repository containing commented code used for the prouction of analyses and plots reported in the paper that can also be found in this repo.

### Archive ###
  - contains the archived files used in the process of making this paper. Nothing of interest is in here, but is included for scientific opennes

### Data ###
  - contains the empirical data. "skidata.csv" contains all data. 

### Functions ###
  - contains self-written function used to simulate data with and for prior sensitivity analyses

### ModelExecFiles ###
  - contains .exec files created for each model

# Paper #
  - is the paper wherin the analyses are introduced and discussed

# SimpleBayes.Rmd #
  - is the R code used for implementing the simple bayes model
# simplebayesML.stan #
  - is the simple bayes stan model 
# sbPriors
  - is the same as the simplebayesML.stan but fits different means and standard deviations for the bias parameter

# weightedBayes.Rmd #
  - is the R code used for implementing the weighted bayes model
# weightedBayes.stan #
  - is the weighted bayes stan model 
# wbPriors #
  - is the same as the simplebayesML.stan but fits different means and standard deviations for the bias, w1, and w2 parameters

Any reader interested in how the models were fit would benefit most from looking at the weighted bayes material, as this is the most complex model and consequently everything covered in this material is also covered in the simple bayes material.
  
