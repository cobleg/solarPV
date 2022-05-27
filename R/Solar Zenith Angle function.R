

# Objective: create a function to calculate the solar zenith angle
# Author: Grant Coble-Neal

SolarZenithAngle <- function( Latitude, SolarDeclination, SolarHourAngle, Interval )
{
  # is the angle between the local zenith and the line joining the observer and the sun. 
  # In astronomy, the zenith is the point in the sky directly above the observer. 
  
  interval = (Interval - 60)/60
  
  return( acos( sin( Latitude * pi / 180 ) * sin( SolarDeclination * pi / 180 ) + 
            cos( Latitude * pi / 180) * cos ( SolarDeclination * pi /180) * cos( SolarHourAngle * interval * pi / 180) ) * 180 / pi )
  # units of measurement: degrees
}

dec <- SolarDeclination(DayAngle(seq(1:1461), 365.25))
SHA <- SolarHourAngle(t_sol(TC(L_st = 120, L_loc = 115.86, (EoT(DayAngle(seq(1:1461), 365.25)))), DaylightSavingsTime = FALSE))

SolarZenithAngle(Latitude = -31.95, SolarDeclination = dec, SolarHourAngle = SHA, Interval = 1)
