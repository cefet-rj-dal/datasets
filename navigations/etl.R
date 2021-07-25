library(dplyr)
library(tidyr)

tempos <- NULL
for (i in 2010:2020) {
  tempo <- read.csv(file = sprintf('/data/antaq/%d/%dTemposAtracacao.txt', i, i),
                                  sep = ';', 
                                  dec = ',',
                                  na.strings = '',
                                  fileEncoding = 'UTF-8-BOM')   
  tempos <- rbind(tempos, tempo)
}
rm(tempo)
tempos <- dplyr::rename(tempos,
                                                    'tmp_atr_id_atracacao'                    = 'IDAtracacao',
                                                    'tmp_atr_tempo_espera_atracacao'          = 'TEsperaAtracacao',
                                                    'tmp_atr_tempo_espera_inicio_operacao'    = 'TEsperaInicioOp',
                                                    'tmp_atr_tempo_operacao'                  = 'TOperacao',
                                                    'tmp_atr_tempo_espera_desatracacao'       = 'TEsperaDesatracacao',
                                                    'tmp_atr_tempo_atracado'                  = 'TAtracado',
                                                    'tmp_atr_tempo_estadia'                   = 'TEstadia'
)


atracacoes <- NULL
for (i in 2010:2020) {
  atracacao <- read.csv(file = sprintf('/data/antaq/%d/%dAtracacao.txt', i, i),
                          sep = ';', 
                          dec = ',',
                          na.strings = '',
                          fileEncoding = 'UTF-8-BOM')
  atracacoes <- rbind(atracacoes, atracacao)
}
rm(atracacao)
atracacoes <- dplyr::rename(atracacoes, 
                                       'atr_id_atracacao'                  = 'IDAtracacao',
                                       'atr_cdtup'                         = 'CDTUP',
                                       'atr_id_berco'                      = 'IDBerco',
                                       'atr_berco'                         = 'Berço',
                                       'atr_porto_atracacao'               = 'Porto.Atracação',
                                       'atr_apelido_instalacao_portuaria'  = 'Apelido.Instalação.Portuária',
                                       'atr_complexo_portuario'            = 'Complexo.Portuário',
                                       'atr_tipo_autoridade_portuaria'     = 'Tipo.da.Autoridade.Portuária',
                                       'atr_data_atracacao'                = 'Data.Atracação',
                                       'atr_data_chegada'                  = 'Data.Chegada',
                                       'atr_data_desatracacao'             = 'Data.Desatracação',
                                       'atr_data_inicio_operacao'          = 'Data.Início.Operação',
                                       'atr_data_termino_operacao'         = 'Data.Término.Operação',
                                       'atr_ano'                           = 'Ano',
                                       'atr_mes'                           = 'Mes',
                                       'atr_tipo_operacao'                 = 'Tipo.de.Operação',
                                       'atr_tipo_navegacao_atracacao'      = 'Tipo.de.Navegação.da.Atracação',
                                       'atr_nacionalidade_armador'         = 'Nacionalidade.do.Armador',
                                       'atr_flag_operacao_atracacao'       = 'FlagMCOperacaoAtracacao',
                                       'atr_terminal'                      = 'Terminal',
                                       'atr_municipio'                     = 'Município',
                                       'atr_uf'                            = 'UF',
                                       'atr_sguf'                          = 'SGUF',
                                       'atr_regiao_geografica'             = 'Região.Geográfica',
                                       'atr_nr_capitania'                  = 'Nº.da.Capitania',
                                       'atr_nr_imo'                        = 'Nº.do.IMO'
)

atracacoes <- atracacoes %>% drop_na(atr_data_atracacao)

atracacoes$atr_data_atracacao        <- as.POSIXct(atracacoes$atr_data_atracacao, format = "%d/%m/%Y %H:%M:%S")
atracacoes$atr_data_chegada          <- as.POSIXct(atracacoes$atr_data_chegada, format = "%d/%m/%Y %H:%M:%S")
atracacoes$atr_data_desatracacao     <- as.POSIXct(atracacoes$atr_data_desatracacao, format = "%d/%m/%Y %H:%M:%S")
atracacoes$atr_data_inicio_operacao  <- as.POSIXct(atracacoes$atr_data_inicio_operacao, format = "%d/%m/%Y %H:%M:%S")
atracacoes$atr_data_termino_operacao <- as.POSIXct(atracacoes$atr_data_termino_operacao, format = "%d/%m/%Y %H:%M:%S")


cargas <- NULL
for (i in 2010:2020) {
  carga <- read.csv(file = sprintf('/data/antaq/%d/%dCarga.txt', i, i),
                        sep = ';', 
                        dec = ',',
                        na.strings = '',
                        fileEncoding = 'UTF-8-BOM')
  cargas <- rbind(cargas, carga)
}
rm(carga)

