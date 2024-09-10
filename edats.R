# Script per a la creació del CSV amb la variació d'habitants per edats al període 2000-2020

colClassesEd <- c("character", "character", "integer", "integer", "integer",
                  "integer", "integer", "integer", "integer", "integer", "integer")
edats00_DF <- read.csv("originals/HabsMunEdats_2000.csv", header=TRUE, sep=";",
                       colClasses = colClassesEd, skip=5)

edats20_DF <- read.csv("originals/HabsMunEdats_2020.csv", header=TRUE, sep=";",
                       colClasses = colClassesEd, skip=5)

# Es seleccionen les columnes d'interès de cada dataframe
cols_edats <- c("Codi","Literal","Total_0a14","Total_15a64","Total_65mes")
edats00_DF <- edats00_DF[,cols_edats]
edats20_DF <- edats20_DF[,cols_edats]

# Join dels dos dataframes per a unir-los en un de sol
edats_DF <- full_join(edats00_DF, edats20_DF, by = "Codi")
edats_DF$Literal.x[is.na(edats_DF$Literal.x)] <- edats_DF$Literal.y[is.na(edats_DF$Literal.x)]

col_elim <- c("Literal.y")
edats_DF <- edats_DF[,!names(edats_DF) %in% col_elim]

colnames(edats_DF) <- c("Codi","Municipi","R0a14_2000","R15a64_2000","R65mes_2000",
                        "R0a14_2020","R15a64_2020","R65mes_2020")

# Calcular els percentatges de majors de 65 anys a 2000 i 2020 i calcular la diferència
edats_DF$Perc65m_2000 <- round((edats_DF$R65mes_2000/(edats_DF$R0a14_2000 + edats_DF$R15a64_2000 + edats_DF$R65mes_2000))*100,2)
edats_DF$Perc65m_2020 <- round((edats_DF$R65mes_2020/(edats_DF$R0a14_2020 + edats_DF$R15a64_2020 + edats_DF$R65mes_2020))*100,2)

edats_DF$Variacio65m <- edats_DF$Perc65m_2020 - edats_DF$Perc65m_2000

# Escriure els csv amb la informació dels dos dataframes
write.csv(edats_DF,"vizdata/edats_2000_2020.csv",sep=",",dec=".",na="",row.names = FALSE)

