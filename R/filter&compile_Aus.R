

# Objective: Create a single Australian data file
# Author: Grant Coble-Neal
# Dependency: BatchCompile.R

library(here)

datalist = list()

for (i in 2001:2020) 
{
  myPath <- paste0(here("data"), '/CER_', i, ".rds")
  df <- readRDS(myPath)
  
  datalist[[i]] <- df # add list
}

# append files
CER_Aus = do.call(rbind, datalist)

# save file
saveRDS(CER_Aus, here("data" , "CER_Aus.rds"))
