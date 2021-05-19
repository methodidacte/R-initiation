users <- list(c(1,"Dunn"),c(2,"Sue"),c(3,"Chi"),c(4,"Thor"),c(5,"Clive"))
friendships <- list(c(1,2),c(1,4),c(1,5),c(1,3),c(2,3),c(3,4),c(4,5))

for (i in 1:length(friendships)) {
  
  numAmi1 <- friendships[[i]][1]
  nomAmi1 <- users[[numAmi1]][2]
  
  numAmi2 <- friendships[[i]][2]
  nomAmi2 <- users[[numAmi2]][2]
  
  print(paste(nomAmi1, "est ami.e avec", nomAmi2))
}

#créer une matrice à partir de la liste des amitiés
FriendsMatrix <- matrix(0, length(users), length(users))
for (i in 1:length(friendships)) {
  
  FriendsMatrix[friendships[[i]][[1]],friendships[[i]][[2]]]<-1
  
}

#nombre d'amitié par personne
FriendsNumber <- rowSums(FriendsMatrix)
apply(FriendsMatrix,2,sum)

#graph de relation
#https://briatte.github.io/ggnet/
install.packages("GGally")
library(GGally)
install.packages("network")
library(network)
install.packages("sna")
library(sna)
library(ggplot2)

FriendsNetwork <- network(FriendsMatrix, directed = FALSE)
FriendsGraph <- ggnet2(FriendsNetwork, size = FriendsNumber)
users <- list(c(1,"Dunn"),c(2,"Sue"),c(3,"Chi"),c(4,"Thor"),c(5,"Clive"))
friendships <- list(c(1,2),c(1,4),c(1,5),c(1,3),c(2,3),c(3,4),c(4,5))

for (i in 1:length(friendships)) {
  
  #friendsLists[[friendships[[i]][1]+1]]<-c(friendsLists[[friendships[[i]][1]+1]], friendships[[i]][1]+2)
  #inverser
  
  numAmi1 <- friendships[[i]][1]
  nomAmi1 <- users[[numAmi1]][2]
  
  numAmi2 <- friendships[[i]][2]
  nomAmi2 <- users[[numAmi2]][2]
  
  print(paste(nomAmi1, "est ami.e avec", nomAmi2))
}

#créer une matrice à partir de la liste des amitiés
FriendsMatrix <- matrix(0, length(users), length(users))
for (i in 1:length(friendships)) {
  
  FriendsMatrix[friendships[[i]][[1]],friendships[[i]][[2]]]<-1
  
}

#nombre d'amitié par personne
FriendsNumber <- rowSums(FriendsMatrix)
apply(FriendsMatrix,2,sum)

#graph de relation
#https://briatte.github.io/ggnet/
install.packages("GGally")
library(GGally)
install.packages("network")
library(network)
install.packages("sna")
library(sna)
library(ggplot2)

FriendsNetwork <- network(FriendsMatrix, directed = FALSE)
FriendsGraph <- ggnet2(FriendsNetwork, size = FriendsNumber)
