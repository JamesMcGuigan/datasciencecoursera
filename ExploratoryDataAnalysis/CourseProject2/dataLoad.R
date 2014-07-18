set.seed(1234)
if( !exists("data.cache") ) { data.cache <- list(); }

data.download <- function() {
  zipurl  <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
  zipfile <- "FNEI_data.zip"
  
  if( !file.exists(zipfile) ) { 
    download.file(zipurl, zipfile, method="wget") 
    unzip(zipfile)
  }
  unzip(zipfile,list=TRUE)  
}

data.load.summary <- function(n=-1) {
  data.download()
  if( is.null(data.cache[["data.load.summary"]]) ) {
    print("readRDS: summarySCC_PM25.rds")
    data.cache[["data.load.summary"]] <<- readRDS("summarySCC_PM25.rds")
  }
  if( n > 0 ) {
    data <- data.cache[["data.load.summary"]];
    data[sample(nrow(data),n),]
  } else {
    data.cache[["data.load.summary"]]  
  }  
}

data.load.classification <- function(n=-1) {
  data.download()
  if( is.null(data.cache[["data.load.classification"]]) ) {
    print("readRDS: Source_Classification_Code.rds")
    data.cache[["data.load.classification"]] <<- readRDS("Source_Classification_Code.rds")
  }
  if( n > 0 ) {
    data <- data.cache[["data.load.classification"]];
    data[ sample(nrow(data),n), ]
  } else {
    data.cache[["data.load.classification"]]  
  }
}

data.load.test <- function() {
  for( i in 1:5 ) {
    print(system.time({
      data.load.classification()
      data.load.summary()
    }))
    print( names(data.cache) )
  }
}
#data.load.test()

