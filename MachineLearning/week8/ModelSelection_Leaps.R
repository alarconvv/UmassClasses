library('ISLR')
library('MASS')
library('leaps')
library(tidyverse)


names(Hitters)
dim(Hitters)
sum(is.na(Hitters$Salary)) ## 59 salaries are missing from the data set.
## Removing the NAs
Hitters = na.omit(Hitters)
dim(Hitters)
sum(is.na(Hitters$Salary)) ## All NAs are removed

Hitters <- na.omit(Hitters)
## Perform best subset selection using leaps package
## Fit with up to 19 variables
reg.fit.full = regsubsets(Salary~.,Hitters, nvmax = 19)
reg.summary = summary(reg.fit.full)
names(reg.summary)

par(mfrow = c(1,3))
plot(reg.summary$adjr2, xlab = 'Number of variables', ylab = "Adjusted R2", type = 'l')
which.max(reg.summary$adjr2)
points(11, reg.summary$adjr2[11], col = 'red', pch = 20, cex = 2)

plot(reg.summary$cp, xlab = 'Number of variables', ylab = "Cp", type = 'l')
which.min(reg.summary$cp)
points(10, reg.summary$cp[10], col = 'red', pch = 20, cex = 2)

plot(reg.summary$bic, xlab = 'Number of variables', ylab = "BIC", type = 'l')
which.min(reg.summary$bic)
points(6, reg.summary$bic[6], col = 'red', pch = 20, cex = 2)

?plot.regsubsets
par(mfrow = c(1,1))
plot(reg.fit.full, scale = "r2")
plot(reg.fit.full, scale = "bic")
coef(reg.fit.full, 6)

## Forward and Backward selection
reg.fit.fwd = regsubsets(Salary~., data = Hitters, nvmax = 19, method = "forward")
summary(reg.fit.fwd)
reg.fit.bwd = regsubsets(Salary~., data = Hitters, nvmax = 19, method = "backward")
summary(reg.fit.bwd)

## Note that the best 7-variable models obtained by forward selection backward s
## election, and 
## best subset selection are different.
coef(reg.fit.full, 7)
coef(reg.fit.fwd, 7)
coef(reg.fit.bwd, 7)


