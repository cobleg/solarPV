

# get the 2002 CER data set

library(tidyverse)

# get the data
df <- read.csv('http://www.cleanenergyregulator.gov.au/DocumentAssets/Documents/Postcode%20data%20for%20small-scale%20installations%202002%20-%20SGU-Solar.csv')

# delete  columns
df <- df[, -c(2:19, 44, 45)]

dates <- seq(as.Date("2002/1/1"), by = "month", length = 12)
duplicate_dates <- rep(dates, 2)
dates.1 <- sort(duplicate_dates)
dates_row <- as.character(dates.1)
length(dates_row)

dates_row.2 <- rep(dates_row, 2795)

columnNames <- c("Postcodes",rep(c("Installations", "Capacity"), 12))
# length(category)
names(df) <- rbind(columnNames)

df.2 <- df %>% pivot_longer(!Postcodes, names_to = "Category", values_to = "Values")
nrow(df.2)

df.3 <- cbind(df.2, dates_row.2)
names(df.3) <- c("Postcodes", "Category", "Values", "Dates")

saveRDS(df.3, file = "CER_2002.rds")
