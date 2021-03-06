###########################################
# ACP decathlon                           #
###########################################

#librairie
install.packages("FactoMineR")
library(FactoMineR)

#Donn�es 
data(decathlon)
?decathlon
head(decathlon)
str(decathlon)

#Donn�es des JO
JO<-decathlon[17:41,]
attach(JO)

#nom + classement dans les noms de ligne
rank<-JO[11]
new.name<-paste(JO[,11], "-", rownames(JO))
rownames(JO)<-new.name

#R�cup�ration des �preuves
Epreuve<-JO[1:10]

#Statistique descriptives 
summary(Epreuve)

# Matrice des nuages de points
pairs(Epreuve)

#ACP
res.acp<-PCA(Epreuve, scale.unit=TRUE, ncp=10, graph=FALSE)
#Epreuve: le data frame utilis�
#scale.unit: pour choisir de centrer-r�duire ou non les variables 
#ncp: le nombre de dimensions � garder dans les r�sultats (commencer par le nombre de variables)
#graph: pour choisir de faire appara�tre les graphiques ou non

#r�sum� de l�acp
summary(res.acp)
attributes(res.acp)

#graphique des valeurs propres
graph.vp<-barplot(res.acp$eig[,2], col=rainbow(12),type="b", ylab="Valeurs propres", xlab="Composantes", main="Contribution par composante")
text(graph.vp, res.acp$eig[,2], labels=paste(round(res.acp$eig[,2],2),"%"), pos=3, xpd=TRUE)

#graphique des variables
plot.PCA(res.acp, axes=c(1,2), choix="var")

#Contribution des variables pour les deux premi�res dimensions : 
dimdesc(res.acp, axes=c(1,2))

#graphique des individus
plot.PCA(res.acp, axes=c(1,2), choix="ind")

#Superposition variables et individus
plot.PCA(res.acp, axes=c(1,2), choix="ind")
p<-ncol(Epreuve)	
for(i in 1:p){
	arrows(0, 0, res.acp$var$coord[i,1]*3, res.acp$var$coord[i,2]*3, col="red", length=0.1)
}
text(res.acp$var$coord[,1]*3, res.acp$var$coord[,2]*3, labels=colnames(Epreuve), col="red", cex=0.8) 

#Rajout d'une variable illustrative
Epreuve<-JO[1:11]
res.acp<-PCA(Epreuve, scale.unit=TRUE, ncp=5, graph=TRUE, quanti.sup=11)
res.acp$var$coord[,1]
