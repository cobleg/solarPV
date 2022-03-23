
myYear <- 2018

myURL <- paste0('http://www.cleanenergyregulator.gov.au/DocumentAssets/Documents/Postcode%20data%20for%20small-scale%20installations%20', myYear, '%20-%20SGU-Solar.csv')

df <- read.csv(myURL)


# delete  columns
df <- df[, -c(2:27, 52, 53)]

dates <- seq(as.Date(paste0(myYear, "/1/1")), by = "month", length = 12)

duplicate_dates <- rep(dates, 2)
dates.1 <- sort(duplicate_dates)
dates_row <- as.character(dates.1)
length(dates_row)
dates_row.2 <- rep(dates_row, 2800)
length(dates_row.2)
columnNames <- c("Postcodes",rep(c("Installations", "Capacity"), 12))
length(columnNames)
names(df) <- rbind(columnNames)
df[,13] <- as.numeric(df[,13])
df[,19] <- as.numeric(df[,19])
df[,21] <- as.numeric(df[,21])
df[,23] <- as.numeric(df[,23])
df[,25] <- as.numeric(df[,25])

df.2 <- df %>% pivot_longer(!Postcodes, names_to = "Category", values_to = "Values")

df.3 <- cbind(df.2, dates_row.2)
names(df.3) <- c("Postcodes", "Category", "Values", "Dates")

saveRDS(df.3, file = paste0("CER_", myYear, ".rds"))
