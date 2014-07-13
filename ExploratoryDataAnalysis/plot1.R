# Exploratory Data Analysis - Course Project 1 - Plot 1
# @author James McGuigan 
# @link   https://class.coursera.org/exdata-004/human_grading/view/courses/972141/assessments/3/submissions

source("./plotData.R")

plot1 <- function(data) {
  with(data, histogram(Global_active_power, 
                  col   = "red",
                  main  = "Global Active Power",
                  xlab  = "Global Active Power (kilowatts)"),
                  add   = TRUE
       )
}

render1 <- function() {
  data <- data.process( data.read(ziptxt.sample) );
  png("./plot1.png")
  plot1(data)
  dev.off()  
}
render1()