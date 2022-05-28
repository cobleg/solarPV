

# Objective: calculate solar minute angle; 1,440 minutes in a day

# Author: Grant Coble-Neal

# Time is represented by an angle.
# References to noon, the Sun at its highest point in the sky each day.
# So noon is 0 degrees, time before noon (e.g. 11 AM) is represented by a negative angle.
# Time after noon is represented by a positive angle.
# Noon is 720 minutes after midnight.


SolarMinuteAngle <- function( LocalSolarTime )
{
  return( 360 / 1440 * (LocalSolarTime - 720) )
}
