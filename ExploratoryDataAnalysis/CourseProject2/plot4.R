# Exploratory Data Analysis - Course Project 2
# Author - James McGuigan
#
# Question 4: Across the United States, how have emissions 
#             from coal combustion-related sources changed from 1999–2008?

source("dataLoad.R")
library("plyr")
library("ggplot2")

# Extract the list of SCC codes containing coal in their name
SCC <- data.load.classification()
SCC.Coal <- SCC[grepl( "Coal", SCC$Short.Name, ignore.case=TRUE, perl=TRUE ),]$SCC

NEI           <- data.load.summary()
NEI.Coal      <- subset(NEI, SCC %in% SCC.Coal)
NEI.Emissions <- ddply( NEI.Coal, .(year,type), function(df) { c( emissions = sum(df$Emissions) )})
str(NEI.Emissions)

render <- function() {
  qplot(year, emissions, 
        data   = NEI.Emissions, 
        facets = . ~ type, 
        geom   = "line", 
        xlab   = "Year", 
        ylab   = "NEI Emissions / tons", 
        main   = "PM2.5 Coal Emmisions in US"
  )  
}
render()
png("plot4.png"); render(); dev.off()

