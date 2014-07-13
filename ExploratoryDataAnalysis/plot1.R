# Exploratory Data Analysis - Course Project 1 - Plot 1
# @author James McGuigan 
# @link   https://class.coursera.org/exdata-004/human_grading/view/courses/972141/assessments/3/submissions

source("./plotData.R")

plot1 <- function(data) {
  with(data, hist(Global_active_power, 
                  col   = "red",
                  main  = "Global Active Power",
                  xlab  = "Global Active Power (kilowatts)"))
}

data <- data.process( data.read(ziptxt.sample) );
plot1(data)
dev.copy(png,"./plot1.png")
dev.off()