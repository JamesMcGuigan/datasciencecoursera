# Exploratory Data Analysis - Course Project 1 - Plot 2
# @author James McGuigan 
# @link   https://class.coursera.org/exdata-004/human_grading/view/courses/972141/assessments/3/submissions

source("./plotData.R")

plot2 <- function(data) {
  with(data, xyplot(
    Global_active_power ~ Weekstamp, 
    data, 
    type = "l",
    col  = "black",
    ylab = "Global Active Power (kilowatts)",
    xlab = "",
    scales = list(
      x = list( at = as.numeric(daynames)*24*60, labels = daynames, tck = c(1,0) ),
      y = list( limits = c(0,max(Global_active_power)) )
    )
  ))
}

data <- data.process( data.read(ziptxt.sample) );
plot2(data)
dev.copy(png,"./plot2.png")
dev.off()
