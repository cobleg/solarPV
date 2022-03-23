


# Objective: filter data to select WA postcodes and append to create a single WA data file

wd <- getwd()

datalist = list()

for (i in 2001:2019) 
{
  myPath <- paste0(wd, '/CER_', i, ".rds")
  df <- readRDS(myPath)
  df <- df[df$Postcodes >= 6000 & df$Postcodes < 7000, ]
  datalist[[i]] <- df # add list
}

# append files
CER_WA = do.call(rbind, datalist)

# save file
saveRDS(CER_WA, "CER_WA.rds")
