#-----------------
# Sample
#
#
#------------------


# 1. What is a population you sample?
#   
# All Published papers in the last 10 years
# that work with total evidence, 
# molecular or morphological phylogenies (Reptiles).
# 
# 2. How do you ensure validity, reliability, 
# and representativeness of a sample from your population?
# 
# I take care about they have DOI, they are registered in Web of sciences.




#'--------------------------
#'
#'Sampling
#'@author Vra
#'
#'
#'
#'---------------------------


# Simulating data with dplyr


#load libraries

library(pacman)
pacman::p_load(dplyr, tidyr, ggplot2)

theme_set(theme_classic(base_size = 4))

#we have done ramdom number generation

runif(10, min = 0, max = 10)


tibble(sims = 1:10,
       rand= runif(10,0,10))
?tibble()
# the inefficient way to simulate 10 ramdom uniform number
# use group by in order to do things by row (or by simulation)
sim_column <- tibble(sim= 1:10) |>
group_by(sims) |>
  mutate(rand= runif(1, min = 0, max= 10)) |>
  ungroup()

#Now lets generate the sampling distribution of a mean


# lets set some parameter for  a population

m <- 15 # mean  
s <- 7 # SD

n <- 10 # 10 replication

#lets use dplyr

means_sim <- tibble(sims = 1:1000) |>
  group_by(sims) |>
  mutate( sample_mean = rnorm(n,mean= m , sd = s) |> mean()) |> 
  ungroup()

means_sim           

ggplot(means_sim,
       aes(x= sample_mean))+
  geom_histogram(bins = 200, fill = "darkorange")



#'EXERCISE Try getting the sample distribution with n = 10 
#'from a uniform distribution. Is the sample distribution normal? 
#'If you up the number of simulations, does it make it easier to see?

means_sim_runif <- tibble(simsU = 1:1000) |>
  group_by(simsU) |>
  mutate( sample_meanU = runif(10,1,50) |> mean()) |> 
  ungroup()

means_sim_runif           

ggplot(means_sim_runif  ,
       aes(x= sample_meanU))+
  geom_histogram(bins = 200, fill = "darkblue")

sd(means_sim_runif$sample_meanU)
sd(means_sim$sample_mean)

# hat if what to calculate multiple population parameters

# how do you make a summulation data set for multiple calculation?


tibble(sims= 1:5) |>
  groups_by(sims) |>
  mutate( samle = rnorm(10))

sample_sims <- tibble(sims = 1:1000) |>
  group_by(sims) |>
  reframe(sample = rnorm(n, m, s))

sample_properties <- sample_sims |>
  group_by(sims) |>
  summarize(sample_mean= mean(sample),
            sample_sd = sd(sample),
            sample_median = median(sample))

ggplot(sample_properties,
       aes(x =sample_median))+
  geom_histogram(bins= 20, fill= "darkred")

# what if to look at everythin

sample_properties |>
  pivot_longer(cols = -sims) |>
  ggplot(aes(x = value)) +
  geom_histogram(bins = 200)+
  facet_wrap(vars(name))


####
# lets look at sample size and SE

# tidyr:: croosing

crossing(x = 1:13, y =7:9)
crossing(sims = 1:3, n = 1:4, m = 1:5, d = 5:10)

  
#mean and sample size

sims_frame <- crossing(sims = 1:1000, n = seq(3,21, by= 3)) |>
  group_by(sims,n) |>
  mutate(sample_mean =  rnorm(n, mean = m, sd = s) |> mean()) |>
  ungroup()

# how  my sample distributen change by n?

ggplot(sims_frame, aes(x = sample_mean))+
  geom_histogram(bins= 200, fill = "purple") +
  facet_wrap(vars(n))


sims_frame |> 
  group_by(n) |>
  summarize(se = sd(sample_mean)) |>
  
  ggplot(mappin = aes(x = n, y = se))+
  geom_line()+
  geom_point()


## Exercise! Try this out but, make a plot of the SE
## of the sd and median under different sample sizes
## use rnorm or runif - you are going to need
## reframe() here as well as crossing()

# write out in comments what you are going to do
# step by step
# THEN code it




#mean and sample size


new <- crossing(sims = 1:1000, n = seq(3,40, by= 5)) |>
  group_by(sims,n) |>
  reframe(sd = runif(n, min = 5, max = 100) |> sd(),
          mean = runif(n, min = 5, max = 100) |> median()) 

ggplot(new, aes(x = sd))+
  geom_histogram(bins= 200, fill = "darkorange") +
  facet_wrap(vars(n))


new |> 
  group_by(n) |>
  summarize(se_sd = sd(sd),se_mean = sd(mean)) |>
  ggplot(mappin = aes(x = n, y = se))+
  geom_line(aes(y=se_sd), color= "darkblue")+
  geom_line(aes(y=se_mean), color= "darkorange")


##########################################################

#Solution

#create 
sims_frame <-crossing(sims= 1:1000, n = c(3,5,7,9,12))


sims_frame <- sims_frame |>
  group_by(sims,n) |>
  reframe(sample_data =  rnorm(n, mean = m, sd = s))

sim_properties <- sims_frame |>
  group_by(sims, n) |>
  summarise(sample_median = meadian (sample_data),
            sd = sd(sample_data),
            .groups = 'drop')

sim_se <- sim_properties |>
  group_by(n) |>
  summarize(se_median,)

################################# look for finished it

















