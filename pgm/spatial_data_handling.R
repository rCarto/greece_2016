# Handling spatial data
library(sp) # display and manage spatial objects
library(rgdal) # import shapefiles & manage projection

# import shapfiles
road <- readOGR(dsn = "data/shp", layer = "odiko_souli")
localities <- readOGR(dsn = "data/shp", layer = "oikismoi_souli")
landcover <- readOGR(dsn = "data/shp", layer = "souli_corine")

# class of imported objects
class(road)
class(localities)
class(landcover)

# what is in spatial objects
head(road@data)
road@bbox
road@proj4string

# add projection info
landcover@proj4string
landcover@proj4string <- localities@proj4string
landcover@proj4string

# display the map
plot(landcover, col = "grey80", lwd = "0.5", border = "grey50")
plot(road, col = "red", lwd = 2, add = TRUE)
plot(localities, col = "white", cex = 1.5, pch = 21, add = TRUE)
title("Souli")
