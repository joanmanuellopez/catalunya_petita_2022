# Script per a la creació del CSV amb la informació dels sectors econòmics

colClassesEcon <- c("character", "character", "integer", "integer",
                    "integer", "integer", "integer")

afssassal_DF <- read.csv("originals/SegSocAssals_20191231.csv", header=TRUE, sep=";",
                         colClasses = colClassesEcon, skip=7)

afssauton_DF <- read.csv("originals/SegSocAutons_20191231.csv", header=TRUE, sep=";",
                         colClasses = colClassesEcon, skip=7)


# Ajuntar els dos dataframes en un de sol per a obtenir els totals
sectors_DF <- rbind(afssassal_DF,afssauton_DF)

sectors_DF <- sectors_DF %>% group_by(Codi,Literal) %>%
  summarise(Agricultura = sum(Agricultura,na.rm = TRUE),
            Industria = sum(Industria,na.rm = TRUE),
            Construccio = sum(Construccio,na.rm = TRUE),
            Serveis = sum(Serveis,na.rm = TRUE),
            Total = sum(Total,na.rm = TRUE)) %>%
  arrange(Literal)

sectors_DF$PercAgri <- round((sectors_DF$Agricultura/(sectors_DF$Total))*100,2)

# Escriure els csv amb la informació dels dos dataframes
write.csv(sectors_DF,"vizdata/sectecon.csv",sep=",",dec=".",na="",row.names = FALSE)
