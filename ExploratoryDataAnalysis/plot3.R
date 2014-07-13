# Exploratory Data Analysis - Course Project 1 - Plot 2
# @author James McGuigan 
# @link   https://class.coursera.org/exdata-004/human_grading/view/courses/972141/assessments/3/submissions

source("./plotData.R")

plot3 <- function(data) {
  with(Sub_metering_1 ~ Weekstamp, data, 
    xyplot(panel=function(){
      xyplot(
        Sub_metering_1 ~ Weekstamp, 
        data, 
        type = "l",
        col  = "black",
        ylab = "Energy Sub Metering",
        xlab = "",
        scales = list(
          x = list( at = as.numeric(daynames)*24*60, labels = daynames, tck = c(1,0) )
        )
    })
  ))
  with(data, plot(
    Sub_metering_2 ~ Weekstamp, 
    data, 
    type = "l",
    col  = "red",
    ylab = "Energy Sub Metering",
    xlab = "",
    scales = list(
      x = list( at = as.numeric(daynames)*24*60, labels = daynames, tck = c(1,0) )
    )
  ))
  
}

data <- data.process( data.read(ziptxt.sample) );
plot3(data)
#dev.copy(png,"./plot3.png")
#dev.off()
