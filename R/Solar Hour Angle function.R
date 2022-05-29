

# Objective: create a function to calculate the solar hour angle
# Author: Grant Coble-Neal

SolarHourAngle <- function( LocalSolarTime )
{
  # LocalSolarTime: units of measurement is hour
  # Timezone: units of measurement is hour
  
  return( 360 / 24 * (LocalSolarTime - 12.5) )
  # Units of measurement: degrees
}

# SHA <- SolarHourAngle(t_sol(TC(L_st = 120, L_loc = 115.86, (EoT(DayAngle(seq(1:1461), 365)))), DaylightSavingsTime = FALSE))
# 
# SHA[1:48]
# plot(SHA[1:(24*2)])
# 
