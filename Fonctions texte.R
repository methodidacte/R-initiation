############################################
# MANIPULATION DES CHAINES DE TEXTE SOUS R #
############################################

toupper(x), tolower(x) # convertir en majuscules / minuscules
substr(x,i,j) # extraction d’une sous-chaine de x à partir de la position i de longueur j. Le premier caractère est en position 1 (et non 0 comme sous d’autres langages)
match(x, vect) # x est le pattern à rechercher dans chaque élément du vecteur « vect ». Retourne le premier index de vect pour lequel l'élément est exactement identique à x.
nchar(x) # nombre de caractères de la chaine



### WEBOGRAPHIE :
## https://www.r-bloggers.com/lang/french/118
## https://www.r-bloggers.com/basic-text-string-functions-in-r/

install.packages("stringr", dependencies=TRUE)
library(stringr)

citation<-"une citation juste une citation"
class(citation) #character
verbatim<-c("mot", "ceci est un verbatim", "répétition, répétition, répétition")
class(verbatim) #vector

str_length(citation)
nchar(citation)
#appliqué sur un vector
lapply(verbatim, nchar)
#appliqué sur une la 2e dimension d'une matrice (la colonne)
dim(as.matrix(verbatim))
apply(as.matrix(verbatim), 2, nchar)

listeDesMots<-str_split(citation, " ")
class(listeDesMots) #liste de listes ?
print(listeDesMots)
nbmots.citation<-length(listeDesMots)
print(nbmots.citation)

listeDesMots<-str_split(citation, " ")[[1]]
class(listeDesMots) #character
print(listeDesMots)
nbmots.citation<-length(listeDesMots)
print(nbmots.citation)
unique(listeDesMots)

mat <- matrix(unlist(listeDesMots), ncol=1, byrow=TRUE)
df <- as.data.frame(mat)