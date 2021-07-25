#setwd("C:/Users/eduar/Downloads")
years <- 2009:2017

load.airports.data <- function () {
  filename <- "airports.RData"
  if (!file.exists(filename)) {
    airports <- read_csv("airports.csv", locale = locale(), row.names=NULL)
    save(airports, file = filename)  
  }
  else {
    load(filename)
  }
  return(airports)
}

load_vra <- function(filename, ano, mes) {
  airports <- load.airports.data()
  column_names = c("airlines", "flight", "autho_code", "line_type", "origin", "destiny", "depart_expect", "depart", "arrival_expect", "arrival", "status", "observation")
  print(filename)
  data <- NULL
  if (file.exists(filename)) {
    data <- read.csv(filename, sep=";", stringsAsFactors=FALSE, row.names=NULL)
    colnames(data) <- column_names
    data$airlines <- as.factor(data$airlines)
    data$flight <- as.factor(data$flight)
    data$autho_code <- as.factor(data$autho_code)
    data$line_type <- as.factor(data$line_type)
    data$origin <- as.factor(data$origin)
    data$destiny <- as.factor(data$destiny)
    data$status <- as.factor(data$status)
    data$observation <- as.factor(data$observation)
    data$depart_expect <- strptime(data$depart_expect, "%d/%m/%Y %H:%M", tz="GMT")
    data$depart_expect_date <- format(data$depart_expect, "%Y-%m-%d")
    data$depart_expect_hour <- format(data$depart_expect, "%H:00")
    data$depart <- strptime(data$depart, "%d/%m/%Y %H:%M", tz="GMT")
    data$arrival_expect <- strptime(data$arrival_expect, "%d/%m/%Y %H:%M", tz="GMT")
    data$arrival_expect_date <- format(data$arrival_expect, "%Y-%m-%d")
    data$arrival_expect_hour <- format(data$arrival_expect, "%H:00")
    data$arrival <- strptime(data$arrival, "%d/%m/%Y %H:%M", tz="GMT")
    data$departure_delay <- as.numeric(difftime(data$depart,data$depart_expect,units = "mins"))
    data$arrival_delay <- as.numeric(difftime(data$arrival,data$arrival_expect,units = "mins"))
    data$duration_expect <- as.numeric(difftime(data$arrival_expect,data$depart_expect,units = "mins"))
    data$duration <- as.numeric(difftime(data$arrival,data$depart,units = "mins"))
    data$duration_delta <- (data$duration - data$duration_expect)
    data <- merge(x=data, y=airports, by.x="origin", by.y="airport", all.x=TRUE)
    data <- merge(x=data, y=airports, by.x="destiny", by.y="airport", all.x=TRUE)
  }
  return(data)
}

loadyears <- function(years) {
  vradata <- NULL
  for (i in years) {
    filename <- sprintf("vra/vra%d.RData", i)
    print(filename)
    if (!file.exists(filename)) {
      vra <- NULL
      for (j in 1:12) {
        vrafilename <- sprintf("vra/vra%d/vra_mes_%d_%02d.csv", i, i, j)
        data <- load_vra(vrafilename, i, j)
        if (!is.null(data)) {
          vra <- rbind(vra, data)
        }
      }
      save(vra, file = filename)
    }
    else 
      load(filename)
    vradata <- rbind(vradata, vra)
    print(c(i,unique(vra$airlines)))
  }
  filename <- "vra.RData"
  vra <- vradata
  save(vra, file = filename)
  return(vra)
}


vra <- loadyears(years)

