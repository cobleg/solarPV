

# Objective: create a function to calculate the time correction series
# Author: Grant Coble-Neal

# calculate time correction

TC = function( L_st, L_loc, EquationOfTime ){
  # longitude of the standard meridian (L_st), unit of measurement: degrees
  # longitude of a given site, unit of measurement: degrees
  
  L_c = 4*(L_loc - L_st) # difference in longitude converted to time (minutes). 
  #                        Note there are 4 minutes (in time) per degree of the Earth's rotation.
  
  return( L_c + EquationOfTime) # units of measurement: minutes of time
}
    
# TC(L_st = 120, L_loc = 115.86, (EoT(DayAngle(seq(1:1461), 365))))

