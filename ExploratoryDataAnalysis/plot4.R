# Exploratory Data Analysis - Course Project 1 - Plot 4 + Combined
# @author James McGuigan 
# @link   https://class.coursera.org/exdata-004/human_grading/view/courses/972141/assessments/3/submissions

source("./plotData.R")
source("./plot3.R")

plotGlobal <- function(data) {
  xyplot(Global_active_power ~ Weekstamp, 
         data = data, 
         allow.multiple = FALSE, 
         aspect = 1,
         type = "l",
         ylab = "Global Active Power",
         xlab = "",
         col = "black",
         scales = list(
           x = list( at = as.numeric(daynames)*24*60, labels = daynames, tck = c(1,0) ),
           y = list( tck = c(1,0), rot=90 )
         )
  )
}
plotVoltage <- function(data) {
  xyplot(Voltage ~ Weekstamp, 
         data = data, 
         allow.multiple = FALSE, 
         aspect = 1,
         type = "l",
         #ylab = "Voltage",
         xlab = "datetime",
         col = "black",
         scales = list(
           x = list( at = as.numeric(daynames)*24*60, labels = daynames, tck = c(1,0) ),
           y = list( tck = c(1,0), tick.number=10, rot=90 )
         )
  )
}
plotReactive <- function(data) {
  xyplot(Global_reactive_power ~ Weekstamp, 
         data = data, 
         allow.multiple = TRUE, 
         aspect = 1,
         type = "l",
         ylab = "Global Reactive Power",
         xlab = "datetime",
         col = "black",
         scales = list(
           x = list( at = as.numeric(daynames)*24*60, labels = daynames, tck = c(1,0) ),
           y = list( tck = c(1,0), rot=90 )
         )
  )
}

plot4 <- function(data) {
  plot(plot3(data, labels=FALSE), split = c(1, 2, 2, 2), newpage = TRUE)
  plot(plotGlobal(data),   split = c(1, 1, 2, 2), newpage = FALSE)
  plot(plotVoltage(data),  split = c(2, 1, 2, 2), newpage = FALSE)
  plot(plotReactive(data), split = c(2, 2, 2, 2), newpage = FALSE)
}

render4 <- function() {
  data <- data.process( data.read(ziptxt.sample) ); data
  summary(data)
  
  png('./plotGlobal.png')
  plotGlobal(data)
  dev.off()  
  
  png("./plotVoltage.png")
  plotVoltage(data)  
  dev.off()
  
  png("./plotReactive.png")
  plotReactive(data)
  dev.off()
  
  png("./plot4.png")
  plot4(data)
  dev.off()  
}

render4()
