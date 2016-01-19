# basic operations
3 + 3 

3 - 1

3 ** 2

9 ** (1/2)

# create objects
v1 <- 12
v1
class(v1)

v2 <- "foo"
v2
class(v2)
# number of characters
nchar(v2)

v3 <- c(1,4,6,3,7,10)
v3
class(v3)

# get basic statistics on an object
max(v3)
min(v3)
mean(v3)
median(v3)
length(v3)

# get help on a function
?max

# create more complex objects
df <- data.frame(var1 = c(5,2,3,4,5,6), 
                 var2 = c("A", "A", "B", "C", "A", "C"), 
                 var3 = v3 )
df
class(df)
# get a summary of the object
summary(df)

# the special column row.names
row.names(df)

# set the row.names
row.names(df) <- paste("ID", row.names(df), sep = "_")

row.names(df)

df

# what is my working directory
getwd()

# set wy working directory
# setwd(dir = "/home/tg/Documents/greece_2016")



# import a data file in R
nuts2data <- read.csv("data/nuts2data.csv")
# class of the object 
class(nuts2data)
# number of rows of the data frame
nrow(nuts2data)
# number of column
ncol(nuts2data)
# dimension
dim(nuts2data)

# show the first lines of the data frame
head(nuts2data)

# "View" a data frame
View(nuts2data)

# add a variable
nuts2data$act <- nuts2data$emp + nuts2data$unemp

# show the first lines of the data frame
head(nuts2data)

# get a summary on the dataset
summary(nuts2data)

# get statistics on a variable
mean(nuts2data$gdp)
median(nuts2data$gdp)
sd(nuts2data$gdp)

# select lines and/or colums from a data.frame
# select the first line 
nuts2data[1,]
# select lines 1 to 10
nuts2data[1:10,]
# select a set of lines
nuts2data[c(1,3,4,5,6,17),]
# select the first column
head(nuts2data[,1])
# select the 3 first columns
head(nuts2data[,1:3])
# select a set of columns
head(nuts2data[, c(1,3,4)])
# select a column with its name
head(nuts2data[, c("id", "gdp")])
# combine line and column selection
nuts2data[1:10, c("id", "emp")]

# select with a condition
# only greek regions
nuts2data[substr(x = nuts2data$id, start = 1, stop = 2)=="GR", ]
# region with more than 5 000 000 employed persons
nuts2data[nuts2data$emp > 5000,]




# plot an histogram
hist(x = nuts2data$gdp)
hist(x = nuts2data$gdp, breaks = 20)

# plot a boxplot
boxplot(nuts2data$act)

# plot a graphic
plot(x = nuts2data$gdp, y = nuts2data$act)

# plor a customized graphic
options(scipen=5)
plot(x = nuts2data$gdp, y = nuts2data$act, 
     pch = 21, cex = 1, col = "grey20", bg = "grey70",
     frame = FALSE, las = 1, cex.axis = 0.8,
     xlab = "GDP", 
     ylab =  "Active population", 
     main = "Relation between GDP and\nActive population in Europe", 
     sub = "Eurostat, 2008")


# install a package
install.packages("ineq")

# load a package 
library(ineq)

# compute the Gini index for the gdp distribution
# https://en.wikipedia.org/wiki/Gini_coefficient
giniGDP <- Gini(x = nuts2data$gdp)

# compute the Lorentz curve
lorentzGDP <- Lc(nuts2data$gdp)

# plot the Lorentz curve
plot(lorentzGDP, asp = 1)
# the index on the plot
text(x = 0.2, y = 0.6, 
     labels = paste("Gini Index: ", round(giniGDP,1), sep = ""), 
     pos = 4)
