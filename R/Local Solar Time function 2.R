

# Objective: create a function to calculate local solar time
# Author: Grant Coble-Neal

# Modifying t_sol to allow for time intervals other than hour (e.g. minutes)

t_sol2 <- function( TimeCorrection, DaylightSavingsTime = FALSE, UnitInterval = '60-minute' ){
  
  # t_sol: local solar time as measured by a sundial
  # TimeCorrection (TC) is a series consisting of each day's time correction between
  # the longitude of a given site and the standard meridian (local time zone).
  
  # UnitInterval: 60-minute, 30-minute, 15-minute, 5-minute, 1-minute
  
  # Create a dictionary to hold the divisor of the day by unit of time (e.g. 24 hours, 1440 minutes)
  dictionary <- c(24, 48, 96, 288, 1440)
  names(dictionary) <- c('60-minute', '30-minute', '15-minute', '5-minute', '1-minute')
  
  divisor <- unname(dictionary[UnitInterval])
  
  # create a dictionary to hold the number of minutes by divisor
  dictionary2 <- c(60, 30, 15, 5, 1)
  names(dictionary2) <- c('60-minute', '30-minute', '15-minute', '5-minute', '1-minute')
  
  divisor2 <- unname(dictionary2[UnitInterval])
  
  TimeIndex = seq( from = 0, to = length(TimeCorrection) - 1 ) %% divisor 
  
  TCbyDivisor <- rep(TimeCorrection, each = divisor)
  
  t_solar = if(DaylightSavingsTime)
  {
    TimeIndex + (TCbyDivisor - 60)/divisor2
  } else {
    TimeIndex + TCbyDivisor/divisor2
  }
  
  return( t_solar )
}

t_sol2(TC(L_st = 120, L_loc = 115.86, (EoT(DayAngle(seq(1:1461), 365.25)))), DaylightSavingsTime = FALSE, UnitInterval = '60-minute' )[1]

# test: local solar time should be the same across time divisions
t_sol2(TC(L_st = 120, L_loc = 115.86, (EoT(DayAngle(seq(1:1461), 365.25)))), DaylightSavingsTime = FALSE, UnitInterval = '1-minute' )[1]/60
t_sol2(TC(L_st = 120, L_loc = 115.86, (EoT(DayAngle(seq(1:1461), 365.25)))), DaylightSavingsTime = FALSE, UnitInterval = '5-minute' )[1]/12
t_sol2(TC(L_st = 120, L_loc = 115.86, (EoT(DayAngle(seq(1:1461), 365.25)))), DaylightSavingsTime = FALSE, UnitInterval = '15-minute' )[1]/4
t_sol2(TC(L_st = 120, L_loc = 115.86, (EoT(DayAngle(seq(1:1461), 365.25)))), DaylightSavingsTime = FALSE, UnitInterval = '30-minute' )[1]/2

t_sol2(TC(L_st = 120, L_loc = 115.86, (EoT(DayAngle(seq(1:1461), 365.25)))), DaylightSavingsTime = TRUE, UnitInterval = '30-minute' )[1]/2



