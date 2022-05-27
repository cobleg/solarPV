

# Objective: create a function to calculate the declination of the Sun
# Author: Grant Coble-Neal

SolarDeclination <- function( DayAngle, parameters = c(a = 0.006918, b = -0.399912, c = 0.070257,
                                                       d = -0.006758, e =  0.000907, f = -0.002697,
                                                       g = 0.00148) )
{
  #  the declination of the Sun ($\delta$) is the angle between the rays of the Sun and the plane of the Earth's equator
  a = parameters[['a']]
  b = parameters[['b']]
  c = parameters[['c']]
  d = parameters[['d']]
  e = parameters[['e']]
  f = parameters[['f']]
  g = parameters[['g']]
  
  return( ( a + b * cos( DayAngle ) + c * sin( DayAngle ) + d * cos( 2 * DayAngle ) + e * sin( 2 * DayAngle ) + 
            f * cos( 3 * DayAngle ) + g * sin( 3 * DayAngle ) )* 180 / pi )
  # units of measurement: degrees
}

SolarDeclination(DayAngle(seq(1:1461), 365.25))

plot(SolarDeclination(DayAngle(seq(1:365), 365.25)), xlab = " Day of the year",ylab = "Degrees", main = "Solar declination angle")
