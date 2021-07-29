library(dplyr)
library(reshape)
setwd("C:/Users/eduar/OneDrive/Git/datasets/navigations")
atracacoes <- readRDS("atracacoes.rds")

entropy <- function(x) {
  x <- x[x > 0]
  if (length(x) <= 1)
    return(0)
  n <- sum(x)
  x <- x / n
  y <- 0
  for (i in 1:length(x)) {
    y <- y - x[i]*log(x[i],2)
    
  }
  y <- y / (-log(1/n,2))
  return(y)
}


ts_atracacoes <- atracacoes %>% filter(atr_data_atracacao >= "2010-01-01") %>%
  group_by(porto=atr_porto_atracacao, data=format(atr_data_atracacao, "%Y-%m"), atr_tipo_operacao) %>% 
  summarize(qtd = n(), 
            espera_atracacao=sum(tmp_atr_tempo_espera_atracacao), 
            espera_inicio_operacao=sum(tmp_atr_tempo_espera_inicio_operacao), 
            espera_desatracacao=sum(tmp_atr_tempo_espera_desatracacao),
            tempo_operacao=sum(tmp_atr_tempo_operacao), 
            tempo_atracado=sum(tmp_atr_tempo_atracado),
            tempo_estadia=sum(tmp_atr_tempo_estadia)
  )

ts_atracacoes <- ts_atracacoes %>%
  group_by(porto, data) %>% 
  summarize(atracacoes = sum(qtd), 
            espera_atracacao=sum(espera_atracacao), 
            espera_inicio_operacao=sum(espera_inicio_operacao), 
            espera_desatracacao=sum(espera_desatracacao),
            tempo_operacao=sum(tempo_operacao), 
            tempo_atracado=sum(tempo_atracado),
            tempo_estadia=sum(tempo_estadia),
            entropia = entropy(qtd)
  )

ts_atracacoes$porto <- as.factor(ts_atracacoes$porto)
ts_atracacoes$data <- as.factor(ts_atracacoes$data)


atracacoes_mes <- cast(ts_atracacoes %>% select(data, porto, atracacoes), data ~ porto, sum)
saveRDS(atracacoes_mes, file="atracacoes_mes.rds")

espera_atracacao_mes <- cast(ts_atracacoes %>% select(data, porto, espera_atracacao), data ~ porto, sum)
saveRDS(espera_atracacao_mes, file="espera_atracacao_mes.rds")

espera_inicio_operacao_mes <- cast(ts_atracacoes %>% select(data, porto, espera_inicio_operacao), data ~ porto, sum)
saveRDS(espera_inicio_operacao_mes, file="espera_inicio_operacao_mes.rds")

espera_desatracacao_mes <- cast(ts_atracacoes %>% select(data, porto, espera_desatracacao), data ~ porto, sum)
saveRDS(espera_desatracacao_mes, file="espera_desatracacao_mes.rds")

tempo_operacao_mes <- cast(ts_atracacoes %>% select(data, porto, tempo_operacao), data ~ porto, sum)
saveRDS(espera_desatracacao_mes, file="tempo_operacao_mes.rds")

tempo_atracado_mes <- cast(ts_atracacoes %>% select(data, porto, tempo_atracado), data ~ porto, sum)
saveRDS(tempo_atracado_mes, file="tempo_atracado_mes.rds")

tempo_estadia_mes <- cast(ts_atracacoes %>% select(data, porto, tempo_estadia), data ~ porto, sum)
saveRDS(tempo_estadia_mes, file="tempo_estadia_mes.rds")

entropia_mes <- cast(ts_atracacoes %>% select(data, porto, entropia), data ~ porto, sum)
saveRDS(entropia_mes, file="entropia_mes.rds")






