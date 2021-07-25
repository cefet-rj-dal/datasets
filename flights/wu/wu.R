source("https://raw.githubusercontent.com/eogasawara/mylibrary/master/myGraphics.R")
source("https://raw.githubusercontent.com/eogasawara/mylibrary/master/myPreprocessing.R")

loadlibrary("htmltab")
loadlibrary("stringr")

column_names = c(
  "datetime",
  "temperature",
  "dew_point",
  "humidity",
  "pressure",
  "visibility",
  "wind_dir",
  "wind_speed",
  "events",
  "conditions"
)
regexp <- "[[:digit:]]+\\.*[[:digit:]]*"

scrap_airport_wu <- function(airport, year, month, day) {
  url <-sprintf("https://isb.wunderground.com/history/airport/%s/%s/%s/%s/DailyHistory.html", airport, year, month, day)
  data <- htmltab(doc = url, which = "//th[text() = 'Temp.']/ancestor::table")
  data <- data[, -which(colnames(data) %in% c("Heat Index", "Gust Speed", "Precip"))]
  colnames(data) <- column_names
  for (i in 1:length(colnames(data)))
    Encoding(data[, i]) <- "UTF-8"
  
  data$airport <- airport
  data$datetime <- strptime(sprintf("%s-%s-%s %s", year, month, day, data$datetime), "%Y-%m-%d %I:%M %p", tz = "GMT")
  data$temperature <- as.numeric(str_extract(data$temperature, regexp))
  data$dew_point <- as.numeric(str_extract(data$dew_point, regexp))
  data$humidity <- as.numeric(str_extract(data$humidity, regexp))
  data$pressure <- as.numeric(str_extract(data$pressure, regexp))
  data$visibility <- as.numeric(str_extract(data$visibility, regexp))
  data$events <- as.factor(data$events)
  data$conditions <- as.factor(data$conditions)
  
  data <- data.frame(data$airport, data$datetime, data$temperature, data$dew_point, data$humidity, data$pressure, data$visibility, data$events, data$conditions)
  return(data)
}

data <- scrap_airport_wu("KMIA", 2009, 1, 1)
