# libraries
library(devtools)
#Sdevtools::install_github("jfieberg/Data4Ecologists")
library(Data4Ecologists)
library(ggplot2)
library(patchwork)
library(tidyverse)
library(performance)
library(modelbased)
library(lme4)
library(merTools)
library(glmmTMB)
library(broom.mixed)



data("bearmove")

head(bearmove)

bearmove <- bearmove |> 
  mutate(BearID = as.character(BearID),
         BearIDYear = as.character(BearIDYear))

ggplot(bearmove,
       aes(log.move, hr, color = BearID))+
  geom_point() +
  facet_wrap(BearID ~ .)

bear_int <- lmer(hr ~log.move + (1|BearID), data = bearmove)

check_model(bear_int)

check_predictions(bear_int)


check_normality(bear_int, effect = 'random') |> plot()

# evaluate model

summary(bear_int)


# look ar things in more details
# Random effect is the same like hidden variable models

tidy(bear_int)

tidy(bear_int, effect = "fixed")
confint(bear_int)

ranef(bear_int)

tidy(bear_int, effect = "ran_vals")

#viz RE
estimate_grouplevel(bear_int) |> plot()

coef(bear_int)

r2(bear_int)


# Viz from modelbased
#
estimate_relation(bear_int) |> plot()


ggplot(bearmove,
       aes(log.move, hr, color = BearID))+
  geom_point() +
  geom_line(estimate_relation(bear_int), aes(y = Pre))

# show RE - effect of random 

estimate_relation(bear_int, include_random = TRUE) |> plot()


estimate_relation(bear_int, include_random = TRUE) |>
  plot(ribbon = list(alpha = 0)) +
  geom_line(data = estimate_relation(bear_int),
            aes(y= Predicted, x = log.move),color= "black", linewidth = 2)


# Exercise

#' If we assess OffBTL - Offspring ealy-life telomere length (at 9 day age)
#'  - as a measure of fitness, how does mother’s age - mage - affect fitness,
#'   given that dam is mother id and brood is brood id (one mother can 
#'   have many broods).


data("birdmalariaO")

head(birdmalariaO)


# explore data
head(birdmalariaO)




birdmalariaO <- birdmalariaO |> 
  mutate(broodID = as.character(brood),
         damID = as.character(dam))

ggplot(birdmalariaO,
       aes(y = OffBTL, x = mage, color = damID))+
  geom_point() +
  facet_wrap(damID ~ .)

gallinas_int <- lmer( OffBTL ~ mage + (1| brood) + (1|dam), data = birdmalariaO)

# nesting

gallinas_int <- lmer( OffBTL ~ mage + (1| damID/broodID), data = birdmalariaO)


check_model(gallinas_int)

check_predictions(gallinas_int)


check_normality(gallinas_int, effect = 'random') |> plot()

# evaluate model

summary(gallinas_int)


# look ar things in more details
# Random effect is the same like hidden variable models

tidy(gallinas_int)

tidy(gallinas_int, effect = "fixed")
confint(gallinas_int)

ranef(gallinas_int)

tidy(gallinas_int, effect = "ran_vals")

#viz RE
estimate_grouplevel(gallinas_int) |> plot()

coef(gallinas_int)

r2(gallinas_int)


# Viz from modelbased
#
estimate_relation(gallinas_int) |> plot()


ggplot(birdmalariaO,
       aes(x= mage, y =OffBTL, color = damID))+
  geom_point() +
  geom_line(data = estimate_relation(gallinas_int), aes(y = Predicted, x = mage, color = damID))

# show RE - effect of random 

estimate_relation(gallinas_int, include_random = TRUE) |> plot()


estimate_relation(gallinas_int, include_random = TRUE) |>
  plot(ribbon = list(alpha = 0)) +
  geom_line(data = estimate_relation(gallinas_int),
            aes(y= Predicted, x = mage),color= "black", linewidth = 2)


# Variable slope- intercept models


bear_slope_int <- lmer(hr ~ log.move + 
                         (log.move + 1 | BearID), bearmove)

check_predictions(bear_slope_int)

check_normality(bear_slope_int, effect = 'random') |> plot()

r2(bear_slope_int)

#viz

estimate_relation(bear_slope_int) |> plot()


estimate_relation(bear_slope_int, include_random = T) |> plot()



### Examples

birdmalariaO <- birdmalariaO |>
  mutate(brood = as.character(brood),
         dam = as.character(dam),
         mmal = as.character(mmal),
         Sex = as.character(Sex))

ggplot(birdmalariaO, aes(x = mage, y = OffBTL, color = mmal))+
  geom_point()



# Let's look at a var-slope in
# mage + (1|brood) + (1|dam) - our model before
# NOW - incorporate a mage*mmal int
# AND allow mmal to vary by brood

#OffBTL ~ mage*mmal +
  #   (mmal + 1 | brood) +
  #   (1 | dam)
  
gallinas_slope_int <- lmer(OffBTL ~ mage*mmal + 
                             (mmal + 1 | brood) + (1 | dam), birdmalariaO)

check_predictions(gallinas_slope_int)

check_normality(gallinas_slope_int, effect = 'random') |> plot()

r2(gallinas_slope_int)

#viz

estimate_relation(gallinas_slope_int) |> plot()


estimate_relation(gallinas_slope_int, include_random = T) |> plot()



# THEN try allowing mmal or mage to vary by other 
# groups - AND paste in the errors you get

gallinas_slope_int <- lmer(OffBTL ~ mage*mmal + Sex +
                             (mmal + 1 | brood) + (1 | dam), data = birdmalariaO)

check_predictions(gallinas_slope_int)

check_normality(gallinas_slope_int, effect = 'random') |> plot()

r2(gallinas_slope_int)

#viz

estimate_relation(gallinas_slope_int) |> plot()


estimate_relation(gallinas_slope_int, include_random = T) |> plot()




# to see the ci
# simulate 

