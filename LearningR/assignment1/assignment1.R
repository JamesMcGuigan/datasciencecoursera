directory <- "/Users/jamie/Dropbox/Programming/Coursera/datasciencecoursera/LearningR/assignment1/specdata";
threshold <- 100

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
pollutantmean(directory, "sulfate");
pollutantmean(directory, "nitrate")

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
complete(directory)


corr <- function(directory, threshold = 0) {
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  
  ## 'threshold' is a numeric vector of length 1 indicating the
  ## number of completely observed observations (on all
  ## variables) required to compute the correlation between
  ## nitrate and sulfate; the default is 0
  
  ## Return a numeric vector of correlations
  
  nobs <- complete(directory); nobs;
  id <- nobs[nobs["nobs"] >= threshold,][,"id"]; id
  
  files        <- paste(directory,"/",sprintf("%03d",id),".csv", sep=""); files
  rawdata      <- lapply(files, read.csv); rawdata
  cleandata    <- lapply(rawdata,   function(frame){ subset(frame, !is.na(frame["sulfate"]) & !is.na(frame["nitrate"])  ); }); cleandata
  corrilations <- unlist(lapply(cleandata, function(frame){ cor(frame["sulfate"],frame["nitrate"]) })); corrilations
}
corr(directory,1000)
