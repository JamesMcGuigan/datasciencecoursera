setwd("/Users/jamie/Dropbox/Programming/Coursera/datasciencecoursera/LearningR/assignment1/");
source("complete.R")
directory <- "specdata";

corr <- function(directory, threshold = 0) {
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  
  ## 'threshold' is a numeric vector of length 1 indicating the
  ## number of completely observed observations (on all
  ## variables) required to compute the correlation between
  ## nitrate and sulfate; the default is 0
  
  ## Return a numeric vector of correlations
  
  nobs <- complete(directory); nobs;
  id   <- nobs[nobs["nobs"] >= threshold,][,"id"]; id
  
  if( length(id) > 0 ) {
    files        <- paste(directory,"/",sprintf("%03d",id),".csv", sep=""); files
    rawdata      <- lapply(files, read.csv); rawdata
    cleandata    <- lapply(rawdata,   function(frame){ subset(frame, !is.na(frame["sulfate"]) & !is.na(frame["nitrate"])  ); }); cleandata
    corrilations <- unlist(lapply(cleandata, function(frame){ cor(frame["sulfate"],frame["nitrate"]) })); corrilations
    corrilations[!is.na(corrilations)]  
  } else {
    c()
  }
  
}
#corr("specdata");
#summary(corr("specdata"))
