# Exploratory Data Analysis - Course Project 1 - Plot 2
# @author James McGuigan 
# @link   https://class.coursera.org/exdata-004/human_grading/view/courses/972141/assessments/3/submissions

source("./plotData.R")

plot3 <- function(data) {
  colors <- c("black","red","blue")
  xyplot(Sub_metering_1 + Sub_metering_2 + Sub_metering_3 ~ Weekstamp, 
         data = data, 
         allow.multiple = TRUE, 
         aspect = 1,
         type = "l",
         ylab = "Energy Sub Metering",
         xlab = "",
         par.settings = list(superpose.line=list(col = colors)),
         
         auto.key = list(
           lines  = T,
           points = F,
           border = T,
           space  = "inside",
           corner = c(1, 1),
           padding.text = 5,
           col = colors
         ),
         scales = list(
           x = list( at = as.numeric(daynames)*24*60, labels = daynames, tck = c(1,0) ),
           y = list( tck = c(1,0), limits=c(0,26) )
         )
       )
}

data <- data.process( data.read(ziptxt.sample) ); data
plot3(data)
dev.copy(png,"./plot3.png")
dev.off()
