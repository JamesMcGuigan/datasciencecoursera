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
  
  plot1(data)
  dev.copy(png,"./plot1.png")
  dev.off()
  
  plot2(data)
  dev.copy(png,"./plot2.png")
  dev.off()

  plot3(data)
  dev.copy(png,"./plot3.png")
  dev.off()

  plotGlobal(data)
  dev.copy(png,"./plotGlobal.png")
  dev.off()  
  
  plotVoltage(data)
  dev.copy(png,"./plotVoltage.png")
  dev.off()
  
  plotReactive(data)
  dev.copy(png,"./plotReactive")
  dev.off()
  
  plot4(data)
  dev.copy(png,"./plot4.png")
  dev.off()  
}

render4()