cargas <- dplyr::rename(cargas, 
                                   'crg_id_carga'                              = 'IDCarga',
                                   'crg_id_atracacao'                          = 'IDAtracacao',
                                   'crg_origem'                                = 'Origem',
                                   'crg_destino'                               = 'Destino',
                                   'crg_cd_mercadoria'                         = 'CDMercadoria',
                                   'crg_tipo_operacao_carga'                   = 'Tipo.Operação.da.Carga',
                                   'crg_carga_geral_acondicionamento'          = 'Carga.Geral.Acondicionamento',
                                   'crg_conteiner_estado'                      = 'ConteinerEstado',
                                   'crg_tipo_navegacao'                        = 'Tipo.Navegação',
                                   'crg_flag_autorizacao'                      = 'FlagAutorizacao',
                                   'crg_flag_cabotagem'                        = 'FlagCabotagem',
                                   'crg_flag_cabotagem_movimentacao'           = 'FlagCabotagemMovimentacao',
                                   'crg_flag_conteiner_tamanho'                = 'FlagConteinerTamanho',
                                   'crg_flag_longo_curso'                      = 'FlagLongoCurso',
                                   'crg_flag_mc_operacao_carga'                = 'FlagMCOperacaoCarga',
                                   'crg_flag_off_shore'                        = 'FlagOffshore',
                                   'crg_flag_transporte_via_interior'          = 'FlagTransporteViaInterioir',
                                   'crg_percurso_transporte_vias_interiores'   = 'Percurso.Transporte.em.vias.Interiores',
                                   'crg_percurso_transporte_interiores'        = 'Percurso.Transporte.Interiores',
                                   'crg_st_natureza_carga'                     = 'STNaturezaCarga',
                                   'crg_stsh2'                                 = 'STSH2',
                                   'crg_stsh4'                                 = 'STSH4',
                                   'crg_natureza_carga'                        = 'Natureza.da.Carga',
                                   'crg_sentido'                               = 'Sentido',
                                   'crg_teu'                                   = 'TEU',
                                   'crg_quantidade_carga'                      = 'QTCarga',
                                   'crg_vl_peso_carga_bruta'                   = 'VLPesoCargaBruta'
)


mercadorias <- read.csv(file = '/data/antaq/mercadorias/CadastroMercadorias.txt', 
                                            sep = ';', 
                                            dec = ',',
                                            na.strings = '',
                                            fileEncoding = 'UTF-8-BOM')

mercadorias <- dplyr::rename(mercadorias,
                                                 'cad_mer_cd_mercadoria'               = 'CDMercadoria',
                                                 'cad_mer_cdncmsh2'                    = 'CDNCMSH2',
                                                 'cad_mer_tipo_conteiner'              = 'Tipo.Conteiner',
                                                 'cad_mer_grupo_mercadoria'            = 'Grupo.de.Mercadoria',
                                                 'cad_mer_mercadoria'                  = 'Mercadoria',
                                                 'cad_mer_nomenclatura_mercadoria'     = 'Nomenclatura.Simplificada.Mercadoria'
)

atracacoes <- merge(x = atracacoes, y = tempos, 
                      by.x = 'atr_id_atracacao', by.y = 'tmp_atr_id_atracacao')
save(atracacoes, file="/home/eogasawara/navigations/atracacoes.RData", compress = TRUE)

cargas <- merge(x = cargas, y = mercadorias,
                    by.x = 'crg_cd_mercadoria', by.y = 'cad_mer_cd_mercadoria')
save(cargas, file="/home/eogasawara/navigations/cargas.RData", compress = TRUE)

anoatracacao <- atracacoes %>% select(atr_id_atracacao, atr_ano)

cargas_ano <- merge(cargas, anoatracacao, by.x="crg_id_atracacao", by.y="atr_id_atracacao")
cargas_ano$atr_id_atracacao <- NULL
cargas_ano$crg_cd_mercadoria <- as.factor(cargas_ano$crg_cd_mercadoria)
cargas_ano$crg_origem <- as.factor(cargas_ano$crg_origem)
cargas_ano$crg_destino <- as.factor(cargas_ano$crg_destino)
cargas_ano$crg_tipo_operacao_carga <- as.factor(cargas_ano$crg_tipo_operacao_carga)
cargas_ano$crg_carga_geral_acondicionamento <- as.factor(cargas_ano$crg_carga_geral_acondicionamento)
cargas_ano$crg_conteiner_estado <- as.factor(cargas_ano$crg_conteiner_estado)
cargas_ano$crg_tipo_navegacao <- as.factor(cargas_ano$crg_tipo_navegacao)
cargas_ano$crg_flag_autorizacao <- as.factor(cargas_ano$crg_flag_autorizacao)
cargas_ano$crg_flag_conteiner_tamanho <- as.factor(cargas_ano$crg_flag_conteiner_tamanho)
cargas_ano$crg_percurso_transporte_vias_interiores <- as.factor(cargas_ano$crg_percurso_transporte_vias_interiores)
cargas_ano$crg_percurso_transporte_interiores <- as.factor(cargas_ano$crg_percurso_transporte_interiores)
cargas_ano$crg_st_natureza_carga <- as.factor(cargas_ano$crg_st_natureza_carga)
cargas_ano$crg_sentido <- as.factor(cargas_ano$crg_sentido)
cargas_ano$cad_mer_cdncmsh2 <- as.factor(cargas_ano$cad_mer_cdncmsh2)
cargas_ano$cad_mer_tipo_conteiner <- as.factor(cargas_ano$cad_mer_tipo_conteiner)
cargas_ano$cad_mer_grupo_mercadoria <- as.factor(cargas_ano$cad_mer_grupo_mercadoria)
cargas_ano$cad_mer_mercadoria <- as.factor(cargas_ano$cad_mer_mercadoria)
cargas_ano$cad_mer_nomenclatura_mercadoria <- as.factor(cargas_ano$cad_mer_nomenclatura_mercadoria)
saveRDS(cargas_ano, file="/data/antaq/cargas.rds")

unique(cargas_ano$atr_ano)

for (i in 2010:2020) {
  cargas <- cargas_ano[cargas_ano$atr_ano == i,]
  saveRDS(cargas,file=sprintf("/data/antaq/cargas-%d.rds", i))
}


