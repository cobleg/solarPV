

# Objective: calculate the equation of time
# Author: Grant Coble-Neal

EoT <- function(DayAngle, parameters = c(a = 229.18, b = 7.5e-6, c = 1.868e-3,
                                         d = -3.2077e-2, e = -1.4615e-2,
                                         f = -4.0849e-2)){
  # day angle must be in radians
  a = parameters[['a']]
  b = parameters[['b']]
  c = parameters[['c']]
  d = parameters[['d']]
  e = parameters[['e']]
  f = parameters[['f']]
  
  return( a * (b + c * cos(DayAngle) + d * sin(DayAngle) + e * cos(2 * DayAngle)
             + f * sin(2 * DayAngle)) )
  # units of measurement: minutes

}

E_T <- EoT(DayAngle(seq(1:1461), 365.25))
plot(E_T[1:365])