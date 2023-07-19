# build a pipeline
# https://mathewanalytics.com/building-a-simple-pipeline-in-r/?utm_source=rss&utm_medium=rss&utm_campaign=building-a-simple-pipeline-in-r

library(tidyverse)
library(gtrendsR)
library(leaflet)

# date cleaning
today <- substr(as.Date(Sys.Date()), 0, 10)
range <- paste("2015-01-01", today, sep = " ")

# WAPO data
wapo.data <- read.csv("https://raw.githubusercontent.com/washingtonpost/data-police-shootings/master/v2/fatal-police-shootings-data.csv", 
                      stringsAsFactors = FALSE)

# Google Trends data
trends <- gtrends("police shooting", geo = "US", time = range)

trends.data <- data.frame(trends$interest_over_time)
trends.data$month <- substr(trends.data$date, 0, 7)
ggplot(trends.data, aes(x = month, y = hits)) + 
  geom_point() + 
  stat_smooth(method = 'lm', aes(colour = 'linear'), se = FALSE) +  
  theme_bw() + scale_colour_brewer(name = 'Trendline', palette = 'Set2')

# map
leaflet(wapo.data) %>%
  addTiles() %>%
  addMarkers(lng = ~longitude, lat = ~latitude, clusterOptions = markerClusterOptions())

###### NEW NEW NEW
### graph samples
ggplot(crime) + 
  geom_bar(aes(x = Year), stat = "count", fill = "blue")
ggplot(crime) + 
  geom_bar(aes(x = year.month), stat = "count", fill = "red")
ggplot(crime) + 
  geom_bar(aes(x = Year), stat = "count", fill = "green") + 
  facet_wrap(~ month, nrow = 4)
ggplot(crime.post) +
  geom_bar(aes(x = count, y = year.month), stat = "identity", fill = "yellow")

