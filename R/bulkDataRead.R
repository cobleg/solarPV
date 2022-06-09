
# Objective: bulk import of solar irradiance data by postcode
# Author: Grant Coble-Neal
# Code source: https://community.rstudio.com/t/how-to-import-multiple-csv-files/119449/3

library(readr)

list_of_files <- list.files(path = "C:\\Users\\308265\\OneDrive - Synergy\\Solar PV\\synergy_output",
                            recursive = TRUE,
                            pattern = "\\.csv$",
                            full.names = TRUE)

df <- readr::read_csv(list_of_files, id = "file_name")

# save as an R datafile.
subdirectory <- c("data")
wd <- getwd()
filePath <- file.path(wd, subdirectory, paste0("SolarRadByPostcode.rds"))


saveRDS(df, filePath)
