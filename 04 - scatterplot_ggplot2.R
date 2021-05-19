##http://t-redactyl.io/blog/2016/02/creating-plots-in-r-using-ggplot2-part-6-weighted-scatterplots.html

rm(list = ls())

if (is.element("datasets", installed.packages()[,1]) == FALSE) {install.packages("datasets") }
library(datasets)
if (is.element("ggplot2", installed.packages()[,1]) == FALSE) {install.packages("ggplot2") }
library(ggplot2)

#Chargement des données
data(airquality)
head(airquality)

airquality$Month <- as.factor(airquality$Month)
levels(airquality$Month)

#Ne garder que les 3 derniers mois (et toutes les colonnes) et les labelliser
aq_trim <- airquality[which ( airquality$Month=='7' |
                               airquality$Month=='8' |
                               airquality$Month=='9' ),]

aq_trim$Month<- factor(aq_trim$Month, labels=c('Juillet','Août','Septembre'))

head(aq_trim)

##Scatterplot avec la librairie ggplot
#Source : #http://sape.inf.usi.ch/quick-reference/ggplot2/shape
install.packages("ggplot2")
library(ggplot2)

p1<- ggplot(aq_trim, aes(x=Day, y=Ozone, size=Wind))+geom_point(shape=21)
p1

p2<-p1 + scale_x_continuous(breaks=seq(1,31,5)) +
  ggtitle("Quantité d'ozone par jour") +
  labs(x="Day of month", y="Ozone (ppb)")
p2

#Ajout de couleur
p1 <- ggplot(aq_trim, aes(x = Day, y = Ozone, size = Wind)) + 
  geom_point(shape = 21, colour = "#000000", fill = "#40b8d0") +
  ggtitle("Air Quality in New York by Day") + 
  labs(x = "Day of the month", y = "Ozone (ppb)") +
  scale_x_continuous(breaks = seq(1, 31, 5))
p1

#Couleur en fonction d'une variable (ici temperature)
p1 <- ggplot(aq_trim, aes(x = Day, y = Ozone, size = Wind, fill=Temp)) + 
  geom_point(shape = 21) +
  ggtitle("Air Quality in New York by Day") + 
  labs(x = "Day of the month", y = "Ozone (ppb)") +
  scale_x_continuous(breaks = seq(1, 31, 5))
p1
#Modifier les couleurs, spécifier la couleur haute et basse
p2<-p1 + scale_fill_continuous(low = "plum1", high = "purple4")
p2

#Couleur en fonction d'un facteur (mois au lieu de temp)
p1 <- ggplot(aq_trim, aes(x = Day, y = Ozone, size = Wind, fill=Month)) + 
  geom_point(shape = 21) +
  ggtitle("Air Quality in New York by Day") + 
  labs(x = "Day of the month", y = "Ozone (ppb)") +
  scale_x_continuous(breaks = seq(1, 31, 5))
p1

#Couleur en fonction de la modalité
fill = c("steelblue", "yellowgreen", "violetred1")
p1 <- p1 + scale_fill_manual(values = fill)
p1

#Ajuster taille des points
p1 <- p1 + scale_size_area(max_size = 10)
p1

p1 <- ggplot(aq_trim, aes(x = Day, y = Ozone, size = Wind, fill = Month)) + 
  geom_point(shape = 21) +
  ggtitle("Air Quality in New York by Day") + 
  labs(x = "Day of the month", y = "Ozone (ppb)") +
  scale_x_continuous(breaks = seq(1, 31, 5)) +
  scale_fill_manual(values = fill) +
  scale_size(range = c(1, 10))
p1

#Position de la légende
p1 <- p1 + theme(legend.position = "bottom", legend.direction = "horizontal")
p1

#Titre de la légende
p1 <- p1 + labs(size = "Wind Speed (mph)", fill = "Months")
p1

install.packages("grid")
library(grid) 
p1 <- p1 + theme(legend.box = "horizontal",
                 legend.key.size = unit(1, "cm"))
p1

#Fond blanc
p1 <- ggplot(aq_trim, aes(x = Day, y = Ozone, size = Wind, fill = Month)) + 
  geom_point(shape = 21) +
  theme_bw() +
  theme() +
  ggtitle("Air Quality in New York by Day") + 
  labs(x = "Day of the month", y = "Ozone (ppb)",
       size = "Wind Speed (mph)", fill = "Months") +
  scale_x_continuous(breaks = seq(1, 31, 5)) +
  scale_fill_manual(values = fill) +
  scale_size(range = c(1, 10)) +
  theme(legend.position="bottom", legend.direction="horizontal",
        legend.box = "horizontal",
        legend.key.size = unit(1, "cm"))
p1

