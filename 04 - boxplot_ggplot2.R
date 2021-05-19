#http://t-redactyl.io/blog/2016/04/creating-plots-in-r-using-ggplot2-part-10-boxplots.html

rm(list = ls())

if (is.element("datasets", installed.packages()[,1]) == FALSE) {install.packages("datasets") }
library(datasets)
if (is.element("ggplot2", installed.packages()[,1]) == FALSE) {install.packages("ggplot2") }
library(ggplot2)

data(airquality)
head(airquality)

#Mettre le mois en facteur
airquality$Month<-as.factor(airquality$Month) #Transformer en facteur
levels(airquality$Month) #Afficher les modalités et surtout leur ordre car elles doivent être mis dans l'ordre dans le labels
airquality$Month<-factor(airquality$Month, labels=c("Mai","Juin","Juillet","Aout","Septembre"))

#Première représentation
p0<-ggplot(airquality, aes(x=Month, y=Ozone))
p0 #il ne se passe rien, il manque une option de représentation

p10<-ggplot(airquality, aes(x=Month, y=Ozone)) + geom_boxplot()
p10

#On rajoute des options pour nommer les axes
p11<-p10+scale_x_discrete(name="Month") +scale_y_continuous(name="Quantité d'ozone moyenne")
p11

#Possibilité de passer à la ligne avec \n dans le nom de l'axe
p11<-p10+scale_x_discrete(name="Month") +scale_y_continuous(name="Quantité d'ozone \nmoyenne")
p11

#Changer les échelles sur l'axe des ordonnées : option breaks=seq(début,fin, pas)
p11<-p10+scale_x_discrete(name="Month") +scale_y_continuous(name="Quantité d'ozone \nmoyenne",
                                                            breaks=seq(0,175,25)
                                                            )
p11

#Rajouter un titre : option ggtitle
p12<-p11+ggtitle("Boxplot sur la quantité d'Ozone moyenne \n par mois")
p12

#Ajouter des couleurs de remplissage et contours aux boxplot dans le param geom_boxplot 
#Soit mettre des couleurs en lettre ou le code HEX
#Utiliser l'option alpha pour rendre les boxplot légeremment transparent (alpha entre 0 et 1)

## Attention, ne pas commencer une ligne par "+", R ne l'interprèterait pas correctement

ColorFill="gold1"  #"#4271AE"
ColorLine="goldenrod2"

p12<-ggplot(airquality, aes(x=Month, y=Ozone)) +
  geom_boxplot(fill=ColorFill, color=ColorLine, alpha=0.7) +
  scale_x_discrete(name="Month") +
  scale_y_continuous(name="Quantité d'ozone \nmoyenne",
                     breaks=seq(0,175,25)
  ) + 
  ggtitle("Boxplot sur la quantité d'Ozone moyenne \n par mois")
p12






