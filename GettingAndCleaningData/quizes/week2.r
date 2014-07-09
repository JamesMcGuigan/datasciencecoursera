# Question 1
# Register an application with the Github API here https://github.com/settings/applications. 
# Access the API to get information on your instructors repositories 
# (hint: this is the url you want "https://api.github.com/users/jtleek/repos"). 
# Use this data to find the time that the datasharing repo was created. 
# What time was it created? This tutorial may be useful 
# (https://github.com/hadley/httr/blob/master/demo/oauth2-github.r). 
# You may also need to run the code in the base R package and not R studio. 


# https://github.com/settings/applications/113398
require(httr)
require(jsonlite)

githubClientID     <- "1e4191100990a51fec89"
githubClientSecret <- "f8910bdcf4979fd4a3b80cbd77f8512c11f92a90"

app <- oauth_app("github", key=githubClientID, secret=githubClientSecret)
sig <- sign_oauth1.0(app)

q1url  <- "https://api.github.com/users/jtleek/repos"
q1raw  <- GET(q1url);
q1json <- jsonlite::fromJSON(toJSON(content(q1raw)))
summary(content(GET(q1url)))

q1filtered <- q1json[ q1json[,"name"]=="datasharing", c("name","created_at")]
q1filtered 
#          name           created_at
# 5 datasharing 2013-11-07T13:25:07Z




# Q2 -  Which of the following commands will select only the data for the probability weights pwgtp1 with ages less than 50?
require(sqldf)
require(httr)
library(RCurl)
acs <- content(GET("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"));


# Q4 - How many characters are in the 10th, 20th, 30th and 100th lines of HTML from this page: 
q4url   <- "http://biostat.jhsph.edu/~jleek/contact.html"
q4lines <- readLines(q4url)
nchar(q4lines[10]) # = 45
nchar(q4lines[20]) # = 31
nchar(q4lines[30]) # = 7
nchar(q4lines[100]) # = 25


# Q5 -  Read this data set into R and report the sum of the numbers in the fourth column. 
q5url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for"
q5file <- './quizes/data/wksst8110.for'
if( !file.exists(q5file) ) { 
  download.file(q5url, q5file, method='wget'); 
}

read.fwf(q5file,c(16,13,13,13,13),skip=4,header=T)
q5data  <- read.fwf(q5file,c(16,29-16,42-29,55-42,63-55),skip=4,header=T)
q5lines <- readLines(q5file,n=4)

q5data <- read.fwf(
  file=q5file,
  skip=4,
  widths=c(12, 7,4, 9,4, 9,4, 9,4))
sum(as.numeric(unlist(q5data[4]))) # = 32426.7
