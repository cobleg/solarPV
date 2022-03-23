# solarPV
Contains solar photovoltaic electricity generation data analytics. The R code and data relate to the Clean Energy Regulator (CER) data, [which can be found here](http://www.cleanenergyregulator.gov.au/RET/Forms-and-resources/Postcode-data-for-small-scale-installations/historical-postcode-data-for-small-scale-installations).

The compiled CER data corresponds to the South West Interconnected System (SWIS) region. [More information about the SWIS can be found here](https://www.infrastructureaustralia.gov.au/map/south-west-interconnected-system-transformation#:~:text=Western%20Australia's%20main%20electricity%20network,interconnections%20to%20other%20transmission%20systems).

The geospatial files used to create the SWIS region shapefile [can be found here](https://catalogue.data.wa.gov.au/dataset/forecast-remaining-capacity-2021).

The Postal Area (POA) and Local Government Area (LGA) files used to create the within-SWIS region POA and LGA data sets [can be found here](https://www.abs.gov.au/statistics/standards/australian-statistical-geography-standard-asgs-edition-3/jul2021-jun2026). Refer to the R scripts contained herein for the exact URLs used.

## Context
The data compiled in this project is used to generate a composite solar irradiance profile for the SWIS region.
