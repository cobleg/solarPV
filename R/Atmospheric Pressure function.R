

# Objective: create a function to calculate atmospheric air pressure for a given site elevation
# Author: Grant Coble-Neal

AtmosphericPressure <- function( Elevation, Temperature, parameters = c(P_0 = 1013.25, a = 0.0065, b = 273.15, c = 5.257))
{
  # P_0: atmospheric pressure at sea-level in hectopascals (hPA); hPA is equivalent to millibars
  # Elevation: site elevation above sea level in metres
  # Temperature: ambient temperature in Celsius
  
  P_0 = parameters[['P_0']]
  a = parameters[['a']]
  b = parameters[['b']]
  c = parameters[['c']]
  
  return( P_0 * ( 1 - (a * Elevation)/(Temperature + a * Elevation + b))^c )
  # This is the hypsometric formula; If the altitude is more than 11km high above sea level, 
  # the hypsometric formula cannot be applied because the temperature lapse rate varies considerably with altitude.
  # reference: https://keisan.casio.com/exec/system/1224579725
}

AP <- AtmosphericPressure( Elevation = 22, Temperature = 15)
AP # correct answer: 1,010.61	hPa
