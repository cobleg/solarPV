

# Objective: create a choropleth of CER PV installations by local government area (LGA)
# Author: Grant Coble-Neal
# Notes: See this web page for information about choropleths: https://r-charts.com/spatial/choropleth-map/

# load the Clean Energy Regulator data compiled by LGA
subdirectory <- c("data")
file <- c("CER_LGA_SWIS.rds")
CER_LGA_SWIS <- readRDS(file.path(getwd(), subdirectory, file))

# load the SWIS LGA map data
library(sf)
file <- c("LGA_SWIS.shp")
LGA_SWIS <- st_read(file.path(getwd(), subdirectory, file))

# subset the CER_LGA_SWIS data to select a single month
CER_LGA_SWIS_June_2010 <- CER_LGA_SWIS[CER_LGA_SWIS$Date == "2010-06-01", ]
CER_LGA_SWIS_June_2019 <- CER_LGA_SWIS[CER_LGA_SWIS$Date == "2019-06-01", ]

# Create a combined spatial dataframe

PV_LGA_June_2010 <- merge(LGA_SWIS, CER_LGA_SWIS_June_2010, by.x = "LGA_NAME21", by.y = "LGA")
PV_LGA_June_2019 <- merge(LGA_SWIS, CER_LGA_SWIS_June_2019, by.x = "LGA_NAME21", by.y = "LGA")

# drop unnecessary columns
drops <- c("FID", "LGA_CODE21", "STE_CODE21", "STE_NAME21", "AUS_CODE21", 
           "AUS_NAME21", "AREASQKM21", "LOCI_URI21", "SHAPE_Leng","SHAPE_Area")

PV_LGA_June_2010 <- PV_LGA_June_2010[, !names(PV_LGA_June_2010) %in% drops]
PV_LGA_June_2019 <- PV_LGA_June_2019[, !names(PV_LGA_June_2019) %in% drops]


plot(PV_LGA_June_2010["Capacity"],
     main = "New solar PV capacity installed in June 2010",
     breaks = "equal", nbreaks = 20,
     pal = hcl.colors(n = 20, palette = "Lisbon") )

plot(PV_LGA_June_2019["Capacity"],
     main = "New solar PV capacity installed in June 2019",
     breaks = "equal", nbreaks = 20,
     pal = hcl.colors(n = 20, palette = "Lisbon") )

# plot the SWIS region
plot(LGA_SWIS, 
     main = "SWIS region[SHAPE_AREA]",
     breaks = "equal", nbreaks = 20,
     pal = hcl.colors(n = 20, palette = "Lisbon") )


