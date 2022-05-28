

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

dec <- SolarDeclination(DayAngle(seq(1:1461), 365))
SHA <- SolarHourAngle(t_sol(TC(L_st = 120, L_loc = 115.86, (EoT(DayAngle(seq(1:1461), 365)))), DaylightSavingsTime = FALSE))

SZA1 <- SolarZenithAngle(Latitude = -31.95, SolarDeclination = dec, SolarHourAngle = SHA)

UnitInterval = '60-minute'
LST2 <- t_sol2(TC(L_st = 120, L_loc = 115.86, (EoT(DayAngle(seq(1:1461), 365)))), DaylightSavingsTime = FALSE, UnitInterval = '60-minute' )
SZA2 <- SolarZenithAngle2( Latitude = -31.95, SolarDeclination = dec, SolarAngle(LocalSolarTime = LST2, UnitInterval = UnitInterval))

AirMass( SolarZenithAngle= SZA )[1:48]
AirMass( SolarZenithAngle = SZA2 )[6:19] 

plot(AirMass( SolarZenithAngle = SZA2 )[1:365], type = 'l')
