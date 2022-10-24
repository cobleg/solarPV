

# Objective: import the Australian Postal Area shapefile
# Author: Grant Coble-Neal
# Reference: https://www.r-bloggers.com/2013/09/batch-downloading-zipped-shapefiles-with-r/
# Source: Australian Bureau of Statistics

URLs <- c("https://www.abs.gov.au/statistics/standards/australian-statistical-geography-standard-asgs-edition-3/jul2021-jun2026/access-and-downloads/digital-boundary-files/POA_2021_AUST_GDA2020_SHP.zip")

url_shp_to_spdf <- function(URL) {
  require(rgdal)
  wd <- getwd()
  td <- tempdir()
  setwd(td)
  temp <- tempfile(fileext = ".zip")
  download.file(URL, temp)
  unzip(temp)
  shp <- dir(tempdir(), "*.shp$")
  lyr <- sub(".shp$", "", shp)
  y <- lapply(X = lyr, FUN = function(x) readOGR(dsn=shp, layer=lyr))
  names(y) <- lyr
  unlink(dir(td))
  setwd(wd)
  return(y)
}
y <- lapply(URLs, url_shp_to_spdf)
z <- unlist(unlist(y))
# finally use it:
plot(z[[1]])
