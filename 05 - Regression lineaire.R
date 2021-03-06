######################################################
# R�gression Simple : dataset mtcars             #####
######################################################

library(datasets)
?mtcars #obtenir une description du jeu de donn�es
str(mtcars)
attach(mtcars) #detachement des variables du jeu de donn�es mtcars
ds_cars <- data.frame(mpg, wt, hp, qsec, row.names=rownames(mtcars)) #jeu de donn�es simplifi�
detach(mtcars)
attach(ds_cars)

#R�sum� statistique
summary(ds_cars) #r�sum� des donn�es

#Boxplot des variables (� supprimer)
par(mfrow=c(2,2)) #d�couper la fen�tre graphique en 2 x 2
for (j in 1:4) {
	boxplot(ds_cars[,j], main=names(ds_cars)[j])
}

#annuler le d�coupage de la fen�tre graphique
par(mfrow=c(1,1))

#Matrice des nuages de points
pairs(ds_cars)

## ajouter corr�logrammes
# http://www.statmethods.net/advgraphs/correlograms.html


###############################################################
# R�gression Lin�aire Simple : conso en fonction du poids #####
###############################################################
#d�finition des variables 
Y<-mpg
X<-wt
reg<-lm(Y~X)

#resultats de la regression
summary(reg)

#r�sultat graphique 
plot(X, Y, xlab="poids des voiture", ylab="Consommation gallon / milles", main="Regression simple")
abline(reg, col="red")

attributes(reg)
#valeurs de la regression
print(reg$coefficients)
coefficients(reg)
#r�cup�rer le R2

#r�cup�rer la valeur du test de Fisher

#analyse des r�sidus (normalit�, ...)
layout(matrix(c(1,2,3,4),2,2)) # optional 4 graphs/page 
plot(reg)

#ajouter la pr�vision dans le dataset
ds_cars.prev<-cbind(ds_cars, round(reg$fitted.values,1)
names(ds_cars.prev)[ncol(ds_cars.prev)] <- "mpgprev"


#########################################################
# R�gression Lin�aire Multiple                      #####
#########################################################
#d�finition des variables 
colnames(ds_cars)
reg1<-lm(mpg~cyl+disp+hp+drat+wt+qsec+vs+am+gear+carb)
reg1<-lm(mpg~., data=mtcars) #toutes les variables (attention, m�me les QL)

summary(reg1)
#lire F-statistic

#lire Adjusted R-squared

#On s�lectionne le meilleur mod�le
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