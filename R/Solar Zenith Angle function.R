

# Objective: create a function to calculate the solar zenith angle
# Author: Grant Coble-Neal

SolarZenithAngle <- function( Latitude, SolarDeclination, SolarHourAngle )
{
  # is the angle between the local zenith and the line joining the observer and the sun. 
  # In astronomy, the zenith is the point in the sky directly above the observer. 
  pi = 3.14159
  return( acos( sin( Latitude * pi / 180 ) * sin( SolarDeclination * pi / 180 ) + 
            cos( Latitude * pi / 180) * cos ( SolarDeclination * pi /180) * cos( SolarHourAngle * pi / 180) ) * 180 / pi ) # 
  # units of measurement: degrees
}

SolarZenithAngle2 <- function( Latitude, SolarDeclination, SolarAngle )
{
  # is the angle between the local zenith and the line joining the observer and the sun. 
  # In astronomy, the zenith is the point in the sky directly above the observer. 
  
  return( acos( sin( Latitude * pi / 180 ) * sin( SolarDeclination * pi / 180 ) + 
                  cos( Latitude * pi / 180) * cos ( SolarDeclination * pi /180) * cos( SolarAngle * pi / 180) ) * 180 / pi ) # 
  # units of measurement: degrees
}


dec <- SolarDeclination(DayAngle(seq(1:1461), 365))
SHA <- SolarHourAngle(t_sol(TC(L_st = 120, L_loc = 115.86, (EoT(DayAngle(seq(1:1461), 365)))), DaylightSavingsTime = FALSE))

plot(dec[1:365])

PerHour <- SolarZenithAngle(Latitude = -31.95, SolarDeclination = dec, SolarHourAngle = SHA)
PerHour[1:24]
plot(PerHour[1:60], type = 'l')
UnitInterval = '30-minute'
LST <- t_sol(TC(L_st = 120, L_loc = 115.86, (EoT(DayAngle(seq(1:1461), 365.25)))), DaylightSavingsTime = FALSE, UnitInterval = UnitInterval )
SZA <- SolarZenithAngle( Latitude = -31.95, SolarDeclination = dec, SolarAngle(LocalSolarTime = LST, UnitInterval = UnitInterval))
plot(SZA[1:48], xlab = UnitInterval, ylab = 'degrees', main = 'Solar Zenith Angle', type = 'l')

UnitInterval = '60-minute'
LST <- t_sol(TC(L_st = 120, L_loc = 115.86, (EoT(DayAngle(seq(1:1461), 365.25)))), DaylightSavingsTime = FALSE, UnitInterval = UnitInterval )
SZA <- SolarZenithAngle( Latitude = -31.95, SolarDeclination = dec, SolarAngle(LocalSolarTime = LST, UnitInterval = UnitInterval))
plot(SZA[1:24], xlab = UnitInterval, ylab = 'degrees', main = 'Solar Zenith Angle', type = 'l')

SZA1 <- SolarZenithAngle(Latitude = -31.95, SolarDeclination = dec, SolarHourAngle = SHA)
UnitInterval = '60-minute'
LST2 <- t_sol2(TC(L_st = 120, L_loc = 115.86, (EoT(DayAngle(seq(1:1461), 365.25)))), DaylightSavingsTime = FALSE, UnitInterval = '60-minute' )
SZA2 <- SolarZenithAngle2( Latitude = -31.95, SolarDeclination = dec, SolarAngle(LocalSolarTime = LST2, UnitInterval = UnitInterval))

plot(SZA2[1:48], xlab = 'hour of day', ylab = 'degrees', main = 'Local Solar Time', type = 'l')
lines(SZA1[1:48], col='blue')
