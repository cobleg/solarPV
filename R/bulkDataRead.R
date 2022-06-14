

# Objective: bulk import of solar irradiance data by postcode
# Author: Grant Coble-Neal
# Code source: https://community.rstudio.com/t/how-to-import-multiple-csv-files/119449/3

library(gamlss)
library(tidyverse)

tbl.1 <- list.files(path = "C:\\Users\\308265\\OneDrive - Synergy\\Solar PV\\Test",
                            recursive = TRUE,
                            pattern = "\\.csv$",
                            full.names = TRUE)  %>% 
  map_df(~read.csv(.))

tbl.2 <- tbl.1 %>% 
  mutate(Clouds =  ifelse(Clear.sky.GHI..W.m.2. - GHI..W.m.2.<0, 0.01, Clear.sky.GHI..W.m.2. - GHI..W.m.2.)) %>% 
  dplyr::select(Postcode, Clouds) %>% 
  nest(data = -c(Postcode)) %>% 
  mutate( fit = map(data, ~histDist(Clouds, family = EXP, data = .x)) )

tbl.2 %>% 
  pull(fit) %>% 
  pluck(1)
