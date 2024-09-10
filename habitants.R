# Script per a la creació del CSV amb la variació d'habitants al període 1975-2020

colClassesHab <- c("character", "character", "integer", "integer", "integer")
habs75_DF <- read.csv("originals/HabsMun_1975.csv", header=TRUE, sep=";", 
                      colClasses = colClassesHab, skip=5)

habs20_DF <- read.csv("originals/HabsMun_2020.csv", header=TRUE, sep=";", 
                      colClasses = colClassesHab, skip=5)

habs22_DF <- read.csv("originals/HabsMun_2022.csv", header=TRUE, sep=";", 
                      colClasses = colClassesHab, skip=5)

colClassesSup <- c("character", "character", "character", "integer", "numeric", "integer")
superf_DF <- read.csv("originals/MunsSuperficie.csv", header=TRUE, sep=";", 
                      dec=",", colClasses = colClassesSup, skip=6)

# Es seleccionen les columnes d'interès de cada dataframe
cols_habs <- c("Codi","Literal","Total")
habs75_DF <- habs75_DF[,cols_habs]
habs20_DF <- habs20_DF[,cols_habs]
habs22_DF <- habs22_DF[,cols_habs]

cols_sup <- c("Codi","Superficie_km2")
superf_DF <- superf_DF[,cols_sup]

# Es junten els dataframes per a obtenir-ne un de sol
habs_DF <- full_join(habs75_DF, habs20_DF, by = "Codi")
habs_DF$Literal.x[is.na(habs_DF$Literal.x)] <- habs_DF$Literal.y[is.na(habs_DF$Literal.x)]

cols_hj <- c("Codi","Literal.x","Total.x","Total.y")
habs_DF <- habs_DF[,cols_hj]
colnames(habs_DF) <- c("Codi","Municipi","Poblacio_1975","Poblacio_2020")

habssup_DF <- inner_join(habs_DF, superf_DF, by = "Codi")

# Calcular les variacions absolutes i incrementals
habssup_DF$Variacio <- habssup_DF$Poblacio_2020 - habssup_DF$Poblacio_1975
habssup_DF$Percent <- round((habssup_DF$Variacio/habssup_DF$Poblacio_1975)*100,2)


# Repetir el procés per al període 2020-2022, sense superfícies
habs2022_DF <- full_join(habs20_DF, habs22_DF, by = "Codi")
cols_hj <- c("Codi","Literal.x","Total.x","Total.y")
habs2022_DF <- habs2022_DF[,cols_hj]
colnames(habs2022_DF) <- c("Codi","Municipi","Poblacio_2020","Poblacio_2022")

habs2022_DF$Variacio <- habs2022_DF$Poblacio_2022 - habs2022_DF$Poblacio_2020
habs2022_DF$Percent <- round((habs2022_DF$Variacio/habs2022_DF$Poblacio_2020)*100,2)


# Escriure els csv amb la informació dels dos dataframes
write.csv(habssup_DF,"vizdata/variacio_1975_2020.csv",sep=",",dec=".",na="",row.names = FALSE)
write.csv(habs2022_DF,"vizdata/variacio_2020_2022.csv",sep=",",dec=".",na="",row.names = FALSE)
