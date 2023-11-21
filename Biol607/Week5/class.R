#'------------------------
#'Week 5
#'Correlation
#'@author Vra
#'-------------------------




# linear regression
#libraries
library(pacman)
pacman::p_load(dplyr,readr, ggplot2, broom, performance, here)

setwd(here::here())

## Linear regression

# 1 Load the data

seals <- read_csv('dataClass/data/17e8ShrinkingSeals Trites 1996.csv')

# 2 visualize data

ggplot(data = seals, aes(x = age.days, y = length.cm))+
  geom_point(alpha = 0.3)

# 3 fit our model
seal_lm <- lm(length.cm ~ age.days, data = seals)

# 4 evaluate our model assumtion

check_model(seal_lm)

# our pp check
check_predictions(seal_lm, iterations = 200)

# check normality 
check_normality(seal_lm) |> plot()
check_normality(seal_lm) |> plot(type = 'qq')

# check outliers
check_outliers(seal_lm) |> plot()
check_outliers(seal_lm) |> plot(type = 'bar')


# 5 evaluate our model for inference
summary(seal_lm)

# broom methods
tidy(seal_lm)
glance(seal_lm)

# 6 Visualize our fit model

ggplot(data = seals,
       mapping = aes(x = age.days, y = length.cm))+
  geom_point() +
  stat_smooth(method = 'lm')


# fat

fat <- read.csv("dataClass/data/17q04BodyFatHeatLoss Sloan and Keatinge 1973 replica.csv")

fat_plot <- ggplot(data = fat, aes(x = leanness, y = lossrate)) +
  geom_point()+
  geom_smooth(method =  lm, formula = y ~ x)
  

fat_plot


###



fat_mod <- lm(lossrate ~ leanness, data = fat)

# assumption
check_model(fat_mod)

# look parameters
tidy(fat_mod)

# plot with line and prediction CI

flat_plot +
  stat_smooth(method =  lm, formula = y ~ x)



###########
deet <- read.csv('dataClass/data/17q24DEETMosquiteBites.csv')

deet_plot <- ggplot(data = deet, aes(dose, bites))+
  geom_point()

deet_plot 

deet_mod <- lm (bites ~ dose,deet)

check_model(deet_mod)
check_normality(deet_mod) |> plot()
check_normality(deet_mod) |> plot(type = 'qq')
tidy(deet_mod)

deet_plot +
  stat_smooth(method = lm, formula = y~x)


#transformation

# Log transform
deet_mod_log <- lm(log(bites) ~ dose, data = deet)
check_model(deet_mod_log)

# or crate a  transformed  variable

deet <- deet |>
  mutate(log_bites = log(bites))

deet_mod_log_lm <- lm(log_bites ~ dose, data = deet)

ggplot(data =  deet,
       aes(dose, log_bites))+
  geom_point()+
  scale_y_log10()+
  geom_smooth(method = lm, formula = y ~ x)



# simulate

# make exercise
zoo

log_curve <- tibble(dose = seq(1.4, 6, length.out = 200)) |>
  augment(x = deet_mod_log, newdata = _, interval = 'confidence')|>
  #
  mutate(across(.fitted: .upper, exp))

deet_plot +
   geom_line(data = log_curve,
             aes(y= .fitted))+
  geom_ribbon(data = log_curve,
              aes(y = .fitted,
                  ymin = .lower,
                  ymax = .upper))


# transform problems
log(0)
log(0 + 1)
log(0 +.01)
# hyperbolict arcsin
asinh(0)
asinh(1)


# make zoo  exercise

# use also ggResidpanel

zoo <- read.csv("dataClass/data/17q02ZooMortality Clubb and Mason 2003 replica.csv")

# initial visualization to determine if lm is appropriate
zoo_plot <- ggplot(data=zoo, aes(x=mortality, y=homerange)) + 
  geom_point()

zoo_plot

# fit the model
zoo_mod <- lm(homerange ~mortality, data=zoo)

check_model(zoo_mod)
check_normality(zoo_mod) |> plot()
check_normality(zoo_mod) |> plot(type = 'qq')
tidy(zoo_mod)

#plot with line - is there a transform you want?
zoo_plot + 
  stat_smooth(method= lm, formula=y ~ x)


# fit the model
zoo_mod <- lm(homerange ~ mortality, data=zoo)
zoo_mod_log <- lm(log(homerange) ~ mortality, data=zoo)
AIC(zoo_mod, zoo_mod_log)

check_model(zoo_mod)
check_normality(zoo_mod) |> plot()
check_normality(zoo_mod) |> plot(type = 'qq')
tidy(zoo_mod)
exp(0.225) - 1

#plot with line - is there a transform you want?
zoo_plot + 
  stat_smooth(method= lm, formula=y ~ x)



################## Prediction
augment(deet_mod)


#generation  a data frame of values
# we want to look at

# data grid to get all value in a a observed
deet_pred_frame <- 
  modelr::data_grid(deet, dose = modelr::seq_range(dose, 100))


deet_pred_frame <- tibble(dose = seq(min(deet$dose),
                                     max(deet$dose)),
                          length.out= 100)


predict(deet_mod, newdata = deet_pred_frame)

predict(deet_mod, newdata = deet_pred_frame, interval = "confidence")

#CI

deet_pred_ci <- deet_pred_frame |>
  augment(x = deet_mod,
          newdata = _,
          interval = "prediction")

ggplot(data = deet,
       aes(x = dose, y = bites))+
  geom_point()+
  geom_line(data = dee)