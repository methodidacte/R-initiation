#librairies ade4 et FactoMineR
install.packages("ade4")
library(ade4)

install.packages("FactoMineR")
library(FactoMineR)

#Données (les JO vont de la ligne 14 à 41) 
data(decathlon)
JO<-decathlon[14:41,]
attach(JO)

#Concaténer le nom et le classement
rank<-JO[11]
new.name<-paste(JO[,11], "-", rownames(JO))
rownames(JO)<-new.name

#récuperation des résultats (10 premières colonnes)
Epreuve<-JO[,1:10]

#Centrage et réduction des données (standardisation)
EpreuveCR<-scale(Epreuve, center = TRUE, scale = TRUE)

#Calcul du tableau des distances
distance<-dist(EpreuveCR, method ="euclidean", diag=FALSE, upper=FALSE)
#CAH Méthode single
EpreuveCAH<-hclust(distance, "single")
#dendrogramme
plot(EpreuveCAH, hang=-1) #paramètre hang ???

## https://rpubs.com/gaston/dendrograms

#CAH méthode WARD
EpreuveCAH<-hclust(distance,"ward.D") #la distance de Ward minimise la diminution de l'inertie inter-classe lors du regroupement de deux classes
#dendrogramme
plot(EpreuveCAH, hang=-1)

## plus simple avec la fonction agnes du package cluster ???


## identifier le nombre de groupes le plus pertinent : répérer le saut le plus marqué
# height : mesure la difficulté à réunir deux classes
plot(rev(EpreuveCAH$height), type="h") #on inverse le tri des hauteurs

#Récupération des groupes (4 classes)
EpreuveCAH.CL4<-cutree(EpreuveCAH, 4)
groupeCAH<-as.factor(EpreuveCAH.CL4)

#ACP avec affichage des groupes
EpreuveGr<-cbind.data.frame(Epreuve, groupeCAH)
res.acp<-PCA(EpreuveGr, quali.sup =11, graph=FALSE)
plot.PCA(res.acp, axes=c(1, 2), choix="ind", habillage=11)

#Autre représentation
install.packages("cluster")
library(cluster)
clusplot(distance, EpreuveCAH.CL4, diss=TRUE, shade=TRUE, color=TRUE, labels=4, main="")
abline(v=0, h=0)

#lancement des kmeans pour 4 groupes et 10 itérations
kmean<-kmeans(EpreuveCR, 4, 100000)
groupeKMEANS<-as.factor(kmean$cluster)
EpreuveKm<-cbind.data.frame(Epreuve, groupeKMEANS)

#Trie les variables de la plus à la moins caractérisante
catdes(EpreuveKm, num.var=11)
?? différences entre overall mean et mean

### BONUS ###

#Chargement de la librairie rpart spécialisée pour les arbres et par défaut dans R
install.packages("rpart")
library(rpart)

#Définition des paramètres de segmentation, Minsplit = taille minimale pour segmenter et minbucket = effectif d’admissibilité
param<-rpart.control(minsplit=2, minbucket=2)

#Lancement de l’arbre de décision
Arbre<-rpart(groupeCAH~., data=EpreuveGr, method ="class", control=param)

#Représentation graphique
plot(Arbre, branch=.2, uniform=TRUE, compress=TRUE, margin=.1)
text(Arbre, all=TRUE, use.n=TRUE, fancy=TRUE)




