

# Objective: create a function to calculate the solar hour angle
# Author: Grant Coble-Neal

SolarHourAngle <- function( LocalSolarTime )
{
  return( 360 / 24 * (LocalSolarTime - 12) )
}

SolarHourAngle(t_sol(TC(L_st = 120, L_loc = 115.86, (EoT(DayAngle(seq(1:1461), 365.25)))), DaylightSavingsTime = FALSE))