

# Objective: create a function to calculate all-skies Global Horizontal Irradiance (GHI)
# Author: Grant Coble-Neal
# Reference: Andrew Kumler, Yu Xie, Yingchen Zhang, A Physics-based Smart Persistence model for Intra-hour forecasting 
#            of solar radiation (PSPI) using GHI measurements and a cloud retrieval technique, Solar Energy, 
#            Volume 177, 2019, Pages 494-500, ISSN 0038-092X, https://doi.org/10.1016/j.solener.2018.11.046.


GHI_all <- function(ghi_clr, T_RS, parameters = c(alpha_s = 0.5, alpha_r = 0.9, f = 0.2 ))
{
  # ghi_clr: Global Horizontal Irradiance for clear skies
  # T_RS Transmittance of Rayleigh scattering index ( 0 < T_RS < 1); not clear from paper if T is T_RS
  # alpha_s: surface albedo 
  # alpha_r: cloud albedo
  # f: cloud fraction (0 =< f =< 1)
  
  alpha_r = parameters[['alpha_r']]
  alpha_s = parameters[['alpha_s']]
  f = parameters[['f']]
  
  F_cld <- ( 1 - alpha_r ) * ghi_clr # downwelling irradiance for overcast skies
  F_1 <- f * F_cld + ( 1 - f ) * ghi_clr
  return( F_1 / (1 - alpha_s * alpha_r * f * T_RS^2 ) )
}

# parameters = c(alpha_s = 0.5, alpha_r = 0.9, f = 0.2 )
# alpha_r = parameters[['alpha_r']]
