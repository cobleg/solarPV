

# Objective: create a function to calculate air mass
# Author: Grant Coble-Neal

AirMass <- function( SolarZenithAngle, parameters = c(a = 0.50572, b = 96.07995, c = -1.6364) )
{
  # The air mass coefficient defines the direct optical path length through the Earth's atmosphere
  # This is the Kasten-Young formula
  # Solar Zenith Angle is defined in degrees and must be converted to radians
  
  a = parameters[['a']]
  b = parameters[['b']]
  c = parameters[['c']]
  
  AM = (cos( SolarZenithAngle * pi / 180 ) + a * ( b - SolarZenithAngle )^c)^(-1)
  
  return( ifelse(is.nan(AM), 0, AM) )
  
  
}

dec <- SolarDeclination(DayAngle(seq(1:1461), 365.25))
SHA <- SolarHourAngle(t_sol(TC(L_st = 120, L_loc = 115.86, (EoT(DayAngle(seq(1:1461), 365.25)))), DaylightSavingsTime = FALSE))

AirMass( SolarZenithAngle( Latitude = -31.95, SolarDeclination = dec, SolarHourAngle = SHA ) )