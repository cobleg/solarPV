
# Objective: Create a map of the SWIS region by local government area (LGA)
# Author: Grant Coble-Neal

# Data source: https://www.abs.gov.au/statistics/standards/australian-statistical-geography-standard-asgs-edition-3/jul2021-jun2026/access-and-downloads/digital-boundary-files/LGA_2021_AUST_GDA2020_SHP.zip
# Unzip the data and place files in the subdirectory: data

# Import the shapefiles
library(sf)

# get the LGA data
subdirectory <- c("data")
file <- c("LGA_2021_AUST_GDA2020.shp")
# import polygon shapefile of Australian postal areas

LGA_data <- st_read(file.path(getwd(), subdirectory, file))

# get the SWIS region data
file <- c("SWIS_boundary2.shp")
SWIS_boundary <- st_read(file.path(getwd(), subdirectory, file))
st_crs(SWIS_boundary) # check the coordinate reference system (CRS)
SWIS_boundary <- st_transform(SWIS_boundary, "EPSG:7844") # convert CRS to ensure match

# subset the LGA boundary data to match the SWIS region
LGA_SWIS = st_intersection(SWIS_boundary, LGA_data[LGA_data$STE_NAME21 == "Western Australia", ])

# save result
file <- c("LGA_SWIS.shp")
st_write(LGA_SWIS,file.path(getwd(), subdirectory, file), append=FALSE)

# map the result
library(ggplot2)
ggplot(data = SWIS_boundary) + geom_sf(fill="NA", colour="red") + geom_sf(data = LGA_SWIS, fill="NA")
