

# Objective: create a function to calculate local solar time
# Author: Grant Coble-Neal

t_sol <- function( TimeCorrection, DaylightSavingsTime = FALSE ){
  
  # t_sol: local solar time as measured by a sundial
  # TimeCorrection (TC) is a series consisting of each day's time correction between
  # the longitude of a given site and the standard meridian (local time zone)
  
  hours = seq( from = 0, to = length(TimeCorrection) - 1 ) %% 24 
  
  TCbyHour <- rep(TimeCorrection, each = 24)
  
  t_solar = if(DaylightSavingsTime)
  {
    hours + (TCbyHour - 60)/60
  } else {
    hours + TCbyHour/60
  }
  
  return( t_solar )
}

t_sol(TC(L_st = 120, L_loc = 115.86, (EoT(DayAngle(seq(1:1461), 365.25)))), DaylightSavingsTime = FALSE)

TC = TC(L_st = 120, L_loc = 115.86, (EoT(DayAngle(seq(1:1461), 365.25))))

hours = seq( from = 0, to = length(TC) - 1 ) %% 24

TCbyHour <- rep(TC, each = 24)

hours + TCbyHour/60
