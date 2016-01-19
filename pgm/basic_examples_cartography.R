data("nuts2006")
## Proportional Symbols 

# Dataser
head(nuts0.df)

# Countries plot
plot(nuts0.spdf)

# Population plot on proportional symbols
propSymbolsLayer(spdf = nuts0.spdf, df = nuts0.df, var = "pop2008")


# Layout plot
layoutLayer(title = "Countries Population in Europe", 
            sources = "Eurostat, 2008", 
            scale = NULL, 
            frame = TRUE,
            col = "black", 
            coltitle = "white",
            bg = "#D9F5FF",
            south = TRUE, 
            extent = nuts0.spdf)
# Countries plot
plot(nuts0.spdf, col = "grey60",border = "grey20", add=TRUE)
# Population plot on proportional symbols
propSymbolsLayer(spdf = nuts0.spdf, df = nuts0.df, 
                 var = "pop2008", k = 0.01,
                 symbols = "square", col =  "#920000",
                 legend.pos = "right", 
                 legend.title.txt = "Total\npopulation (2008)", 
                 legend.style = "c")



## Choropleth Layer
head(nuts2.df)
nuts2.df$unemprate <- nuts2.df$unemp2008/nuts2.df$act2008*100
choroLayer(spdf = nuts2.spdf, df = nuts2.df, var = "unemprate")

choroLayer(spdf = nuts2.spdf,
           df = nuts2.df,
           var = "unemprate",
           method = "quantile",
           nclass = 8, 
           lwd = 0.5,
           col = carto.pal(pal1 = "turquoise.pal", n1 = 8),
           border = "grey40",
           add = FALSE,
           legend.pos = "right",
           legend.title.txt = "Unemployement\nrate (%)",
           legend.values.rnd = 1)

plot(nuts0.spdf, add=T, border = "grey40")
layoutLayer(title = "Unemployement in Europe",
            sources = "Eurostat, 2008",
            frame = TRUE,
            col = "black",
            south = TRUE, 
            coltitle = "white")

vignette(topic = "cartography")
