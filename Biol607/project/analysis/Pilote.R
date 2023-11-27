library(tidyverse)
data <-read_csv('DataBase231121.csv')

problems(data)
colnames(data)


# Aves
data2 <-data |> 
  filter(Aves == "Y") |>
  filter(!is.na(FemurCirc) & !is.na(FemurLen))

View(data2)


ggplot(data2, aes(x= FemurLen, y =FemurCirc))+
  geom_point(aes(color = Clade.1, shape = as.factor(ExtinctExtant)))

lmAves <- lm(log(FemurCirc) ~ log(FemurLen) + Clade.2, data2)

summary(lmAves)


#No aves
data3 <-data |> filter(Method == 'Physical') |> filter(Aves == "N")|> 
  filter(!is.na(FemurCirc) & !is.na(FemurLen))

ggplot(data3, aes(x= FemurLen, y =FemurCirc))+
  geom_point(aes(color = Clade.1, shape = as.factor(ExtinctExtant)))

lmNoAves <- lm(FemurCirc ~ FemurLen, data3)

summary(lmNoAves)


#body Mass
colnames(data)
data4 <- data |> filter(!is.na(BM.g) & !is.na(FemurCirc)) |> filter(FemurCirc < 400)

# Conexion Aves and no aves
ggplot(data4, aes(x= log(FemurCirc), y = log(BM.g)))+
  geom_point(aes(color = as.factor(Aves))) +
  geom_smooth(aes(color = as.factor(Aves)))

#Aves
data5 <-data4 |> filter(Aves == "N")
data6 <-data4 |> filter(Aves == "Y")

# 



