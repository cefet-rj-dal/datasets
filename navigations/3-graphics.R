source("https://raw.githubusercontent.com/eogasawara/mylibrary/master/myPackage.R")
loadlibrary("ggplot2")
loadlibrary("dplyr")
loadlibrary("reshape")
loadlibrary("RColorBrewer")
source("https://raw.githubusercontent.com/eogasawara/mylibrary/master/myGraphic.R")

#configure a pasta onde estão os dados
setwd("C:/Users/eduar/OneDrive/Git/datasets/navigations")
atracacoes_mes <- readRDS("atracacoes_mes.rds")


colors <- brewer.pal(11, 'Spectral')
# setting the font size for all charts

# This function is used only to set graphics size in this notebook. Ignore it for the moment.
plot.size(10, 5)

# example1: dataset to be plotted   
example1 <- atracacoes_mes %>% select(data, `Angra dos Reis`)
head(example1)

# The function returns a preset graphic that can be enhanced. 
grf <- plot.series(example1, label_x = "data", label_y  = "atracações", colors=colors[11])
# Increasing the font size of the graphics
grf <- grf + theme(text = element_text(size=16))
grf <- grf + theme(axis.text.x = element_text(angle=90, hjust=1))
grf <- grf + scale_x_discrete(breaks = levels(example1$data)[c(T, rep(F, 5))])
# Actual plot
plot(grf)

