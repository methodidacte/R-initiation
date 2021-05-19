########################
# GESTION DES PACKAGES #
########################

search() # liste des packages installés
installed.packages()
library() # liste des packages chargés

#Installation d'un package
install.packages("NomDuPackage", dependencies=TRUE, repos='CheminLocal')

#obtenir la liste des fonctions
library(help=rpart)
help(package=rpart)

#Pour vérifier si un package est installé et sinon l’installer:
if (is.element("NomDuPackage", installed.packages()[,1]) == FALSE) {install.packages(‘NomDuPackage’) }

#Autres commandes
remove.packages(pkgs, lib)

update.packages(ask = FALSE, repos = 'http://cran.rstudio.org')

detach("package:agricolae", unload=TRUE)

detach_package <- function(pkg, character.only = FALSE)
{
  if(!character.only)
  {
    pkg <- deparse(substitute(pkg))
  }
  search_item <- paste("package", pkg, sep = ":")
  while(search_item %in% search())
  {
    detach(search_item, unload = TRUE, character.only = TRUE)
  }
}