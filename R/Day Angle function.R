

# Objective: create a function to calculate the day angle
# Definition: day angle is a time index expressed in radians
# Author: Grant Coble-Neal

DayAngle <-  function(timeframe = seq(from = 1, to = 365, by = 1), Interval, daysInYear = 365){
  
  # timeframe expressed as a vector of days e.g. for 1 year, timeframe = {1,2,3,...,365}
  # for 2 years, timeframe = {1,2,3,...,730}
  # daysInYear: function user decides whether the divisor is 365, 366 or 365.25
  
  # Interval: time division (td) to be used, e.g. 60-minute
  
  # create a dictionary of time intervals per day
  dictionary <- c(24, 48, 96, 228, 1440 ) # number of time intervals per day
  names(dictionary) <- c('60-minute', '30-minute', '15-minute', '5-minute', '1-minute')
  td <- unname(dictionary[Interval])
  
  N = ( timeframe - 1) %% daysInYear
  B = 2 * pi * N/daysInYear
  B_pad <- rep(B, each = td)
  return(B_pad)
}

# Interval = '60-minute'
# dictionary <- c(24, 48, 96, 228, 1440 ) # number of time intervals per day
# names(dictionary) <- c('60-minute', '30-minute', '15-minute', '5-minute', '1-minute')
# td <- unname(dictionary[Interval])
# 
# dayAngle1 <- DayAngle(timeframe = seq(1:365), Interval = '60-minute', daysInYear = 365)
# 
# dayAngle2 <- DayAngle(seq(1:1461), 365.25)
# n = ( timeframe - 1 ) %% 365
# 
# library(lubridate)
# library(dplyr)
# 
# 
# # Set Start Interval (Format = YYYY-mm-dd HH:MM:SS)
# start_interval <- ymd_hms('2010-01-01 00:00:00')
# 
# # Set End Interval (Format = YYYY-mm-dd HH:MM:SS)
# end_interval <- ymd_hms('2042-06-30 23:30:00')
# 
# # Set increment. For more increment types: https://www.rdocumentation.org/packages/base/versions/3.6.2/topics/seq.POSIXt
# increment <- '30 mins'
# 
# datetime_seq <- data.frame(
#   Interval = seq.POSIXt(start_interval, end_interval, by=increment)) %>%
#   mutate(CalYear = year(Interval),
#          Index = yday(Interval)) %>%
#   group_by(CalYear) %>%
#   mutate(DaysInYear = max(Index),
#          B = 2 * pi * (Index - 1 )/DaysInYear)
