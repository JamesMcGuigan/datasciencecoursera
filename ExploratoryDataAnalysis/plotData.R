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
dayfilter <- c("2/1/2007", "3/1/2007")

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
  if( !file.exists(zipfile) ) { download.file(zipurl, zipfile, method="wget"); }
  if( !file.exists(ziptxt)  ) { unzip(zipfile); }
  if( !file.exists(ziptxt.sample) ) {
    system.time({
      print(paste("Reading file:",zipfile))
      data <- data.read(ziptxt)
      data.filtered <- data.filter(data)
      write.table(data.filtered, ziptxt.sample, sep=";", quote=FALSE, row.names=FALSE)
    })
    
    # Main dataset is sorted by date, extract small random working sample for debugging
    #command <- paste("( head -n 1", ziptxt, "; tail -n +2", ziptxt, " | shuf -n 1000 ) > ", ziptxt.sample)
    #system( command )
  }  
}
data.read <- function(ziptxt, nrows=-1, skip=0) {
  if( !exists("nrows") ) { nrows <- -1 }
  if( !exists("skip")  ) { skip  <-  50000 }
  if( !file.exists(ziptxt) ) { data.download(); }
  
  data  <- read.table(ziptxt, skip=skip, nrows=nrows, header=TRUE, sep=";", na.strings="?", colClasses=c("character","character", rep("numeric",7) ))
  names(data) <- names( read.table(ziptxt, nrows=1, header=TRUE, sep=";", na.strings="?", colClasses=c("character","character", rep("numeric",7) )))  # skip > 0 ignores headers
  data
};
data.filter <- function(data) {
  data[ data$Date %in% dayfilter, ]
}
data.process <- function(data) {
  # Extract, format and sort
  data$Datect    <- as.POSIXct(strptime(data$Date, format = "%d/%m/%Y"), origin = "1960-01-01")
  data$Weekday   <- ordered(weekdays(data$Datect), levels=daynames)
  data$WeekdayN  <- match(data$Weekday, daynames);
  data$Hour      <- data$WeekdayN*24*60 + as.numeric(substr(data$Time, 0, 2))
  data$Timestamp <- str2Timestamp(data$Time)
  data$Weekstamp <- date2weekstamp(data$Datect) + str2Timestamp(data$Time)
  
  data           <- data[ order(data$Weekstamp), ] # sort by Timestamp
  data
}