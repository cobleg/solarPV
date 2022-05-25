

# Objective: create a function to calculate clear-skies global horizontal irradiance (GHI_clear)
# Author: Grant Coble-Neal

GHI_clear <- function( SolarZenithAngle, AirMass, Elevation, Interval )
{
  # This is the Ineichen model of clear skies Global Horizontal Irradiance (GHI)
  # Elevation is defined in metres above sea level
  # Interval is defined in minutes
  c_g1 = 5.09e-5 * Elevation + 0.868
  c_g2 = 3.95e-5 * Elevation + 0.0387
  f_h1 = exp(-Elevation/8000)
  f_h2 = exp(-Elevation/1250)
  
  T_L = 3
  I_0 = 1364 # * (60 * 24) / Interval # Wh/m^2 extraterrestrial irradiance
  
  ghi_1 = (exp(-c_g2*AirMass*(f_h1 + f_h2*(T_L - 1))) *
           exp(0.01*AirMass**1.8))
  
  ghi = c_g1 * I_0 * cos( SolarZenithAngle * pi / 180) * T_L / T_L * ghi_1
  
  GHI = c_g1 * I_0 * cos( SolarZenithAngle * pi / 180) * exp( -c_g2 * AirMass * (f_h1 + f_h2 * (T_L -1))) * exp(0.01 * AirMass^(1.8))
  
  return( ghi )
}

dec <- SolarDeclination(DayAngle(seq(1:1461), 365.25))
SHA <- SolarZenithAngle(Latitude = -31.95, SolarDeclination = dec, SolarHourAngle = SHA)
AM <- AirMass( SolarZenithAngle( Latitude = -31.95, SolarDeclination = dec, SolarHourAngle = SHA ) )

SolarIrradiance <- GHI_clear( SolarZenithAngle = SHA, AirMass = AM, Elevation = 22, Interval = 60) 

plot( SolarIrradiance[1:48] )
