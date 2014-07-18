# Exploratory Data Analysis - Course Project 2
# Author - James McGuigan
#
# Question 5: How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City? 

source("dataLoad.R")
library("plyr")
library("ggplot2")

# Extract the list of SCC codes
SCC <- data.load.classification()
SCC.Vehicle <- SCC[grepl( "vehicle", SCC$Short.Name, ignore.case=TRUE, perl=TRUE ),]$SCC

NEI.Baltimore <- subset( data.load.summary(), fips == "24510" )
NEI.Vehicle   <- subset(NEI.Baltimore, SCC %in% SCC.Vehicle)
NEI.Emissions <- ddply( NEI.Vehicle, .(year,type), function(df) { c( emissions = sum(df$Emissions) )})
str(NEI.Emissions)

render <- function() {
  qplot(year, emissions, 
        data   = NEI.Emissions, 
        facets = . ~ type, 
        geom   = "line", 
        xlab   = "Year", 
        ylab   = "NEI Emissions / tons", 
        main   = "PM2.5 Vehicle Emmisions in Baltimore by Type"
  )  
}
render()
png("plot5.png"); render(); dev.off()