# Option 1: tidytuesdayR package 
## install.packages("tidytuesdayR")

tuesdata <- tidytuesdayR::tt_load('2023-09-05')
## OR
tuesdata <- tidytuesdayR::tt_load(2023, week = 36)

demographics <- tuesdata$demographics
wages <- tuesdata$wages
states <- tuesdata$states

# Option 2: Read directly from GitHub

demographics <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2023/2023-09-05/demographics.csv')
states <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2023/2023-09-05/states.csv')



#----------------------------------------------------------------------------------------
#'how have the wages chanched over the time?
#' is it realted to a demographic group and sex?
#' @author Viviana Romero Alarcon
#' 

#get dta

wages <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2023/2023-09-05/wages.csv')

head(wages)

demo_wages<- wages |>
  filter(grepl('demo', facet))

#check levels
levels(as.factor(demo_wages$facet))

# organize data frame
demo_wages <- demo_wages |> 
                mutate( Etn_grp = ifelse(facet == "demographics: black female", "Black", 
                                         ifelse(facet == "demographics: black male","Black",
                                                ifelse(facet == "demographics: hispanic female", "Latino", 
                                                       ifelse(facet == "demographics: hispanic male", "Latino",
                                                              ifelse(facet == "demographics: white female", "White",
                                                                     ifelse(facet == "demographics: white male", "White", NA)))))),
                        Sex_grp = ifelse(facet == "demographics: black female", "F", 
                                         ifelse(facet == "demographics: black male","M",
                                                ifelse(facet == "demographics: hispanic female", "F", 
                                                       ifelse(facet == "demographics: hispanic male", "M",
                                                              ifelse(facet == "demographics: white female", "F",
                                                                     ifelse(facet == "demographics: white male", "M", NA))))))) |>
  filter(!is.na(Etn_grp) | !is.na(Sex_grp) )

# Plot
ggplot(demo_wages, aes(x= year))+
  geom_line(aes(y =wage, color = Sex_grp))+
  facet_grid(Etn_grp ~ .)


#-------------------------------------------------------------------------------------



