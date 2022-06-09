

# Objective: create a function to calculate the transmittance of Rayleigh scattering
# Author: Grant Coble-Neal

T_Rayleigh <- function(AirMass, AirPressure, parameters = c(a = -0.0903, b = 1.01))
{
  # Air Mass: is the direct optical path length of light through the Earth's atmosphere.
  # Air Pressure: atmospheric pressure at a give site elevation measured in hPA/millibars 
  
  a = parameters[['a']]
  b = parameters[['b']]
  
  PCAM <- AirPressure / 1013 * AirMass # PCAM: pressure-corrected air mass
  T_R <- ifelse( AirMass > 0, exp( a * PCAM ) * ( 1 + PCAM - PCAM^b), 0 )
  T_R[T_R<0] <- 0
  return( T_R )
  # units of measurement: dimensionless
}

# source('./R/Day Angle function.R')
# source('./R/Atmospheric Pressure function.R')
# source('./R/Solar Declination.R')
# source('./R/Time Correction function.R')
# source('./R/Local Solar Time function 2.R')
# source('./R/equation of time.R')
# source('./R/Solar Hour Angle function.R')
# source('./R/Solar Zenith Angle function.R')
# source('./R/Air Mass function.R')
# 
# AP <- AtmosphericPressure( Elevation = 22, Temperature = 15)
# dec <- SolarDeclination(DayAngle(seq(1:1461), 365))
# SHA <- SolarHourAngle(t_sol2(TC(L_st = 120, L_loc = 115.86, (EoT(DayAngle(seq(1:1461), 365)))), DaylightSavingsTime = FALSE))
# SZA <- SolarZenithAngle(Latitude = -31.95, SolarDeclination = dec, SolarHourAngle = SHA)
# AM <- AirMass( SolarZenithAngle= SZA )
# 
# T_r <- T_Rayleigh(AirMass = AM, AirPressure = AP)
# plot(T_r[1:48], main = "Transmittance of Rayleigh scattering", xlab = 'Time', ylab = 'Index', type = 'l')
