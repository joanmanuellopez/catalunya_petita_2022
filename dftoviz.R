# Script per a obtenir els csv de flourish
# En aquest cas, aprofito els DF creats als altres scripts

municvar_DF <- habssup_DF[(habssup_DF$Poblacio_1975 < 3000 | habssup_DF$Poblacio_2020 < 3000),]
municvar_DF <- drop_na(municvar_DF)

write.csv(municvar_DF,"vizdata/mapa_variacio.csv",sep=",",dec=".",na="",row.names = FALSE)

municrural_DF <- habssup_DF[(habssup_DF$Poblacio_2020 < 3000),]

ed20_DF <- edats_DF[edats_DF$Codi %in% municrural_DF$Codi,]
sececon_DF <- sectors_DF[sectors_DF$Codi %in% municrural_DF$Codi,]

cols_ed <- c("Codi","Municipi","Perc65m_2020","Variacio65m")
cols_sec <- c("Codi","PercAgri")

ed20_DF <- ed20_DF[,cols_ed]
sececon_DF <- sececon_DF[,cols_sec]

edsect_DF <- left_join(ed20_DF,sececon_DF, by="Codi")
edsect_DF <- left_join(edsect_DF,habs20_DF, by="Codi")
edsect_DF <- edsect_DF[,c(1:5,7)]
colnames(edsect_DF) <- c("Codi","Municipi","Perc65m","Dif65m","PercAgr","Habitants")

edsect_DF <- edsect_DF[edsect_DF$PercAgr > 0,]
edsect_DF$RangHabs <- cut(edsect_DF$Habitants,
                          breaks = c(0, 500, 1000, 2000, 3000),
                          labels = c("0-500", "500-1000", "1000-2000", "2000-3000"))

write.csv(edsect_DF,"vizdata/scatter_ed_sect.csv",sep=",",dec=".",na="",row.names = FALSE)

top20_DF <- habs20_DF[habs20_DF$Total > 60000,]
write.csv(top20_DF,"vizdata/top20_cat.csv",sep=",",dec=".",na="",row.names = FALSE)

colsGeo <- c("character", "character", "character", "character", "character", "character", 
             "character", "character", "character", "character", "character", "numeric",
             "numeric", "numeric", "numeric", "character")

georef_df <- read.csv("originals/Caps_de_municipi_de_Catalunya_georeferenciats.csv",
                      quote = "\"", colClasses = colsGeo)

georef_df <- georef_df[,c(5,14,15)]
colnames(georef_df) <- c("Codi","Longitud","Latitud")

top20geo_DF <- left_join(top20_DF,georef_df,by="Codi")
write.csv(top20geo_DF,"vizdata/top20habs.csv",sep=",",dec=".",na="",row.names = FALSE)
