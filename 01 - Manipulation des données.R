######################################################################################################################
#																			                                                                               #
#						Partie 1: Manipulations de table								                                                         #
#																			                                                                               #
###################################################################################################################### 
#Charger les données, voir leur type, convertir, renommer les colonnes, les facteurs, exclure les valeurs manquantes
#Créer des sous datasets, exporter en csv


#Initialisation environnement de travail
getwd()
setwd("C:\\Users\\Paul PETON\\Desktop\\R WORK\\datasets")

#Import d'un fichier txt
data_txt<-read.table("tennis.txt", header=TRUE)

#Import d'un fichier csv
ds_films <- read.csv2("ds_films.csv")

#Code généré avec RStudio
ds_films <- read_delim("C:/Users/Paul PETON/Desktop/R WORK/datasets/ds_films.csv", 
+     ";", escape_double = FALSE, trim_ws = TRUE)

#Visualiser les données
View(ds_films) #dans RStudio
head(ds_films)

#Dimensions du dataset
dim(ds_films)
nrow(ds_films) #dim(ds_films)[1]
ncol(ds_films) #dim(ds_films)[2]

#Visualiser la colonne year ou la 3e colonne
ds_films$year
ds_films[3] #é éviter
ds_films[,3]

#La 3éme ligne
ds_films[3,]

#Les 3 premiéres lignes
ds_films[1:3,]

#La 2e et la 5e colonnes
c(2,5) #collecteur
ds_films[,c(2,5)]

#Types de variables (structure du dataset)
str(ds_films)

#Obtenir le type d'un objet : class()
class(ds_films)
class(ds_films$votes)
class(ds_films$genre)

#Nombre d'éléments dans une variable
length(ds_films$genre)

#Nombre d'éléments uniques dans une variable
unique(ds_films$genre)

#Transformer une variable en factor (variable catégorielle)
ds_films$Awards<-as.factor(ds_films$Awards)

#liste des modalités
levels(ds_films$Awards)

#Renommer les modalités (http://www.cookbook-r.com/Manipulating_data/Renaming_levels_of_a_factor/)
levels(ds_films$Awards) <- c("Non","Oui")

#En cherchant par le nom et par la position
ds_films$genre<-as.factor(ds_films$genre)
levels(ds_films$genre)[levels(ds_films$genre)=="Comedy"] <- "Comédie"
levels(ds_films$genre)[2] <- "Aventure"

#Regrouper les classes d'une QL
levels(ds_films$Awards) <- c("Action","Action","Animation","Comédie")

#Repérer les valeurs manquantes et les exclure
sum(is.na(ds_films)) #nombre de valeurs manquantes
nrow(ds_films) #570
ds_films.sansNA<-na.exclude(ds_films) #exclut les lignes contenant au moins une valeur manquante
nrow(ds_films.sansNA) #569
##obtenir les numéros de ligne contenant au moins une valeur manquante
#tab<-tab[!is.na(tab$var),]

#Faire des sous datasets
films_2012<-ds_films[ds_films$year==2012,]
films_2013<-subset(ds_films, ds_films$year==2013)
bons.films<-ds_films[which(ds_films$rating>=85 | ds_films$votes>=200000),]

#Sélectionner tout sauf la colonne "index" 
ds_films2<-ds_films[,-1]  #en connaissant l'indice de la colonne
ds_films2<-ds_films[, -which(names(ds_films) == "index")] 

#Ou la supprimer directement du dataframe (NE PAS EXECUTER)
ds_films$index<-NULL

#Renommer une ou plusieurs colonnes (http://www.cookbook-r.com/Manipulating_data/Renaming_columns_in_a_data_frame/)
names(ds_films)
names(ds_films)[4] <- "Note"
names(ds_films)[names(ds_films)=="Awards"] <- "Recompense"

#Ordonner par note croissante
ds_films.ordre<-ds_films[order(ds_films$Note),]

#Ordonner par note décroissante
ds_films.ordre<-ds_films[order(ds_films$Note, descreasing = TRUE),]

#Exporter dans un fichier csv
write.csv(ds_films_ordre, file = "C:\\Users\\Paul PETON\\Desktop\\R WORK\\ds_films_ordre.csv")