

# Objective: rehape dataframe to wide format

library(tidyverse)
wd <- getwd()
myPath <- paste0(wd, "/data/CER_WA.rds")
CER_WA <- readRDS(myPath)

# re-order columns
col_order <- c("Postcodes", "Dates", "Category", "Values")
CER_WA <- CER_WA[, col_order]

# format date column as dates
CER_WA$Dates <- as.Date(CER_WA$Dates)

# check for duplicated rows
dup_rows <- duplicated(CER_WA) | duplicated(CER_WA, fromLast = TRUE) 
CER_WA[ dup_rows,]

df <- CER_WA %>% pivot_wider(names_from = Category, values_from = Values, values_fn = {max})

# re-sort dataframe 
df <- df %>% arrange(Postcodes, Dates)

# import SWIS LGA names
SWIS_LGAs <- read.csv("./data/SWIS_LGAs.csv")
names(SWIS_LGAs) <- c("Postcodes", "LGA")

# add SWIS LGA names to dataframe
df.1 <- merge(SWIS_LGAs, df, by.y="Postcodes")
df.1 <- df.1 %>% arrange(LGA, Postcodes, Dates)

# drop Postcodes
df.1 <- df.1[, -c("Postcodes")]

# export to CSV file
write.csv(df, "CER_WA.csv")
