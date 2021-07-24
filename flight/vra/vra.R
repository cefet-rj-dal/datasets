download <- function() {
  #install.packages("HelpersMG")
  library(HelpersMG)
  #setwd("c:/Users/eduar/Downloads")
  for (i in 2000:2020) {
    for (j in 1:12) {
      #2014-06 e 2014-07 não tiveram monitoramento
      if (!file.exists(sprintf("VRA_%d%d.csv", i, j))) {
        myurl <- sprintf("https://sas.anac.gov.br/sas/vraarquivos/%d/VRA_%d%d.csv", i, i, j)
        wget(myurl)
      }
    }
  }
}

if (FALSE)
  download()

for (i in 2000:2020) {
  vra <- NULL
  for (j in 1:12) {
    #2014-06 e 2014-07 não tiveram monitoramento
    if (file.exists(sprintf("VRA_%d%d.csv", i, j))) {
      vra <- rbind(vra, read.csv(sprintf("VRA_%d%d.csv", i, j)))
    }
  }
  saveRDS(vra, file=sprintf("VRA_%d.rds", i))
}
