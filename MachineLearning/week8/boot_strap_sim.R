library(MASS)
library(tidyverse)

## Simulation for R = a X + (1 - a) Y
mu.x <- 1
mu.y <- 1.4
s.x2 <- 1
s.y2 <- 1.25
s.xy <- 0.5

## Covariance matrix
S <- matrix(c(s.x2, s.xy, s.xy, s.y2), ncol = 2, byrow = T)

## True alpha
a <- (s.y2 - s.xy) / (s.x2 + s.y2 - 2 * s.xy)

## a.hat is an estimator of a.
n <- 100
m <- 50
d <- lapply(1:m, function(i){
  xy <- mvrnorm(n, c(mu.x, mu.y), S) ## one sample of size n
  return(data.frame(xy, sim = i))
})

d <- bind_rows(d)
colnames(d) <- c('X', 'Y', 'sim')

my.stats <- d %>% group_by(sim) %>% 
  summarise(s.x2_hat = (1/(n-1)) * sum((X - mean(X))^2),
            s.y2_hat = (1/(n-1)) * sum((Y - mean(Y))^2),
            s.xy_hat = (1/(n-1)) * sum((X - mean(X))*(Y - mean(Y))))
a.hat <- my.stats %>% 
  transmute(a.hat = (s.y2_hat - s.xy_hat) / (s.x2_hat + s.y2_hat - 2 * s.xy_hat))

hist(a.hat$a.hat)
mean(a.hat$a.hat)
sd(a.hat$a.hat)

## Use a Bootstrap strategy for the same problem
## set m = 1
## generate 1 data set of size 100
## in the loop sample the rows with replacement
## treat each as a fresh new data set
## copy the rest exactly as is
## compare the distributions


