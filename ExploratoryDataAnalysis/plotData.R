set.seed(1)
library("R.utils")
library("lattice")

zipurl    <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
zipfile   <- "./household_power_consumption.zip"
ziptxt    <- "./household_power_consumption.txt";
ziptxt.sample <- "./household_power_consumption.sample.txt"
ziptxtN   <- 2075260 # countLines(ziptxt);
daynames  <- c("Monday","Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday")
daynames  <- ordered(daynames, levels=daynames)
dayfilter <- ordered(c("Thursday", "Friday"), levels=daynames)

##### Helper Functions #####

sample.df <- function(df, n) { 
  df[sample(nrow(df), n), , drop = FALSE] 
}
str2Timestamp <- function(str) { 
  times <- lapply(strsplit(str,":"), as.numeric);
  sapply( times, function(time) {
    sum( time[1] * 60, time[2] )      
  })  
}
date2weekstamp <- function(dates) { 
  match(weekdays(dates), daynames) * 24*60
}



##### Download Data #####

data.download <- function() {
  if( !file.exists(zipfile)  ) { download.file(zipurl, zipfile, method="wget"); unzip(zipfile); }
  if( !file.exists(ziptxt.sample) ) {
    # Main dataset is sorted by date, extract small working sample for debugging
    command <- paste("( head -n 1", ziptxt, "; tail -n +2", ziptxt, " | shuf -n 1000 ) > ", ziptxt.sample)
    system( command )
  }  
}
data.read <- function(ziptxt, nrows=-1, skip=0) {
  data.download();
  read.table(ziptxt, skip=skip, nrows=nrows, header=TRUE, sep=";", na.strings="?", colClasses=c("character","character", rep("numeric",7) ))
};
data.process <- function(data) {
  # Extract, format and sort
  data$Date      <- as.POSIXct(strptime(data$Date, format = "%d/%m/%Y"), origin = "1960-01-01")
  data$Weekday   <- ordered(weekdays(data$Date), levels=daynames)
  data$WeekdayN  <- match(data$Weekday, daynames);
  data$Hour      <- data$WeekdayN*24*60 + as.numeric(substr(data$Time, 0, 2))
  data$Timestamp <- str2Timestamp(data$Time)
  data$Weekstamp <- date2weekstamp(data$Date) + str2Timestamp(data$Time)
  
  data           <- data[data$Weekday %in% dayfilter, ] # filter by day range
  data           <- data[ order(data$Weekstamp), ] # sort by Timestamp
  data
}