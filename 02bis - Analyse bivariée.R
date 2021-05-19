########################################################
# tests du chi2, test de moyenne, corrélation linéaire #
########################################################

#le dataset ds_films doit être chargé et attaché

##Corrélation entre notes et nombre de votes
plot(rating, votes)
cor(rating, votes) #renvoie NA à cause des valeurs manquantes
cor(rating, votes, use="complete") #complete pour ne pas tenir compte des NA
cor.test(rating, votes, use="complete") #0.5424984 

##Test du Chi2
#Table de contingence + calcul de la statistique de test

#Création des 3 classes de notes
ds_films$rating_cl<-cut(rating, breaks=c(0,7,8,10))
levels(ds_films$rating_cl)<-c("7 et moins","7,1 à 8","8,1 et plus")
head(ds_films)

tableau<-table(genre, ds_films$rating_cl) #il faudrait détacher, rattacher le dataset pour utiliser la nouvelle colonne sans le nom du dataset
tableau
chi2<-chisq.test(tableau)
print(chi2)
names(chi2)
print(chi2$p.value)

significativiteChi2<-function(mapvalue){
  if(mapvalue <0.05) return ("Test significatif, il n'y a pas indépendance")
  else return("Non significatif")
  #ifelse(mapvalue <0.05,"Test significatif, il n'y a pas indépendance","Non significatif")
}

significativiteChi2(chi2$p.value)

#Test d'égalité des moyennes des notes, films récompensés vs non récompensés
var.test(rating~Awards) #0.7221
t.test(rating~Awards, var.equal=TRUE, paired=FALSE) #0.5756

###BONUS
##Méthode en comparant deux sous-catégories
#Vecteur des notes des Awards=1
Recompenses<-Awards=="1"
Recompenses<-ds_films[Recompenses,]
rec<-as.vector(Recompenses$rating)

#Vecteur des notes des Awards=0
Non_Recompenses<-Awards=="0"
Non_Recompenses<-ds_films[Non_Recompenses,]
non_rec<-as.vector(Non_Recompenses$rating)

#Test d'égalité des variances + test de Student
var.test(rec, non_rec) #pvalue>0.05 donc on considère variances égales
t.test(rec, non_rec, var.equal=TRUE, paired=FALSE)