######################################################
# Régression Simple : dataset mtcars             #####
######################################################

library(datasets)
?mtcars #obtenir une description du jeu de données
str(mtcars)
attach(mtcars) #detachement des variables du jeu de données mtcars
ds_cars <- data.frame(mpg, wt, hp, qsec, row.names=rownames(mtcars)) #jeu de données simplifié
detach(mtcars)
attach(ds_cars)

#Résumé statistique
summary(ds_cars) #résumé des données

#Boxplot des variables (à supprimer)
par(mfrow=c(2,2)) #découper la fenêtre graphique en 2 x 2
for (j in 1:4) {
	boxplot(ds_cars[,j], main=names(ds_cars)[j])
}

#annuler le découpage de la fenêtre graphique
par(mfrow=c(1,1))

#Matrice des nuages de points
pairs(ds_cars)

## ajouter corrélogrammes
# http://www.statmethods.net/advgraphs/correlograms.html


###############################################################
# Régression Linéaire Simple : conso en fonction du poids #####
###############################################################
#définition des variables 
Y<-mpg
X<-wt
reg<-lm(Y~X)

#resultats de la regression
summary(reg)

#résultat graphique 
plot(X, Y, xlab="poids des voiture", ylab="Consommation gallon / milles", main="Regression simple")
abline(reg, col="red")

attributes(reg)
#valeurs de la regression
print(reg$coefficients)
coefficients(reg)
#récupérer le R2

#récupérer la valeur du test de Fisher

#analyse des résidus (normalité, ...)
layout(matrix(c(1,2,3,4),2,2)) # optional 4 graphs/page 
plot(reg)

#ajouter la prévision dans le dataset
ds_cars.prev<-cbind(ds_cars, round(reg$fitted.values,1)
names(ds_cars.prev)[ncol(ds_cars.prev)] <- "mpgprev"


#########################################################
# Régression Linéaire Multiple                      #####
#########################################################
#définition des variables 
colnames(ds_cars)
reg1<-lm(mpg~cyl+disp+hp+drat+wt+qsec+vs+am+gear+carb)
reg1<-lm(mpg~., data=mtcars) #toutes les variables (attention, même les QL)

summary(reg1)
#lire F-statistic

#lire Adjusted R-squared

#On sélectionne le meilleur modèle
install.packages("MASS")
library(MASS)

#backward
reg2<-stepAIC(reg1, trace=TRUE, direction="backward")

#forward
reg3<-stepAIC(reg1, trace=TRUE, direction="forward")

#stepwise
reg4<-stepAIC(reg1, trace=TRUE, direction="both")

#resultats de la regression
summary(reg2)
summary(reg3)
summary(reg4)

##BONUS
# compare models
anova(reg2, reg3)