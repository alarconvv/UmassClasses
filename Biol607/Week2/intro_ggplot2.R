 #'----------------------
 #'
 #'
 #'Intro ggplot
 #'Biol607
 #'
 #'@date 230914
 #'
 #'
 #'---------------------
 
# load libraries
library(ggplot2)
library(palmerpenguins)
library(pacman)
library(fable)# useful when yo are not installed some previously, it will check

#intakk of lbrary, let's use pacman to load a library, and if it is not  install it
#pacman::p_load(palmerpenguis)
#pacman::p_load(inla)

#let's see wht we are working with
# tibble is a advanced dataframe
head(penguins)
#s3 is a class in tidyverse
str(penguins)

# Intro to ggplot to look at bill length mm
# we wnat to show the distribution of bill lenghts
#mapping is the aesthetic
bill_dens <- ggplot(data = penguins,mapping = aes(x = bill_length_mm) )

bill_dens
# lets make a histogram

bill_dens + geom_histogram(bins = 30)


#tryout geom_density or geom_histogram, try arguments like fill, color, alpha
# if you have a 

ggplot(data = penguins,
       mapping = aes(x = bill_length_mm, )) +
  geom_histogram(color= 'darkblue', fill= 'purple', alpha= 0.6) +
  geom_density()

ggplot(data = penguins,
       mapping = aes(x = bill_length_mm, )) +
  geom_density(color= 'darkblue', fill= 'grey80', alpha= 0.6, bw= 1)

ggplot(data = penguins,
       mapping = aes(x = bill_length_mm )) + 
  geom_histogram(aes(y = ..density..),
                 colour = 1, fill = "white") +
  geom_density(lwd = 1, colour = 4,
               fill = 4, alpha = 0.25)

# adding more aesthetics maping

ggplot(data = penguins,
       mapping = aes(x = bill_length_mm, group = species)) +
  geom_density(mapping = aes(fill= species, color = species), alpha= 0.5, bw= 1)


# sep 15


ggplot(data = penguins,
       mapping = aes(x = bill_length_mm, group = species)) +
  geom_histogram(mapping = aes(fill = species,
                             color = species),
               alpha = 0.4, position = position_dodge())

               
ggplot(data = penguins,
       mapping = aes(x = bill_length_mm, group = species)) +
  geom_histogram(mapping = aes(fill = species,
                               color = species),
                 alpha = 0.4, position = position_jitter())


ggplot(data = penguins,
       mapping = aes(x = bill_length_mm, group = species)) +
  geom_histogram(mapping = aes(fill = species,
                               color = species),
                 alpha = 0.4, position = position_stack())
#' it will change the bar position to compare among groups (species).
#' 
#' 


ggplot(data = penguins,
       mapping = aes(x = bill_length_mm, group = species)) +
  geom_histogram(mapping = aes(fill = species,
                               color = species),
                 alpha = 0.4, position = position_stack())

#########################

# Multiple dimentions ggplot

#########################

library(ggridges)


# look at relationship between  variables

# body mass v species

pen_plot_base <- ggplot( data = penguins,
                         mapping = aes(x= body_mass_g,
                                       y = species,
                                       color = species))

pen_plot_base + geom_point(alpha = 0.1,
                           size = 6)

pen_plot_base + geom_jitter(alpha = 0.7,
                            position = position_jitter(height = 0.1))



### EXERCISE
#' 1. Try out the following geoms. geom_boxplot(), geom_violin(),
#' and stat_summary(). Which do you prefer and why?
#' 
#' 
#' 
pen_plot_base <- ggplot( data = penguins,
                         mapping = aes( y = body_mass_g,
                                       x = species,
                                       color = species,
                                       fill = species))


# boxplot
pen_plot_base+ 
  geom_boxplot(alpha=0.3) 

# violin
pen_plot_base+ 
  geom_violin(alpha=0.3) 

# stat summary

pen_plot_base+ 
  stat_summary() 

#' 
#' 2. Try adding multiple geoms together with + Does order matter?
#' 

ggplot( data = penguins,
        mapping = aes( x = body_mass_g,
                       y = species,
                       fill = species))+
geom_violin(width=1.4, alpha = 0.2, color = "grey90") +
  geom_boxplot(width=0.1, color="grey", alpha=0.2) +
  geom_point(alpha = 0.3, size = 0.1, color = "black") 

