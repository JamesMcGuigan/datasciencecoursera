# Q1 -  How many housing units in this survey were worth more than $1,000,000? 
# TYPE = 1  | Housing unit 
# VAL  = 24 | $1000000+

q1filename         <- './quizes/data/ss06hid.csv'
q1filenamecodebook <- './quizes/data/PUMSDataDict06.pdf' 
q1url              <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
q1codebookurl      <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf"

if( !file.exists(q1filename) ) {
  download.file(q1url, q1filename, method='wget')
  download.file(q1codebookurl, q1filenamecodebook, method='wget')
} 
q1dataset <- read.csv2(q1filename, header=TRUE,sep=",")
class(q1dataset)
summary(q1dataset)
head(q1dataset)

nrow(q1dataset[
  !is.na(q1dataset$TYPE) & !is.na(q1dataset$VAL) & q1dataset$TYPE == 1 & q1dataset$VAL == 24,
  c("TYPE","VAL")])
# = 53


# Q2 - Consider the variable FES in the code book. Which of the "tidy data" principles does this variable violate? 
nrow(q1dataset)
summary(q1dataset[,"FES"])


# Q3 - Download the Excel spreadsheet on Natural Gas Aquisition Program 
#      Read rows 18-23 and columns 7-15 into R and assign the result to a variable called: dat
#      What is the value of: sum(dat$Zip*dat$Ext,na.rm=T) 
require(gdata)
library(xlsx)
q3url  <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx"
q3file <- './quizes/data/DATA.gov_NGAP.xlsx'
if( !file.exists(q3file) ) { 
  download.file(q3url, q3file, method='wget'); 
}
q3data <- read.xls(q3file, header=FALSE)
dat <- q3table <- data.table(q3data[17:21,7:15]); dat
q3headingsTable <- q3data[16,7:15]
q3headings <- as.matrix(q3headingsTable)[1,] # cast to char vector
colnames(dat) <- q3headings; dat
dat$Zip <- as.numeric(as.character(dat$Zip))
dat$Ext <- as.numeric(as.character(dat$Ext))

cbind(dat$Zip, dat$Ext, dat$Zip * dat$Ext)
sum(dat$Zip*dat$Ext,na.rm=T)  # = 36534720


# Q4 -  How many restaurants have zipcode 21231? 
require(XML)
q4url  <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
q4file <- './quizes/data/restaurants.xml'
if( !file.exists(q4file) ) { 
  download.file(q4url, q4file, method='wget'); 
}
q4data <- xmlParse(q4file)
length(xpathSApply(q4data,"//zipcode[text()=21231]")) # = 127



# Q5 -  Which of the following is the fastest way to calculate the average value 
#       of the variable "pwgtp15" broken down by sex using the data.table package?

#install.packages("data.table")
require(data.table)
q5url  <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
q5file <- "./quizes/data/ss06pid.csv"
if( !file.exists(q5file) ) {
  download.file(q5url,q5file,method="wget")  
}
DT <- q5data <- fread(q5file,sep=",", na.strings="" )
DT <- DT[, lapply(.SD, function(x) { as.numeric(as.character(x)) })]; head(DT)

summary(DT)
stratergies <- list(
  function(DT) { tapply(DT$pwgtp15,DT$SEX,mean) },
  function(DT) { mean(DT[DT$SEX==1,]$pwgtp15); mean(DT[DT$SEX==2,]$pwgtp15) },
  function(DT) { rowMeans(DT)[DT$SEX==1]; rowMeans(DT)[DT$SEX==2] }, # fails to run
  function(DT) { sapply(split(DT$pwgtp15,DT$SEX),mean) },
  function(DT) { DT[,mean(pwgtp15),by=SEX] },
  function(DT) { mean(DT$pwgtp15,by=DT$SEX) }
);


times <- sapply(stratergies, function(stratergy){
  print(stratergy)
  system.time(
    try(for (i in 1:10) {
      answer <- stratergy(DT)
    })
  )["elapsed"]
})
names(times) <- 1:length(stratergies);
sort(times)
times

sort# [,1]   [,2]  [,3]  [,4]  [,5]
# user.self  0.200  8.552 0.121 0.204 0.007
# sys.self   0.045  0.880 0.015 0.009 0.000
# elapsed    0.271 10.640 0.140 0.215 0.008
# user.child 0.000  0.000 0.000 0.000 0.000
# sys.child  0.000  0.000 0.000 0.000 0.000