

# Objective: construct the GHI time series with half-hourly intervals
# Author: Grant Coble-Neal

source('./R/Day Angle function.R')
source('./R/Solar Declination.R')
source('./R/equation of time.R')
source('./R/Time Correction function.R')
source('./R/Local Solar Time function 2.R')
source('./R/Solar Angle.R')
source('./R/Solar Zenith Angle function.R')
source('./R/Extraterrestrial radiation.R')
source('./R/Air Mass function.R')
source('./R/Ineichen GHI clear.R')

interval = '30-minute'
latitude = -31.95
longitude.local = 115.86
longitude.localTimeZone = 120
dayIndex = seq(1:365)
daysInYear = 365

dayAngle = DayAngle( timeframe = dayIndex, Interval = interval, daysInYear = daysInYear )
dec <- SolarDeclination(dayAngle)
E_T <- EoT(dayAngle)
TimeCorr <- TC(L_st = longitude.localTimeZone, L_loc = longitude.local, EquationOfTime = E_T)
LST <- t_sol2(TimeCorrection = TimeCorr, DaylightSavingsTime = FALSE)
SA <- SolarAngle( LocalSolarTime = LST )
SZA <- SolarZenithAngle(Latitude = latitude, SolarDeclination = dec, SolarHourAngle = SA)
exrad <- I_n( Interval = interval )
AM <- AirMass( SolarZenithAngle = SZA)
ghi <- GHI_clr(SolarZenithAngle = SZA, AirMass = AM, Elevation = 22, ExtraterrestrialRadiation = exrad)
plot( ghi[1:(48*365)], xlab = 'time', ylab = 'W/m^2', type = 'l', main = 'Global Horizontal Irradiance')
df <- data.frame(Time = seq(1:(2 * 24 * 365)), ETR = exrad, Dangle = dayAngle, EQT = E_T, ZenithAngle = SZA, AirMass = AM, GHI = ghi)
write.csv(df, file = './data/GHI.csv')
