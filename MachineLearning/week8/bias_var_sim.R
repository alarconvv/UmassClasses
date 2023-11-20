library(tidyverse)

f <- function(x){
  y <- (x-2)^3 + (x-2)^2 + 1
  return(y)
}

x <- seq(1, 3, 0.1)
y <- f(x) + rnorm(length(x), 0, 0.2)

D <- data.frame(x = x, y = y)

p <- ggplot(data = D, aes(x = x, y = y)) + 
  geom_point(shape = 20, color = 'red') +
  geom_line() + theme_bw()
plot(p)

## Try a few linear regression based estimators
lin.fit  <- lm(y~x, data = D)
cub.fit  <- lm(y~poly(x,3), data = D)
five.fit <- lm(y~poly(x,5), data = D)
ten.fit  <- lm(y~poly(x,10), data = D)

y.true <- f(x)

fits <- data.frame(x = x, true.model = y.true, 
                   lin = lin.fit$fitted.values,
                   cub = cub.fit$fitted.values,
                   five = five.fit$fitted.values,
                   ten = ten.fit$fitted.values)


fits.long <- fits %>% pivot_longer(-x, names_to = 'model', values_to = 'val')

fits.long$model <- factor(fits.long$model, 
                          levels = c('true.model', 'lin', 'cub', 'five', 'ten'))

p <- ggplot(data = fits.long, aes(x = x, y = val, color = model)) +
  geom_line() + 
  geom_point(data = D, aes(x = x, y = y), shape = 20, color = 'red', size = 6) + 
  theme_bw()
plot(p)

n <- length(x)
lin.MSE.train <- 1/n * sum((y - lin.fit$fitted.values)^2) 
cub.MSE.train <- 1/n * sum((y - cub.fit$fitted.values)^2)
five.MSE.train <- 1/n * sum((y - five.fit$fitted.values)^2)
ten.MSE.train <- 1/n * sum((y - ten.fit$fitted.values)^2)

MSE.train <- data.frame(type = 'train', lin = lin.MSE.train, cub = cub.MSE.train,
                        five = five.MSE.train, ten = ten.MSE.train)

test.x <- seq(1, 3, 0.01)
lin.y.pred <- predict(lin.fit, newdata = data.frame(x = test.x))
cub.y.pred <- predict(cub.fit, newdata = data.frame(x = test.x))
five.y.pred <- predict(five.fit, newdata = data.frame(x = test.x))
ten.y.pred <- predict(ten.fit, newdata = data.frame(x = test.x))

y.test <- f(test.x)

n.test <- length(test.x)
lin.MSE.test <- 1/n.test * sum((y.test - lin.y.pred)^2) 
cub.MSE.test <- 1/n.test * sum((y.test - cub.y.pred)^2)
five.MSE.test <- 1/n.test * sum((y.test - five.y.pred)^2)
ten.MSE.test <- 1/n.test * sum((y.test - ten.y.pred)^2)

MSE.test <- data.frame(type = 'test', lin = lin.MSE.test, cub = cub.MSE.test,
                        five = five.MSE.test, ten = ten.MSE.test)

MSE <- rbind(MSE.train, MSE.test)

MSE.long <- MSE %>% pivot_longer(-type, names_to = 'model', values_to = 'MSE')

MSE.long$model <- factor(MSE.long$model, 
                          levels = c('true.model', 'lin', 'cub', 'five', 'ten'))


p <- ggplot(data = MSE.long, aes(x = model, y = MSE)) +
  geom_line(aes(group = 1)) + 
  geom_point() +
  facet_grid(~type)+
  theme_bw()
plot(p)


