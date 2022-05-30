

# Objective: create a function to calculate all-skies Global Horizontal Irradiance (GHI)
# Author: Grant Coble-Neal

GHI_all <- function(ghi_clr, parameters = c(alpha_s = 0.5, alpha_r = 0.9, f = 0.2, T = ))
{
  # ghi_clr: Global Horizontal Irradiance for clear skies
  # alpha_s: surface albedo 
  # alpha_r: cloud albedo
  # f: cloud fraction
  
  F_cld = ( 1 - alpha_r ) * GHI_all # downwelling irradiance for overcast skies
  
}