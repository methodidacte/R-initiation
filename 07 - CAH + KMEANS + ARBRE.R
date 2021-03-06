#librairies ade4 et FactoMineR
install.packages("ade4")
library(ade4)

install.packages("FactoMineR")
library(FactoMineR)

#Donn�es (les JO vont de la ligne 14 � 41) 
data(decathlon)
JO<-decathlon[14:41,]
attach(JO)

#Concat�ner le nom et le classement
rank<-JO[11]
new.name<-paste(JO[,11], "-", rownames(JO))
rownames(JO)<-new.name

#r�cuperation des r�sultats (10 premi�res colonnes)
Epreuve<-JO[,1:10]

#Centrage et r�duction des donn�es (standardisation)
EpreuveCR<-scale(Epreuve, center = TRUE, scale = TRUE)

#Calcul du tableau des distances
distance<-dist(EpreuveCR, method ="euclidean", diag=FALSE, upper=FALSE)
#CAH M�thode single
EpreuveCAH<-hclust(distance, "single")
#dendrogramme
plot(EpreuveCAH, hang=-1) #param�tre hang ???

## https://rpubs.com/gaston/dendrograms

#CAH m�thode WARD
EpreuveCAH<-hclust(distance,"ward.D") #la distance de Ward minimise la diminution de l'inertie inter-classe lors du regroupement de deux classes
#dendrogramme
plot(EpreuveCAH, hang=-1)

## plus simple avec la fonction agnes du package cluster ???


## identifier le nombre de groupes le plus pertinent : r�p�rer le saut le plus marqu�
# height : mesure la difficult� � r�unir deux classes
plot(rev(EpreuveCAH$height), type="h") #on inverse le tri des hauteurs

#R�cup�ration des groupes (4 classes)
EpreuveCAH.CL4<-cutree(EpreuveCAH, 4)
groupeCAH<-as.factor(EpreuveCAH.CL4)

#ACP avec affichage des groupes
EpreuveGr<-cbind.data.frame(Epreuve, groupeCAH)
res.acp<-PCA(EpreuveGr, quali.sup =11, graph=FALSE)
plot.PCA(res.acp, axes=c(1, 2), choix="ind", habillage=11)

#Autre repr�sentation
install.packages("cluster")
library(cluster)
clusplot(distance, EpreuveCAH.CL4, diss=TRUE, shade=TRUE, color=TRUE, labels=4, main="")
abline(v=0, h=0)

#lancement des kmeans pour 4 groupes et 10 it�rations
kmean<-kmeans(EpreuveCR, 4, 100000)
groupeKMEANS<-as.factor(kmean$cluster)
EpreuveKm<-cbind.data.frame(Epreuve, groupeKMEANS)

#Trie les variables de la plus � la moins caract�risante
catdes(EpreuveKm, num.var=11)
?? diff�rences entre overall mean et mean

### BONUS ###

#Chargement de la librairie rpart sp�cialis�e pour les arbres et par d�faut dans R
install.packages("rpart")
library(rpart)

#D�finition des param�tres de segmentation, Minsplit = taille minimale pour segmenter et minbucket = effectif d�admissibilit�
param<-rpart.control(minsplit=2, minbucket=2)

#Lancement de l�arbre de d�cision
Arbre<-rpart(groupeCAH~., data=EpreuveGr, method ="class", control=param)

#Repr�sentation graphique
plot(Arbre, branch=.2, uniform=TRUE, compress=TRUE, margin=.1)
text(Arbre, all=TRUE, use.n=TRUE, fancy=TRUE)




