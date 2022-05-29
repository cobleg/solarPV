

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

dayIndex = seq(1:365)
interval = '30-minute'
daysInYear = 365
dayAngle = DayAngle( timeframe = dayIndex, Interval = interval, daysInYear = daysInYear )
