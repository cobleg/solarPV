

# Objective: create a function to calculate clear-skies global horizontal irradiance (GHI_clear)
# Author: Grant Coble-Neal

GHI_clear <- function( SolarZenithAngle, AirMass, Elevation )
{
  # This is the Ineichen model of clear skies Global Horizontal Irradiance (GHI)
  # Elevation is defined in metres above sea level
  # Interval is defined in minutes
  c_g1 = 5.09e-5 * Elevation + 0.868
  c_g2 = 3.95e-5 * Elevation + 0.0387
  f_h1 = exp(-Elevation/8000)
  f_h2 = exp(-Elevation/1250)
  
  T_L = 3
  n = seq(from = 1, to = 365)
  B = (n-1) * 360 / 365 # degrees per day
  I_0 = 1367 # * (60 * 24) / Interval # Wh/m^2 extraterrestrial irradiance
  I_on = I_0 * (1.000110 + 0.034221 * cos( B * pi / 180 ) + 0.001280 * sin( B * pi / 180 ) + 
                  0.000719 * cos( 2 * B * pi / 180 ) + 0.000077 * sin( 2 * B * pi / 180 ) )
  
  GHI = c_g1 * I_0 * cos( SolarZenithAngle * pi / 180) * exp( -c_g2 * AirMass * (f_h1 + f_h2 * (T_L -1))) * exp(0.01 * AirMass^(1.8))
  GHI[GHI<0] <- 0
  return( GHI )
}

dec <- SolarDeclination(DayAngle(seq(1:1461), 365))
SHA <- SolarZenithAngle(Latitude = -31.95, SolarDeclination = dec, SolarHourAngle = SHA)
AM <- AirMass( SolarZenithAngle( Latitude = -31.95, SolarDeclination = dec, SolarHourAngle = SHA ) )

SolarIrradiance <- data.frame ( GHI = GHI_clear( SolarZenithAngle = SHA, AirMass = AM, Elevation = 22) )

params <- list(a = 0.50572, b = 6.07995, c = 1.6364, TL = 3) # defaults
day <- list(DayOfYear = 1, Year = 2022, Interval = 60)

GHI_cs <- clearskies::clear_sky("Ineichen", x = day, longitude = 115.86, latitude = -31.95, elevation = 22, parameters = params, tz = 8)
plot( SolarIrradiance$GHI[1:48], type = 'l', xlab = 'hour of the day', ylab = 'Wh/m^2', main = 'Global Horizontal Irradiance')
plot(GHI_cs$predicted, xlab = ' minutes of the day',ylab = 'Wh/m^2', main = 'Clear Skies Ineichen model')

day <- list(DayOfYear = 182, Year = 2022, Interval = 60)
GHI_cs182 <- clearskies::clear_sky("Ineichen", x = day, longitude = 115.86, latitude = -31.95, elevation = 22, parameters = params, tz = 8)

plot(GHI_cs$predicted, xlab = ' minutes of the day',ylab = 'Wh/m^2', main = 'Clear Skies Ineichen model')
lines(GHI_cs182$predicted)
lines(SolarIrradiance$GHI[1:23])
lines(SolarIrradiance$GHI[4380:(4380+23)])
