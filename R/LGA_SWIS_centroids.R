
# Objective: Create Local Government Area centroids for the SWIS region.
# Author: Grant Coble-Neal

# Source: https://www.abs.gov.au/statistics/standards/australian-statistical-geography-standard-asgs-edition-3/jul2021-jun2026/access-and-downloads/digital-boundary-files

# URL: https://www.abs.gov.au/statistics/standards/australian-statistical-geography-standard-asgs-edition-3/jul2021-jun2026/access-and-downloads/digital-boundary-files/POA_2021_AUST_GDA2020_SHP.zip

library(sf)

# get the data

setwd("./data")

# import polygon shapefile of Australian postal areas

LGA_SWIS_data <- st_read("LGA_SWIS.shp")
LGA_SWIS_centroids <- st_centroid(LGA_SWIS_data)

LGA_SWIS_LAT_LONG <- as.data.frame(LGA_SWIS_centroids)

# separate latitude and longitude
library(tidyverse)

LGA_SWIS_CENTROIDS_SEP <- LGA_SWIS_LAT_LONG %>%
  mutate(Latitude = unlist(map(LGA_SWIS_LAT_LONG$geometry,2)),
         Longitude = unlist(map(LGA_SWIS_LAT_LONG$geometry,1)))

SWIS_LGA_coord <- LGA_SWIS_CENTROIDS_SEP[, (colnames(LGA_SWIS_CENTROIDS_SEP) %in% c("LGA_NAME21","Latitude", "Longitude"))]
names(SWIS_LGA_coord) <- c("LGA", "Latitude", "Longitude")
# export dataframe as CSV file
write.csv(SWIS_LGA_coord, "SWIS_LGA_Lat_Long.csv", row.names = FALSE)
