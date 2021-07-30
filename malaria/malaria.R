if (FALSE) {
  # export 
  for (i in levels(integrated_dataset$notification.year)) {
    malaria <- integrated_dataset[integrated_dataset$notification.year==i,]
    saveRDS(malaria, file=sprintf("/home/eogasawara/malaria_%s.rds", i))
  }
}

if (FALSE) {
  #load
  malaria <- list()
  for (i in 1:11) {
    malaria[[i]] <- readRDS(sprintf("/home/eogasawara/malaria_%d.rds", i+2009-1))
  }
}

if (FALSE) {
  #merge
  data <- NULL 
  for (i in 1:length(malaria))
  {
    print(i)
    data <- rbind(data, malaria[[i]])
  }    
}
