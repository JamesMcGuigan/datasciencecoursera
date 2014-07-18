# Exploratory Data Analysis - Course Project 2
# Author - James McGuigan
#
# Question 2: Have total emissions from PM2.5 decreased in the 
#             Baltimore City, Maryland (fips == "24510") from 1999 to 2008? 
#             Use the base plotting system to make a plot answering this question.

source("dataLoad.R")
NEI.Baltimore <- subset( data.load.summary(), fips == "24510" )

NEI.Emissions <- sapply(split( NEI.Baltimore, NEI.Baltimore$year ), function(NEI.by.year) {
  sum(NEI.by.year$Emissions)
})

render <- function() {
  plot(names(NEI.Emissions), NEI.Emissions, 
       type="l",
       xlab="Year", 
       ylab="NEI Emissions / tons", 
       main="PM2.5 Emissions in Baltimore"
  )  
}

render()
png("plot2.png"); render(); dev.off()