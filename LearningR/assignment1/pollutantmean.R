setwd("/Users/jamie/Dropbox/Programming/Coursera/datasciencecoursera/LearningR/assignment1/");
directory <- "specdata";

pollutantmean <- function(directory, pollutant, id = 1:332) {
  ## 'pollutant' is a character vector of length 1 indicating
  ## the name of the pollutant for which we will calculate the
  ## mean; either "sulfate" or "nitrate".
  
  ## Return the mean of the pollutant across all monitors list
  ## in the 'id' vector (ignoring NA values)
  
  files     <- paste(directory,"/",sprintf("%03d",id),".csv", sep=""); files
  rawdata   <- lapply(files, read.csv); rawdata
  joindata  <- do.call(rbind, rawdata); joindata
  validdata <- subset(joindata, !is.na(joindata[pollutant])  ); validdata
  coldata   <- validdata[,pollutant]; coldata
  reading   <- mean(coldata)
  reading
}
#pollutantmean(directory, "sulfate");
#pollutantmean(directory, "nitrate");