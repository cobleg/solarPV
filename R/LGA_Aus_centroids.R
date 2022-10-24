
# Objective: create local government centroids across Australia.
# Author: Grant Coble-Neal

# Source: https://www.abs.gov.au/statistics/standards/australian-statistical-geography-standard-asgs-edition-3/jul2021-jun2026/access-and-downloads/digital-boundary-files

# URL: https://www.abs.gov.au/statistics/standards/australian-statistical-geography-standard-asgs-edition-3/jul2021-jun2026/access-and-downloads/digital-boundary-files/POA_2021_AUST_GDA2020_SHP.zip

library(sf)

# get the data

setwd("./data")

# import polygon shapefile of Australian postal areas

LGA_Aus_data <- st_read("LGA_2021_AUST_GDA2020.shp")
LGA_Aus_centroids <- st_centroid(LGA_Aus_data)

LGA_Aus_LAT_LONG <- as.data.frame(LGA_Aus_centroids)

# separate latitude and longitude
library(tidyverse)

LGA_Aus_CENTROIDS_SEP <- LGA_Aus_LAT_LONG %>%
  mutate(Latitude = unlist(map(LGA_Aus_LAT_LONG$geometry,2)),
         Longitude = unlist(map(LGA_Aus_LAT_LONG$geometry,1)))

Aus_LGA_coord <- LGA_Aus_CENTROIDS_SEP[, (colnames(LGA_Aus_CENTROIDS_SEP) %in% c("LGA_NAME21","Latitude", "Longitude"))]
names(Aus_LGA_coord) <- c("LGA", "Latitude", "Longitude")
# export dataframe as CSV file
write.csv(Aus_LGA_coord, "Aus_LGA_Lat_Long.csv", row.names = FALSE)
