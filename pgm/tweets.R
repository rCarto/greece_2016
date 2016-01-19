# data import
library(cartography)
data(nuts2006)
load("data/tweets.RData")
# Map of all the tweets 
par(mar = c(0,0,1.2,0))
plot(frame.spdf, col = "#A2C4F5", add= F, border = NA)
plot(graticule.spdf, add=T, border = "white", lwd = 0.5)
plot(countries.spdf, col = "grey50", border = NA, add=T)
plot(nuts0.spdf, add=T, col = "black", border = "grey50", lwd = 0.5)
plot(coasts.spdf, col = '#DCE8FA', add=T)
plot(marseillegeo, col = '#1A7832', pch = ".", add=T)
layoutLayer(frame = F, title = 'Tweets Quoting Marseille',
            sources = "DMI - Amsterdam, 2015",
            author = "T. Giraud",
            south = T, scale = NULL)
text(x = 5564810,y = 4098997, labels = "Each dot is a tweet", 
     pos = 4, cex = 0.8, col = "white" )


# intersection between tweets & states
tweetsInNuts0 <- over(x = marseillegeo, y = nuts0.spdf)

tweetsInNuts0$nb <- 1
# counting tweets inside countries
tweetspercountry <- aggregate(x = tweetsInNuts0$nb, 
                              by = list(tweetsInNuts0$name), 
                              FUN = sum)
names(tweetspercountry) <- c("name", "nbtweets")
head(tweetspercountry[order(tweetspercountry$nbtweets, decreasing = T),])

# Create a grid of points
hexapoints <- spsample(x = nuts0.spdf, cellsize = 100000, type = 'hexagonal')
# convert the point grid into hexagon grid
hexapoly <- HexPoints2SpatialPolygons(hex = hexapoints)
datahexa <- data.frame(id = row.names(hexapoly), x = 1)
row.names(datahexa) <- datahexa$id
hexapoly <- SpatialPolygonsDataFrame(Sr = hexapoly, data = datahexa)
# Display hexagons
par(mar = c(0,0,0,0))
plot(hexapoly)


# intersection between tweets and hexagons
tweetsInHexaPoly <- over(x = marseillegeo, y = hexapoly)
# counting the tweets
marseilletweethexapoly <- aggregate(x = tweetsInHexaPoly$x, 
                                    by = list(tweetsInHexaPoly$id), FUN = sum)
names(marseilletweethexapoly) <- c("id", "n")

# Map 
par(mar = c(0,0,1.2,0))
plot(frame.spdf, col = "#A2C4F5", add= F, border = NA)
plot(graticule.spdf, add=T, border = "white", lwd = 0.5)
plot(countries.spdf, col = "grey50", border = NA, add=T)
plot(nuts0.spdf, add=T, col = "grey40", border = "grey50", lwd = 0.5)
plot(coasts.spdf, col = '#DCE8FA', add=T)
choroLayer(spdf = hexapoly[hexapoly@data$id %in% marseilletweethexapoly$id,], 
           df = marseilletweethexapoly, 
           var = "n", border = NA, method = "geom", 
           nclass = 5, legend.pos = "right", 
           legend.frame = TRUE,
           col = c("#B8D9A9" ,"#8DBC80" ,"#5D9D52" ,
                   "#287A22" ,"#17692C"), add = TRUE,
           legend.title.txt = "Number of   \ntweets")

layoutLayer(frame = F, title = 'Tweets quoting Marseille',
            sources = "DMI - Amsterdam, 2015",
            author = "T. Giraud",
            south = T, scale = NULL)

