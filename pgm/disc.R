data(nuts2006)
nuts0.contig.spdf <- getBorders(nuts0.spdf)
nuts0.contig.spdf$col <- sample(x = rainbow(96))
plot(nuts0.spdf, border = NA, col = "grey60")
plot(nuts0.contig.spdf, col = nuts0.contig.spdf$col, lwd = 3, add=T)
layoutLayer(title = 'State Borders',
            author = "T. Giraud", sources = "",
            south = T, scale = NULL)


nuts0.df$gdphab <- nuts0.df$gdppps2008 * 1000000 / nuts0.df$pop2008
par(mar = c(0,0,1.2,0))
choroLayer(spdf = nuts0.spdf, df = nuts0.df, 
           var = "gdphab", method = "q6",
           legend.title.txt = "PIB par habitants\n(en euros)",  
           legend.values.rnd = 0, legend.pos = "topright", add=F)
plot(nuts0.spdf, col=NA, lwd=1, border="white", add=T)
discLayer(spdf = nuts0.contig.spdf, df = nuts0.df, 
          dfid = "id", spdfid1 = "id1", spdfid2 = "id2",
          var = "gdphab", col="red", nclass=5, 
          legend.pos = "right", legend.values.rnd = 0,
          legend.title.txt = "Différentiel de \nPIB par habitants", 
          method="equal", threshold = 0.5, sizemin = 1,
          sizemax = 8, type = "abs", add=TRUE )
layoutLayer(title = 'Différentiels de richesse en Europe',
            author = "T. Giraud", sources = "Eurostat, 2008",
            scale = NULL)