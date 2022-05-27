

# Objective: calculate the Ineichen clear skies GHI

GHI_clr <- function( SolarZenithAngle, AirMass, Elevation, parameters = c( a = 5.09e-5, b = 0.868, c = 3.95e-5, d = 0.0387,
                                                                 e = 8000, f = 1250, g = 0.01, I_0 = 1353, T_L = 3 ) )
{
  h_alt = Elevation # in metres above sea level
  
  a = parameters[['a']]
  b = parameters[['b']]
  c = parameters[['c']]
  d = parameters[['d']]
  e = parameters[['e']]
  f = parameters[['f']]
  g = parameters[['g']]
  
  I_0 = parameters[['I_0']] # Wh/m^2
  T_L = parameters[['T_L']] # Linke Turbidity Index
  
  c_g1 = a*h_alt+b
  c_g2 = c*h_alt+d
    
  f_h1 = exp(-h_alt/e)
  f_h2 = exp(-h_alt/f)
  
  GHI = c_g1 * I_0 * cos( SolarZenithAngle * pi / 180 ) * exp( -c_g2 * AirMass * ( f_h1 + f_h2 * (T_L - 1 )) * exp(g * AirMass ))
  GHI[GHI<0] <- 0
  return(GHI)
}

dec <- SolarDeclination(DayAngle(seq(1:1461), 365.25))
SHA <- SolarHourAngle(t_sol(TC(L_st = 120, L_loc = 115.86, (EoT(DayAngle(seq(1:1461), 365.25)))), DaylightSavingsTime = FALSE))

SZA <- SolarZenithAngle(Latitude = -31.95, SolarDeclination = dec, SolarHourAngle = SHA)
AM <- AirMass( SolarZenithAngle( Latitude = -31.95, SolarDeclination = dec, SolarHourAngle = SHA ) )

ghi <- GHI_clr(SolarZenithAngle = SZA, AirMass = AM, Elevation = 22)
plot(head(ghi, 24), main = 'Global Horizontal Irradiance', xlab = 'hour of the day', ylab = 'Wh/m^2', type = 'l')




