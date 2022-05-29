

# Objective: set up a process script to generate GHI time series on demand given time interval and location
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
source('./R/ineichen GHI clear.R')

library(lubridate)
library(dplyr)


# Set Start Interval (Format = YYYY-mm-dd HH:MM:SS)
start_interval <- ymd_hms('2022-01-01 00:00:00')

# Set End Interval (Format = YYYY-mm-dd HH:MM:SS)
end_interval <- ymd_hms('2023-12-31 23:30:00')

# Set increment. For more increment types: https://www.rdocumentation.org/packages/base/versions/3.6.2/topics/seq.POSIXt
interval <- '30-minute'
increment <- '30 mins'
latitude = -31.95
longitude.local = 115.86
longitude.localTimeZone = 120
elevation = 22 # metres above sea level
dayIndex = seq(1:365)
daysInYear = 365

dayAngle = DayAngle( timeframe = dayIndex, Interval = interval, daysInYear = daysInYear )
GHI_clr <- data.frame(
  Interval = seq.POSIXt(start_interval, end_interval, by=increment)) %>%
  mutate(Calendar.Year = year(Interval),
         Index = yday(Interval)) %>%
  group_by(Calendar.Year) %>%
  mutate(DaysInYear = max(Index),
         Day.Angle = DayAngle( timeframe = dayIndex, Interval = interval, daysInYear = daysInYear ),
          SolarDeclination = SolarDeclination(Day.Angle),
          EquationOfTime = EoT(dayAngle),
          Time.Correction = TC(L_st = longitude.localTimeZone, L_loc = longitude.local, EquationOfTime = EquationOfTime),
          LocalSolarTime = t_sol2(TimeCorrection = unique(Time.Correction), DaylightSavingsTime = FALSE, UnitInterval = interval),
          Solar.Angle = SolarAngle( LocalSolarTime = LocalSolarTime ),
          SolarZenithAngle = SolarZenithAngle(Latitude = latitude, SolarDeclination = SolarDeclination, SolarHourAngle = Solar.Angle),
          ETR = I_n( Interval = interval ),
          Air.Mass = AirMass( SolarZenithAngle = SolarZenithAngle),
          GHI.ClearSkies = GHI_clr(SolarZenithAngle = SolarZenithAngle, AirMass = Air.Mass, Elevation = elevation, ExtraterrestrialRadiation = ETR)
   )
