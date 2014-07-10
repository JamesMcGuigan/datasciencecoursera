#Q1 - Create a logical vector that identifies the households 
#     on greater than 10 acres who sold more than $10,000 worth of agriculture products.
#     Assign that logical vector to the variable agricultureLogical. 
#     Apply the which() function like this to identify the rows of the 
#           data frame where the logical vector is TRUE. which(agricultureLogical) 
#     What are the first 3 values that result?

q1url  <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
q1file <- "./quizes/data/ss06hid.csv"
if( !file.exists(q1file) ) {
  download.file(q1url, q1file)  
}

q1data <- read.csv2(
  file   = q1file,
  header = TRUE,
  sep    = ","
)
# ACR = 3 |  House on ten or more acres
# AGS = 6 |  $10,000+ 


agricultureLogical <- !is.na(q1data$ACR) & !is.na(q1data$AGS) & q1data$ACR == 3 & q1data$AGS==6
which(agricultureLogical) = # 125  238  262 ...
  
  
  
  
# Q2 -  Use the parameter native=TRUE. What are the 30th and 80th quantiles of the resulting data? 
#       (some Linux systems may produce an answer 638 different for the 30th quantile)
require(jpeg)
q2url  <- "https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg"
q2file <- "./quizes/data/jeff.jpg"
if( !file.exists(q2file) ) {
  download.file(q2url, q2file, method="curl")  
}
q2data <- jpeg::readJPEG(q2file,native=TRUE)
quantile(q2data,c(0.3,0.8))
#       30%       80% 
# -15259150 -10575416 




# Q3 -  Match the data based on the country shortcode. 
#       How many of the IDs match? 
#       Sort the data frame in descending order by GDP rank (so United States is last). 
#       What is the 13th country in the resulting data frame? 
q3GdpUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
q3EduUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
q3GdpFile <- "./quizes/data/GDP.csv"
q3EduFile <- "./quizes/data/EDSTATS_Country.csv"

if( !file.exists(q3GdpFile) ) { download.file(q3GdpUrl,q3GdpFile, method="wget"); }
if( !file.exists(q3EduFile) ) { download.file(q3EduUrl,q3EduFile, method="wget"); }

q3GdpData <- read.csv2(q3GdpFile, skip=4, sep=",", strip.white=TRUE, skipNul=TRUE, nrows=232)[,c(1,2,4,5)]
names(q3GdpData) <- c("CountryCode","Rank","Name","GDP")
q3GdpData$GDP <- as.numeric(gsub(",","", as.character(q3GdpData$GDP)))
q3GdpCodes <- factor(q3GdpData$CountryCode)

q3EduData  <- read.csv2(q3EduFile, header=TRUE, sep=",", strip.white=TRUE, blank.lines.skip=TRUE)
q3EduCodes <- factor(q3EduData$CountryCode)
names(q3EduData)

length(q3GdpCodes) # = 232
length(q3EduCodes) # = 234 
length(q3GdpCodes %in% q3EduCodes) # = 232
length(q3EduCodes %in% q3GdpCodes) # = 234

length(intersect(q3GdpCodes,q3EduCodes)) # = 224

q3joined <- merge(q3EduData, q3GdpData, by="CountryCode")
q3joined <- q3joined[ order(q3joined$GDP, na.last=TRUE), ]
q3joined[13,]$Name # = St. Kitts and Nevis
q3joined[13,]$Rank # = 178
q3joined[13,] # = St. Kitts and Nevis


# Q4 - What is the average GDP ranking for the "High income: OECD" and "High income: nonOECD" group? 

lapply(
  split(q3joined, q3joined$Income.Group),
  function(x) { mean(x$Rank,na.rm=T) }
)
# $`High income: nonOECD`
# [1] 91.91304
# 
# $`High income: OECD`
# [1] 32.96667


# Q5 - Cut the GDP ranking into 5 separate quantile groups. 
#      Make a table versus Income.Group. 
#      How many countries are Lower middle income 
#          but among the 38 nations with highest GDP?
q <- quantile(q3joined$GDP,na.rm=T)
q3joined$Quantile <- "0%"
q3joined <- q3joined[,c("Name","GDP","Income.Group","Rank","Quantile")]
for(name in names(q)) {
  q3joined[which(q3joined$GDP >= q[name]),][,"Quantile"] <- name
}
which(q3joined$Quantile == "50%" & !is.na(q3joined$Rank) & q3joined$Rank <= 38) # count = 1


# Week 4 - Q2  Remove the commas from the GDP numbers in millions of dollars and average them. What is the average? 
w4q2countries <- q3joined[!is.na(q3joined$Rank),]
mean(w4q2countries$GDP)

countryNames <- w4q2countries$Name;
countryNames[5] <- ""
countryNames[91] <- ""
grep("^United", countryNames) # = 158 184 189 (length: 3)


# Week 4 - Q4
w4q4joined <- merge(q3EduData, q3GdpData, by="CountryCode")
w4q4joined <- w4q4joined[ order(q3joined$GDP, na.last=TRUE), ]
names(w4q4joined)

length(w4q4joined[ grep( "Fiscal year end: June", w4q4joined$Special.Notes), ]$Special.Notes) # = 13


