

# Objective: calculate extraterrestrial radiation by day of the year
# Author: Grant Coble-Neal

I_n <- function( Interval = '60-minute')
{
  # Interval: time division to be used, e.g. 60-minute
  
  # create a dictionary of time intervals per day
  dictionary <- c(24, 48, 96, 228, 1440 ) # number of time intervals per day
  names(dictionary) <- c('60-minute', '30-minute', '15-minute', '5-minute', '1-minute')
  td <- unname(dictionary[Interval])
  n = seq(from = 1, to = 365)
  B = (n-1) * 360 / 365 # degrees per day
  I_0 = 1367 # * (60 * 24) / Interval # Wh/m^2 extraterrestrial irradiance
  I_on = I_0 * (1.000110 + 0.034221 * cos( B * pi / 180 ) + 0.001280 * sin( B * pi / 180 ) + 
                  0.000719 * cos( 2 * B * pi / 180 ) + 0.000077 * sin( 2 * B * pi / 180 ) )
  I_n <- rep(I_on, each = td)
  return(I_n)
}
timeframe <- I_n(Interval = '60-minute')

plot(I_n(Interval = '60-minute'))
