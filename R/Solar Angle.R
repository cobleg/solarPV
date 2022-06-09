

# Objective: calculate solar angle by day time division; e.g. 24 hours in a day, 1,440 minutes in a day

# Author: Grant Coble-Neal

# Time is represented by an angle.
# References to noon, the Sun at its highest point in the sky each day.
# So noon is 0 degrees, time before noon (e.g. 11 AM) is represented by a negative angle.
# Time after noon is represented by a positive angle.
# Midnight is 12 hours, 48 half-hours,..., 720 minutes before noon.


SolarAngle <- function( LocalSolarTime, UnitInterval = '60-minute' )
{
  # Create a dictionary to hold the divisor of the day by unit of time (e.g. 24 hours, 1440 minutes)
  dictionary <- c(24, 48, 96, 288, 1440)
  names(dictionary) <- c('60-minute', '30-minute', '15-minute', '5-minute', '1-minute')
  
  divisor <- unname(dictionary[UnitInterval])
  
  return( 360 / divisor * (LocalSolarTime - divisor / 2) ) # Units of measurement: degrees
}

# LST <- t_sol2(TC(L_st = 120, L_loc = 115.86, (EoT(DayAngle(seq(1:1461), 365.25)))), DaylightSavingsTime = FALSE, UnitInterval = '60-minute' )
# 
# plot(SolarAngle(LocalSolarTime = LST, UnitInterval = '60-minute')[1:48], xlab = 'hour of day', ylab = 'degrees', main = 'Local Solar Time', type = 'l')
# lines(SolarHourAngle(t_sol(TC(L_st = 120, L_loc = 115.86, (EoT(DayAngle(seq(1:1461), 365.25)))), DaylightSavingsTime = FALSE))[1:48], col='blue')
# 
# LST_30 <- t_sol2(TC(L_st = 120, L_loc = 115.86, (EoT(DayAngle(seq(1:1461), 365.25)))), DaylightSavingsTime = FALSE, UnitInterval = '30-minute' )
# 
# plot(SolarAngle(LocalSolarTime = LST_30, UnitInterval = '30-minute')[1:96], xlab = 'half-hour of day', ylab = 'degrees', main = 'Local Solar Time', type = 'l')
# 
     