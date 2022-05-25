
# Objective: trying the clearskies package

# install.packages("remotes")
# remotes::install_github("dslaw/clearskies")

library(clearskies)

dayofyear = 1
year = 2019
tz = 8
lat = -31.95
long = 115.86

Ineichen(dayofyear, year, tz, latitude, longitude, interval, elevation,
         parameters = c(a = 0.50572, b = 6.07995, c = 1.6364, TL = 3))


eugene_oregon <- list(Latitude = 44.05, Longitude = -123.07, Timezone = -8)
day <- list(DayOfYear = 245, Year = 2014, Interval = 1)
params <- list(a = 1159.24, b = 1.179, c = -0.0019) # defaults

dat <- eugene[ eugene[["DayOfYear"]] == day$DayOfYear, ]
observed <- dat[["Ghi"]]

model <- clear_sky("RS", x = day, y = eugene_oregon, parameters = params,
                   data = observed)
model <- clear_points(model, thresholds = thresholds, window_len = 10L)

summary(model)

model.1 <- clear_sky("Ineichen", dayofyear = 1, year = 2019, tz = 8, latitude = -31.95, longitude = 115.86, interval = 1, elevation = 0,
                     parameters = c(a = 0.50572, b = 6.07995, c = 1.6364, TL = 3))

summary(model.1)

plot(model.1)

predicted <- data.frame( "Prediction" = model.1$predicted)

exrad(1, 10)
