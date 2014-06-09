setwd("/Users/jamie/Dropbox/Programming/Coursera/datasciencecoursera/LearningR/assignment1/");
directory <- "specdata";

complete <- function(directory, id = 1:332) {
  ## Return a data frame of the form:
  ## id nobs
  ## 1  117
  ## 2  1041
  ## ...
  ## where 'id' is the monitor ID number and 'nobs' is the
  ## number of complete cases
  
  files     <- paste(directory,"/",sprintf("%03d",id),".csv", sep=""); files
  rawdata   <- lapply(files, read.csv); rawdata
  nobs      <- unlist(lapply(rawdata, function(frame){ dim(subset(frame, !is.na(frame["sulfate"]) & !is.na(frame["nitrate"])))[1]; }))
  data.frame(id=id, nobs=nobs)
}
#complete(directory)