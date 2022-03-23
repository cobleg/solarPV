
# Objective: Create a data set for solar PV installations & capacity by LGA
#  To do:
#         1. Import POA to LGA correspondence table
#         2. Use correspondence table to construct stacked data frame to create stacked time series of 
#            PV installations & capacity by LGA
# Author: Grant Coble-Neal

library(dplyr)
library(lubridate)
library(tidyverse)
library(tsbox)

subdirectory <- c("data")

file <- c("POA_to_LGA_table.csv")
POA_LGA <- read.csv(file.path(getwd(), subdirectory, file))
names(POA_LGA) <- c("POA", "LGA", "Weight")

# Create date series
startDate <- c("2001-04-01")
endDate <- c("2019-12-1")
dateSeries <- seq(ymd(startDate), ymd(endDate), by ="month")

# unstack POA_LGA
POA_LGA <- POA_LGA %>% pivot_wider(names_from = LGA, values_from = Weight)
POA_LGA <- POA_LGA[order(POA_LGA$POA),] # re-order by POA

POA <- POA_LGA$POA

df <- data.frame(Date = rep(dateSeries, length(POA)) ) 
df <- data.frame(Date = df[order(df$Date), ])
df2 <- data.frame(POA = rep(POA, length(dateSeries)))
df3 <- cbind(df, df2)

POA_LGA2 <- left_join(df3, POA_LGA, by="POA")
POA_LGA3 <- POA_LGA2 %>% pivot_longer(!c("Date","POA"), names_to = "LGA", values_to = "Weight") # stack POA_LGA
POA_LGA4 <- POA_LGA3[complete.cases(POA_LGA3),]

# Join with the CER installations and capacity data
file2 <- c("CER_WA.rds")

CER_WA <- readRDS(file.path(getwd(), subdirectory, file2))
CER_WA$Dates <- as.Date(CER_WA$Dates, format = "%Y-%m-%d")
CER_LGA_SWIS <- left_join(POA_LGA4, CER_WA, by = c("POA" = "Postcodes", "Date" = "Dates"))
CER_LGA_SWIS$Values2 <- CER_LGA_SWIS$Weight * CER_LGA_SWIS$Values

CER_LGA_SWIS <- CER_LGA_SWIS[, !(names(CER_LGA_SWIS) %in% c("POA","Weight","Values"))]

CER_LGA_SWIS <- CER_LGA_SWIS %>% group_by(Date, LGA, Category) %>% summarise(Value = sum(Values2))

CER_LGA_SWIS <- CER_LGA_SWIS %>% pivot_wider(names_from = Category, values_from = Value)

CER_LGA_SWIS <- CER_LGA_SWIS[, !names(CER_LGA_SWIS) %in% c("NA")]

# Save the result

file <- c("CER_LGA_SWIS.rds")
saveRDS(CER_LGA_SWIS, file = file.path(getwd(), subdirectory, file))

# Export the result

file <- c("CER_LGA_SWIS.csv")
write.csv(CER_LGA_SWIS, file.path(getwd(), subdirectory, file), row.names = FALSE)
