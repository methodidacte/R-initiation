###########################################
# MANIPULATION DES DATES SOUS R           #
###########################################

### Récupération de la date du jour
aujourdhui<-Sys.Date()
print(aujourdhui)
class(aujourdhui)
format(aujourdhui, format="%d %B %Y")

# default format : yyyy-mm-dd

#Code Value
#%d	Day of the month (decimal number)
#%m	Month (decimal number)
#%b	Month (abbreviated)
#%B	Month (full name)
#%y	Year (2 digit)
#%Y	Year (4 digit)

weekdays(aujourdhui) #en français
months(aujourdhui)
quarters(aujourdhui)
#years(aujourdhui) n'existe pas
# voir package lubridate pour obtenir les valeurs numériques
library(lubridate)
year(aujourdhui)
month(aujourdhui)
day(aujourdhui)

### Récupération de l'heure actuelle
maintenant<-date()
print(maintenant)
class(maintenant)
maintenant.datetime<-as.Date(maintenant, format='%b %d %h:%m%s %Y')

### Dates sous forme de chaines de texte
strDates <- c("12/22/1988", "12/26/1990", "3/28/1979")
dates <- as.Date(strDates, "%m/%d/%Y")
class(dates)
print(dates) # default format : yyyy-mm-dd

# Plus petite et plus grande dates
min(dates)
max(dates)

# Nombre de jours entre deux dates
days <- dates[2] - dates[1]

# Conversion d'une date en nombre de jours depuis le 01/01/1070 :
dayNbr <- julian(as.Date("2005-01-01"))

## Voir le site http://www.statmethods.net/input/dates.html

help(strftime)

## Voir le site https://www.stat.berkeley.edu/~s133/dates.html

# Exemples
as.Date('1/15/2001',format='%m/%d/%Y')
[1] "2001-01-15"
as.Date('April 26, 2001',format='%B %d, %Y')
[1] "2001-04-26"
as.Date('22JUN01',format='%d%b%y')   # %y is system-specific; use with caution
[1] "2001-06-22"

###WEBOGRAPHIE :

## https://stat.ethz.ch/R-manual/R-devel/library/base/html/as.Date.html

## https://www.r-bloggers.com/date-formats-in-r/

## http://astrostatistics.psu.edu/su07/R/library/base/html/strptime.html

## http://www.duclert.org/r-vecteurs-operations/dates-et-temps-R.php

### Aller plus loin : POSIXct
dataset[,1] <- as.POSIXct(strptime(dataset[,1], format="%d/%m/%Y"))


