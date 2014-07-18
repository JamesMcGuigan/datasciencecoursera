# Video Q1
# Go to the web site for the EPA Air Quality System (AQS) data for downloading 
# and find the two files containing PM2.5 data for 1999 and 2012 
# that will be used in this video under PM2.5 "Local Conditions". 
# What is the AQS parameter code (a 5-digit code) for PM2.5?

url1999 <- "./AirPolutionCaseStudy//annual_all_1999.csv";
url2012 <- "./AirPolutionCaseStudy//annual_all_2012.csv";

data1999 <- read.csv(url1999)
data2012 <- read.csv(url2012)
str(data1999)
str(data2012)

factor(data1999[ grep("PM2.5 - Local Conditions", data1999$Parameter.Name), ]$Parameter.Code) # = 88101
