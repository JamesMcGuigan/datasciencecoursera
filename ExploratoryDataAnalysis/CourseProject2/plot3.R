# Exploratory Data Analysis - Course Project 2
# Author - James McGuigan
#
# Question 3: Of the four types of sources indicated by the type 
#             (point, nonpoint, onroad, nonroad) variable, 
#             which of these four sources have seen decreases in emissions from 1999–2008 
#             for Baltimore City? 
#             Which have seen increases in emissions from 1999–2008? 
#             Use the ggplot2 plotting system to make a plot answer this question.
source("dataLoad.R")
library("plyr")
library("ggplot2")

NEI.Baltimore <- subset( data.load.summary(), fips == "24510" )
str(NEI.Baltimore)

NEI.Emissions <- ddply( NEI.Baltimore, .(year,type), function(df) { c( emissions = sum(df$Emissions) )})
str(NEI.Emissions)

render <- function() {
  qplot(year, emissions, 
        data=NEI.Emissions, 
        facets= . ~ type, 
        geom = "line", 
        xlab="Year", 
        ylab="NEI Emissions / tons", 
        main="PM2.5 Emmisions in Baltimore by Type"
        )  
}
render()
png("plot3.png"); render(); dev.off()
