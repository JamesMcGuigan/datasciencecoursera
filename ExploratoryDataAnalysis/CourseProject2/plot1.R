# Exploratory Data Analysis - Course Project 2
# Author - James McGuigan
#
# Question 1: Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
#             Using the base plotting system, make a plot showing the total PM2.5 emission 
#             from all sources for each of the years 1999, 2002, 2005, and 2008.

source("dataLoad.R")

NEI <- data.load.summary()

NEI.Emissions <- sapply(split( NEI, NEI$year ), function(NEI.by.year) {
  sum(NEI.by.year$Emissions)
})

render <- function() {
  plot(names(NEI.Emissions), NEI.Emissions, 
       type="l",
       xlab="Year", 
       ylab="NEI Emissions / tons", 
       main="USA - PM2.5 Emissions"
      )  
}

render()
png("plot1.png"); render(); dev.off()