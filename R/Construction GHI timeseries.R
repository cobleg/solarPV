

# Objective: construct the GHI time series
# Author: Grant Coble-Neal

dayAngle = DayAngle( timeframe = seq(1:365), Interval = '60-minute', daysInYear = 365 )
dec <- SolarDeclination(dayAngle)
E_T <- EoT(dayAngle)
TimeCorr <- TC(L_st = 120, L_loc = 115.86, EquationOfTime = E_T)
LST <- t_sol(TimeCorrection = TimeCorr, DaylightSavingsTime = FALSE)
SHA <- SolarHourAngle( LocalSolarTime = LST )
SZA <- SolarZenithAngle(Latitude = -31.95, SolarDeclination = dec, SolarHourAngle = SHA)
exrad <- I_n( Interval = '60-minute' )
AM <- AirMass( SolarZenithAngle = SZA)
ghi <- GHI_clr(SolarZenithAngle = SZA, AirMass = AM, Elevation = 22, ExtraterrestrialRadiation = exrad)
plot( ghi[1:24*10], ylab = 'Wh/m^2', type = 'l')
df <- data.frame(Time = seq(1:8760), ETR = exrad, Dangle = dayAngle, EQT = E_T, ZenithAngle = SZA, AirMass = AM, GHI = ghi)
write.csv(df, file = './data/GHI.csv')
