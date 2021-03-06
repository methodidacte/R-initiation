####################################
# PLOTS simples                    #
####################################

#supprimer toutes les variables dans l'environnement
rm(list=ls())

#setwd("C:/Users/Admin2/Desktop/R_Laura")
setwd("C:\\Users\\Paul PETON\\Desktop\\R WORK")

#Import d'un fichier csv
ds_films <- read.csv2("ds_films.csv")
#Retour � ds_films, fichier de base, sans les transfo 
ds_films <- read.csv2("ds_films.csv")

#Retirer les valeurs manquantes
ds_films<-na.exclude(ds_films)

#On attache le dataset, il ne sera plus n�cessaire de le pr�ciser
attach(ds_films)

#Quali
plot(genre)
pie(table(Awards))

#Quanti
plot(votes)
hist(votes)
hist(votes, breaks=10)
hist(votes, breaks=c(0, 250000, 500000, 750000, max(votes, na.rm = T)))

plot(votes, runtime)
plot(votes ~ runtime)

plot(log(votes),log(runtime), main="Lien entre le nombre de vote et la dur�e",
     xlab="Votes",
     ylab="Dur�e",
     col="blue"
     )
# Lien vers toutes les options de plot :
# http://www.statmethods.net/advgraphs/parameters.html

plot(genre, Awards)  #R�sultats bizarres car Awards pas en factor
Awards<-as.factor(Awards)
plot(genre, Awards)
plot(genre ~ Awards)

#Nombre de votes pour les films d'aventure
Adventure<-genre=="Adventure"
Aventure<-ds_films[Adventure,]

hist(Aventure$rating)
hist(Aventure$rating, breaks=3, main="R�partition des notes des films d'aventure")

#Bo�tes � moustaches (boxplot)
boxplot(rating)
boxplot(rating ~ genre)
## obtenir les valeurs des individus aberrants
boxplot(rating[genre=="Adventure"])$out

#Corr�lations de toutes les variables quantitatives
pairs(ds_films)
#refaire un dataset limit� aux variables QT

##Ajouter barplot ou mosaicplot sur deux variables QL ?
?barplot
#barplot(table(df$vcat1))
?mosaicplot
#mosaicplot(table(df$vcat1, df$vcat2))
