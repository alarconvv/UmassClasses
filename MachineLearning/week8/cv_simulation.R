library(ISLR)
library(tidyverse)

Auto.dat <- Auto

p <- ggplot(data = Auto.dat, aes(x = horsepower, y = mpg)) +
  geom_point() + theme_bw()
plot(p)

glm.fit <- glm(mpg~horsepower, data = Auto.dat)
cv.err <- cv.glm(Auto.dat, glm.fit)
cv.n <- cv.err$delta[1]

cv.err.dat <- data.frame(degree = 1:5, er = rep(0, 5))

for(i in 1:5){
  glm.fit <- glm(mpg~poly(horsepower,i), data = Auto.dat)
  tmp <- cv.glm(Auto.dat, glm.fit)
  cv.err.dat[i,2] <- tmp$delta[1]
}

p <- ggplot(data = cv.err.dat, aes(x = degree, y = er)) +
  geom_point() + geom_line() + theme_bw()
plot(p)


## 10 fold
cv.err.dat10 <- data.frame(degree = 1:5, er = rep(0, 5))

for(i in 1:5){
  glm.fit <- glm(mpg~poly(horsepower,i), data = Auto.dat)
  tmp <- cv.glm(Auto.dat, glm.fit, K = 10)
  cv.err.dat10[i,2] <- tmp$delta[1]
}

p <- ggplot(data = cv.err.dat10, aes(x = degree, y = er)) +
  geom_point() + geom_line() + theme_bw()
plot(p)


## Repeat this process 20 times to estimate variability

## 10 fold

cv.rep <- lapply(1:20, function(n){
  cv.err.dat10 <- data.frame(degree = 1:5, er = rep(0, 5), sim = n)
  
  for(i in 1:5){
    glm.fit <- glm(mpg~poly(horsepower,i), data = Auto.dat)
    tmp <- cv.glm(Auto.dat, glm.fit, K = 10)
    cv.err.dat10[i,2] <- tmp$delta[1]
  }
  
  return(cv.err.dat10)
})


cv.rep <- bind_rows(cv.rep)

XX <- cv.rep %>% group_by(degree) %>% 
  summarise(m.e = mean(er), sd.e = sd(e))


p <- ggplot(data = XX, aes(x = degree, y = m.e)) +
  geom_point() + geom_line() + 
  geom_errorbar(data = XX, aes(x = degree, ymin = m.e - sd.e, ymax = m.e + sd.e))+
  theme_bw()
plot(p)


