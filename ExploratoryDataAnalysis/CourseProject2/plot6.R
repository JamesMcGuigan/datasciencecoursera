# Exploratory Data Analysis - Course Project 2
# Author - James McGuigan
#
# Question 6: Compare emissions from motor vehicle sources in Baltimore City with emissions 
#             from motor vehicle sources in Los Angeles County, California (fips == "06037"). 
#             Which city has seen greater changes over time in motor vehicle emissions?

source("dataLoad.R")
library("plyr")
library("ggplot2")

# Extract the list of SCC codes
SCC <- data.load.classification()
SCC.Vehicle <- SCC[grepl( "vehicle", SCC$Short.Name, ignore.case=TRUE, perl=TRUE ),]$SCC

NEI.Baltimore.LA        <- subset( data.load.summary(), fips == "24510" | fips == "06037" )
NEI.Baltimore.LA$county <- factor( ifelse( NEI.Baltimore.LA$fips == "24510", "Baltimore", "Los Angeles") )

NEI.Vehicle   <- subset(NEI.Baltimore.LA, SCC %in% SCC.Vehicle)
NEI.Emissions <- ddply( NEI.Vehicle, .(year,county), function(df) { c( emissions = sum(df$Emissions) )})
str(NEI.Emissions)

# log10 allows us to plot percentage changes, rather than absolute changes
render <- function() {
  qplot(year, log10(emissions), 
        data   = NEI.Emissions, 
        facets = . ~ county, 
        geom   = "line", 
        xlab   = "Year", 
        ylab   = "log10 NEI Emissions / tons", 
        main   = "PM2.5 Vehicle Emmisions - Baltimore and Los Angeles"
  )  
}

render()
png("plot6.png"); render(); dev.off()