#' 
#' 3. Try out geom_density_ridges() - can you add other geoms to this 
#' to make something awesome? (maybe with an offser)

ggplot(penguins, aes(x = body_mass_g, y = species, fill = species, color = species)) + 
  geom_density_ridges(quantile_lines = TRUE, alpha = 0.3)  +
  geom_point(alpha = 0.3, size = 0.1, color = "black") 
theme_light()

# give a look to theme_park

### 
# look at  relationship of
#continuous variable
##


#relationship between body mass and bill depth

pen_mass_depth <- ggplot(data = penguins,
                         mapping= aes(x = body_mass_g,
                                      y = bill_depth_mm,
                                      color = species)) 
  pen_mass_depth + geom_point()

#facetting to add another dimension of information

pen_mass_depth +
  geom_point() +
  facet_wrap(facets = vars(species, island),
             scale = "free")

pen_mass_depth +
  geom_point() +
  facet_grid(row = vars(island), cols = vars(species)) 

pen_mass_depth +
  geom_point() +
  facet_wrap( ~island + ~species) 


# both make the same  but different syntaxis

####
# What if I want to facet by a continuous variable?
#cut_*

#cut interval cuts  to make n groups with equal range
pen_mass_depth +
  geom_point() +
  facet_wrap(vars(cut_interval(flipper_length_mm, n = 10)))

#cut number make n groups with equal numbers of observation

pen_mass_depth +
  geom_point() +
  facet_wrap(vars(cut_number(flipper_length_mm, n = 10)))

# cut_width makes groups of  a given width
pen_mass_depth +
  geom_point() +
  facet_wrap(vars(cut_width(flipper_length_mm, width = 10)))


# EXERCISE
# Incorporate other faceting variables from penguins

penguins

ggplot(data = penguins,
      mapping= aes(x = body_mass_g,
                   y = flipper_length_mm,
                   ))  +
  
  geom_point(aes(color = sex,
                 shape = sex,)) +
  facet_wrap(facets = vars(species, island))


### 
# Plot  customization
## 


pen_mass_depth +
  geom_point() +
  labs(title = "Penguin Bill depth versus size",
       x = "Body Mass (g)",
       y = "Bill Depth (mm)",
       color = "Species of \n Penguin")

# play with the plot theme

pen_mass_depth +
  geom_point() +
  theme_bw()

pen_mass_depth +
  geom_point() +
  theme_classic()

pacman::p_load(ggthemes)

pen_mass_depth +
  geom_point() +
  theme_economist_white()

pen_mass_depth +
  geom_point() +
  theme_fivethirtyeight()




pen_mass_depth +
  geom_point() +
  theme_classic(base_size =  14,
                base_family = "Courier")


pen_mass_depth +
  geom_point() +
  theme_classic(base_size =  14,
                base_family = "Courier")


###
#Colors and scales
##

pen_mass_depth +
  geom_point() +
  scale_y_log10()+
  scale_color_manual(values = c("orange", 'purple','green'))

pen_mass_depth +
  geom_point() +
  scale_y_log10()+
  scale_color_brewer()


pen_mass_depth +
  geom_point() +
  scale_y_log10()+
  scale_color_viridis_d()


#continuous colors

# the bill depth v lenght relationship and color by body mass

pen_depth_length <- ggplot(data = penguins,
                           mapping = aes(x = bill_depth_mm,
                                         y = bill_length_mm , 
                                         color = body_mass_g))+
  facet_wrap(vars(species)) +
  geom_point()

                            
pen_depth_length +  scale_color_viridis_c()   

pen_depth_length +  scale_color_viridis_c(option = "A") 

pen_depth_length +  scale_color_distiller()  

pen_depth_length +  scale_color_gradient(low = 'brown',middle = "white", high ="green")



pen_plot_base +
  geom_point()


pen_plot_base +
  stat_summary()

pen_plot_base +
  geom_jitter(color = "grey", height = 0.1)+
  stat_summary(size = 1.5) +
  theme_classic()


pen_depth_length +
  geom_point()+
  stat_smooth(color = "red")

pen_depth_length +
  geom_point()+
  stat_smooth(color = "red")