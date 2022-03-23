

# Import the wide data set, add LGA names, then sum by LGA
library(tidyverse)
df <- read.csv("./data/CER_WA_wide.csv")

# drop the X column
df <- df[, c("Postcodes", "Dates", "Capacity", "Installations")]

# import SWIS LGA names
SWIS_LGAs <- read.csv("./data/SWIS_LGAs.csv")
names(SWIS_LGAs) <- c("Postcodes", "LGA")

# add SWIS LGA names to dataframe
df.1 <- merge(SWIS_LGAs, df, by.y="Postcodes")
df.1 <- df.1 %>% arrange(LGA, Postcodes, Dates)

# drop Postcodes
df.1 <- df.1[, -1]

# Aggregate (sum) by LGA
df.2 <- df.1 %>% group_by(LGA, Dates) %>% summarise(Capacity = sum(Capacity), Installations = sum(Installations))


# export result
write.csv(df.2, "./data/SWIS_DER.csv")
