# Handling spatial data
library(sp) # display and manage spatial objects
library(rgdal) # import shapefiles & manage projection
library(cartography) # mapping functions
library(osrm) # road time-distance
library(rgeos) # geocomputations
?osrm

# import shapfiles
road <- readOGR(dsn = "data/shp", layer = "odiko_souli")
localities <- readOGR(dsn = "data/shp", layer = "oikismoi_souli")
landcover <- readOGR(dsn = "data/shp", layer = "souli_corine")
landcover@proj4string <- localities@proj4string


# Compute distances
row.names(localities) <- localities@data$OBJECTID
dist <- gDistance(localities[1:5,], byid = TRUE) 
distkm <- round(dist/1000, 0)
distkm
distmin <- osrmTable(loc = localities@data[1:5,], 
                     locId = "OBJECTID", 
                     locLat = "LAT", locLon = "LON") 

distmin$distance_table

# get OpenStreetMap basemap
osm <- getTiles(localities[1:5,])
tilesLayer(osm)
plot(road, col = "red", lwd = 2, add = TRUE)
plot(localities[1:5,], add=T, pch = 20, cex = 2)
labelLayer(spdf = localities[1:5, ], df = localities[1:5, ]@data, 
           txt = "OBJECTID", pos = 3)

# extract two points
start <- localities[localities$OBJECTID=="2923",]
end <- localities[localities$OBJECTID=="2931",]
plot(start, col="green", add=TRUE, pch = 20, cex = 3)
plot(end, col="orange", add=TRUE, pch = 20, cex = 3)

# time and distance between the two points
roadtrip <- osrmViaroute(src =  c(start$LAT, start$LON), 
                         dst =  c(end$LAT, end$LON))
roadtrip
# speed (km/h)
roadtrip[2]/(roadtrip[1]/60)

# get the travel geometry
longroad <- osrmViarouteGeom(src = c(start$OBJECTID, start$LAT, start$LON),
                             dst = c(end$OBJECTID, end$LAT, end$LON),
                             sp = TRUE)
class(longroad)
longroad@proj4string
# reproject the travel geometry
longroad <- spTransform(x = longroad, CRSobj = road@proj4string)

# Map the travel
osm <- getTiles(longroad)
tilesLayer(osm)
plot(longroad, col = "red", add=T, lwd = 2)
plot(start, col="green", add=TRUE, pch = 20, cex = 3)
plot(end, col="orange", add=TRUE, pch = 20, cex = 3)

