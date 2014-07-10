## Week 4
# Q1 -  Apply strsplit() to split all the names of the data frame on the characters 
#       "wgtp". What is the value of the 123 element of the resulting list?

q1url  <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv'
q1file <- './quizes/data/ss06hid.csv'
if( file.exists(q1file) ) {
  download.file(q1url,q1file,method="wget")
}
head(readLines(q1file))
q1data <- read.csv2(q1file, header=TRUE, sep=",");

sapply( names(q1data), function(x) { strsplit(x, "wgtp"); } )[123] # = ""   "15"


# Q2 -  Remove the commas from the GDP numbers in millions of dollars and average them. 
#       What is the average? 
q2url  <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv'
q2file <- './quizes/data/GDP.csv'
if( file.exists(q2file) ) {
  download.file(q2url,q2file,method="wget")
}
head(readLines(q2file))
q2data <- read.csv2(q2file, header=TRUE, sep=",");



# Q3 + 4 - see bottom of week3.r

# Q5 -  How many values were collected in 2012? 
#       How many values were collected on Mondays in 2012?
# install.packages("quantmod")
library(quantmod)
amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes = index(amzn) 


sampleTimes2012 <- sampleTimes[grep("^2012-.*", sampleTimes)]# = 250 values in 2012
length(sampleTimes2012) # = 250

sampleTimes2012Monday <- sampleTimes2012[ grepl("Monday", weekdays( sampleTimes2012 )) ]
length(sampleTimes2012Monday)
