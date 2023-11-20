library(tidyverse)
library(ISLR)
library(MASS)
require(klaR)
require(pracma)

pos.ind <- sample(which(Default$default == 'Yes'), 200)
neg.ind <- sample(which(Default$default == 'No'), 200)

D <- Default[c(pos.ind, neg.ind), ]

D <- D %>% mutate(y = ifelse(default == 'Yes', 1, 0))

modelAssessment <- function(obs, pred){
  TP <- length(which(obs == 1 & pred == 1))
  TN <- length(which(obs != 1 & pred != 1))
  FP <- length(which(obs != 1 & pred == 1))
  FN <- length(which(obs == 1 & pred != 1))
  
  sens <- TP / (TP + FN)
  spec <- TN / (FP + TN)
  accu <- (TP + TN) / (TP + TN + FP + FN)
  
  TPR <- sens
  FPR <- 1 - spec
  
  L <- list(sens = sens, spec = spec, accu = accu, TPR = TPR, FPR = FPR)
  
  return(L)
}

obs <- D$y
## LDA
fit.lda <- lda(y~balance+income, data = D)
pred.lda <- predict(fit.lda, newdata = D)

lda.lab <- pred.lda$class
lda.per <- modelAssessment(obs, lda.lab)


## LDA
fit.qda <- qda(y~balance+income, data = D)
pred.qda <- predict(fit.qda, newdata = D)

qda.lab <- pred.qda$class
qda.per <- modelAssessment(obs, qda.lab)

## Logistic regression
fit.logit <- glm(y~balance+income, data = D, family = 'binomial')
pred.logit <- predict(fit.logit, newdata = D, type = 'response')
logit.lab <- ifelse(pred.logit >= 0.5, 1, 0)
logit.per <- modelAssessment(obs, logit.lab)

train.ind <- c(pos.ind, neg.ind)

test.D <- Default[-train.ind,c(3,4)]
test.lab <- ifelse(Default[-train.ind,1] == 'Yes',1, 0)

## predict on test data
pred.lda.t <- predict(fit.lda, newdata = test.D)
lda.lab.t <- pred.lda.t$class
lda.per.t <- modelAssessment(test.lab, lda.lab.t)

pred.qda.t <- predict(fit.qda, newdata = test.D)
qda.lab.t <- pred.qda.t$class
qda.per.t <- modelAssessment(test.lab, qda.lab.t)

pred.logit.t <- predict(fit.logit, newdata = test.D, type = 'response')
logit.lab.t <- ifelse(pred.logit.t >= 0.5, 1, 0)
logit.per.t <- modelAssessment(test.lab, logit.lab.t)

thresh <- seq(0.01, 0.99, by = 0.01)

TPR <- {}
FPR <- {}
for(t in thresh){
  logit.lab.t <- ifelse(pred.logit.t >= t, 1, 0)
  logit.per.t <- modelAssessment(test.lab, logit.lab.t)
  TPR <- c(TPR, logit.per.t$TPR)
  FPR <- c(FPR, logit.per.t$FPR)
}

sorted.ind <- sort(FPR, index.return = TRUE)$ix
plot(FPR[sorted.ind], TPR[sorted.ind], type = 'l')

plot(FPR, TPR, type = 'l')
trapz(FPR[sorted.ind], TPR[sorted.ind])

X <- data.frame(t = thresh, TPR = TPR, FPR = FPR)

yy <- sqrt(TPR) * sqrt(1 - FPR)

plot(thresh, yy)


