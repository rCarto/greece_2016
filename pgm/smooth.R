library(cartography)
library(SpatialPosition)
data(nuts2006)

# Compute the GDP per capita variable
nuts3.df$gdpcap <- nuts3.df$gdppps2008 * 1000000 / nuts3.df$pop2008

# Discretize of the variable
bv <- quantile(nuts3.df$gdpcap, seq(from = 0, to = 1, length.out = 9))

# Merge the data frame and the SpatialPolygonsDataFrame
nuts3.spdf@data <- nuts3.df[match(nuts3.spdf$id, nuts3.df$id),]

# Compute the potentials of population on a regular grid (50km span)
# function = exponential, beta = 2, span = 75 km
poppot <- stewart(knownpts = nuts3.spdf, 
                  varname = "pop2008", 
                  typefct = "exponential", 
                  span = 75000, 
                  beta = 2, 
                  resolution = 50000, 
                  mask = nuts0.spdf)

# Compute the potentials of GDP on a regular grid (50km span)
# function = exponential, beta = 2, span = 75 km
gdppot <- stewart(knownpts = nuts3.spdf, 
                  varname = "gdppps2008", 
                  typefct = "exponential", 
                  span = 75000, 
                  beta = 2, 
                  resolution = 50000, 
                  mask = nuts0.spdf)

# Transform the regularly spaced SpatialPointsDataFrame to a raster
popras <- rasterStewart(poppot)
gdpras <- rasterStewart(gdppot)

# Compute the GDP per capita 
ras <- gdpras * 1000000 / popras

# Create a SpatialPolygonsDataFrame from the raster
pot.spdf <- contourStewart(x = ras, 
                           breaks = bv, 
                           mask = nuts0.spdf, 
                           type = "poly")

# Draw the map
par <- par(mar = c(0,0,1,0))

# Draw the basemap
plot(nuts0.spdf, add = F, border = NA, bg = "#cdd2d4")
plot(world.spdf, col = "#f5f5f3ff", border = "#a9b3b4ff", add = TRUE)


# Set a color palette
pal <- carto.pal(pal1 = "wine.pal", n1 = 8)

# Map the potential GDP per Capita
choroLayer(spdf = pot.spdf, df = pot.spdf@data, var = "mean", 
           legend.pos = "topright",
           breaks = bv, col = pal, add=T, 
           border = "grey90", lwd = 0.2,
           legend.title.txt = "Potential\nGDP per capita",
           legend.values.rnd = -2)
plot(nuts0.spdf, add=T, lwd = 0.5, border = "grey30")
plot(world.spdf, col = NA, border = "#7DA9B8", add=T)

# Set a text to explicit the function parameters
text(x = 6271272, y = 3743765, 
     labels = "Distance function:\n- type = exponential\n- beta = 2\n- span = 75 km", 
     cex = 0.8, adj = 0, font = 3)

# Set a layout
layoutLayer(title = "Wealth Inequality in Europe", 
            sources = "Basemap: UMS RIATE, 2015 - Data: Eurostat, 2008", 
            author = "T. Giraud, 2015")