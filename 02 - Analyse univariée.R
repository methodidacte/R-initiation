######################################################################################################################
#																			                                         #
#						Partie 2: analyse statistique univari�e                         							 #
#																			                                         #
######################################################################################################################

#R�sum� statistique selon le type de variable
summary(ds_films)

#Effectifs par modalit�
table(ds_films$genre) #? acc�der � une valeur dans la table

#Pourcentages par modalit�
prop.table(table(ds_films$genre))

#Tableau crois�
table(ds_films$genre, ds_films$Recompense)

#Pourcentage par rapport au total
prop.table(table(ds_films$genre, ds_films$Recompense))
paste(round(prop.table(table(ds_films$genre, ds_films$Recompense))*100,2),"%")

#Pourcentage en ligne
prop.table(table(ds_films$genre, ds_films$Recompense), 1)

#Pourcentage en colonne
pct_col<-prop.table(table(ds_films$genre, ds_films$Recompense), 2)
print(pct_col)

#Moyenne des notes
mean(ds_films$Note)
#arrondir le r�sultat
round(mean(ds_films$Note), 2)

#Note m�diane
median(ds_films$Note)

#Quartiles
quantile(ds_films$Note)
quantile(ds_films$Note, c(0,0.2,0.4,0.6,0.8,1))

#Note moyenne par genre du film
moy_note<-aggregate(ds_films$Note, list(genre=ds_films$genre), mean)
print(moy_note)
moy_note_v2<-aggregate(Note~genre, data=ds_films, mean)
print(moy_note_v2)

#Cr�er un data.frame avec la note moyenne et la part de films r�compens�s
class(pct_col)
class(moy_note)
note_recomp<-cbind(moy_note$x, pct_col[,2])
print(note_recomp)
note_recomp_v2<-cbind(moy_note_v2$rating, pct_col[,2])
print(note_recomp_v2)

#La commande cbind g�n�re une matrice (objet de type matrix), utilisation de colnames pour renommer
class(note_recomp)
colnames(note_recomp)= c("Note_moyenne","Part_recompenses")

#Convertir la matrice en data frame
note_recomp<-as.data.frame(note_recomp)
print(note_recomp)

##Fonction �cart-type
#sd est le sample standart deviation (divis� par n-1)
sd1<-sd(ds_films$votes)
body(sd) #conna�tre la programmation de la fonction
args(sd) #liste des arguments attendus par la fonction

#Ecart-type empirique
ecart_type<-function(monvec){
	return(
		sqrt(sum((monvec - mean(monvec))^2) / (length(monvec)))
	)
}

sd2<-ecart_type(ds_films$votes)

#Comparaison des deux valeurs obtenues
c(sd1, sd2)

#Exemple avec apply sur les variables QT, avec la fonction pr�alablement cr��e
ds_films.QT<-ds_films[,c(4,5,6)]
apply(ds_films.QT, 2, ecart_type)
