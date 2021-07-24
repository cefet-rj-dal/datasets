asos_geral <- read.csv("C:/Users/eduar/Downloads/asos-2010.txt", comment.char="#", na.strings="null")
library(dplyr)
library(stringr)

for (i in 2010:2014) {
  asos <- asos_geral[startsWith(asos_geral$valid, sprintf("%d",i)),]
  saveRDS(asos, file=sprintf("c:/Users/eduar/Downloads/asos-%d.rds", i))
}




#C:/Users/eduar/Downloads/vra/VRA2000.CSV