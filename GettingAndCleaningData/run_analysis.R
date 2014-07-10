# Getting and Cleaning Data Course Project
# @author James McGuigan
#
# You should create one R script called run_analysis.R that does the following. 
#
# Merges the training and the test sets to create one data set.
# Extracts only the measurements on the mean and standard deviation for each measurement. 
# Uses descriptive activity names to name the activities in the data set
# Appropriately labels the data set with descriptive variable names. 
# Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

# Config Variables
debug       <- TRUE
n           <- -1
basedir     <- paste(getwd(), "UCI HAR Dataset", sep="/"); basedir
inputdirs   <- sapply( c("test","train"), function(dir) { paste(basedir, dir, sep="/") }); inputdirs
outputdir   <- sapply( c("merged"),       function(dir) { paste(basedir, dir, sep="/") }); inputdirs
zipurl      <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
zipfile     <- "./UCI HAR Dataset.zip"

data.avg.file     <- "data.avg.csv"
data.mean.sd.file <- "data.mean.sd.csv"


# Run Program
main <- function() {
  # Merges the training and the test sets to create one data set.
  download.zipfile()
  if( !file.exists(outputdir) ) {
    merge.dirs(inputdirs=inputdirs, outputdir=outputdir)  
  }
  mergedfiles <- list.files.absolute(outputdir, recursive=TRUE); mergedfiles
  
  # Testing Variables - TODO Remove
  # file <- mergedfiles[1]; file
  
  # Extracts only the measurements on the mean and standard deviation for each measurement. 
  # Uses descriptive activity names to name the activities in the data set
  # Appropriately labels the data set with descriptive variable names.
  data.mean.sd <- extract.summary(mergedfiles,n=n)
  write.csv2(data.mean.sd, data.mean.sd.file)
  head(readLines(data.mean.sd.file))
    
  
  # Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
  data.avg <- sapply( c("[Xy]","body.acc","body.gyro","total.acc"), function(label) {
    mean( data.mean.sd[ grep(paste("^",label,".*\\.mean$",sep=""), rownames(data.mean.sd)), ] )
  })
  colnames(data.avg) <- c("value")
  write.csv(data.avg, data.avg.file)
  head(readLines(data.avg.file))
  
  list(data.mean.sd, data.avg)
}

# Returns a pretty string label based on the filename, with optional extension
# @param file - path string
# @param ext  - optional string to return string, seperated by .
# @return     - string
extract.label <- function(file, ext=NULL) {
  label <- gsub(     "\\bacc\\b", "acc", 
            gsub(   "_", ".", 
              gsub( "_?merged|\\.\\w+$", "", 
                basename(file)
            )))
  
  if( !is.null(ext) ) {
    label <- paste(label, ext, sep=".")
  }
  return(label)
}

# Extracts the mean and sd of one-dimentional mergedfiles 
# @param mergedfiles - vector of filenames
# @param n = -1      - debug flag: only read first n lines of files (speedup)
# @return            - data.frame
extract.summary <- function(mergedfiles,n=-1) {
  data <- unlist( lapply( mergedfiles, function(file) {
    if(debug) { print(paste("extract.summary", file, n)); }
    vars <- as.numeric( unlist( strsplit( readLines(file,n=n), " +") ) )
    vars <- vars[!is.na(vars)]
    
    cols <- data.frame( mean(vars, na.rm=TRUE), sd(vars, na.rm=TRUE) )
    names(cols) <- c( extract.label(file,"mean"), extract.label(file,"sd") )
    cols
  }))
  frame <- data.frame(cbind(data))
  colnames(frame) <- c("value")
  frame
}

download.zipfile <- function() {
  # Download and unzip data
  if( !file.exists(zipfile) ) {
    download.file(zipurl,zipfile, method="wget")  
    unzip(zipfile)
  }  
  zipfile
}

# Merges the training and the test sets to create a single data set.
# TODO: file renaming is hardcoded to s/test|train/merged/g
# @param inputdirs - list of directories to input
# @param outputdir - directory to create/delete and to merge contents into
# @return          - list of merged files 
merge.dirs <- function(inputdirs=inputdirs, outputdir=outputdir) {
  # Delete Existing Merge Data
  unlink( outputdir, recursive=TRUE, force=TRUE )
  dir.create(outputdir);
  print(paste("unlink + dir.create: ", outputdir ))

  filenames <- list.files.absolute(inputdirs, recursive=TRUE)
  sapply( filenames, function(inputfile) {
    outputfile <- gsub( '(test|train)\\b', "merged", inputfile, perl=TRUE ); # Nasty hardcoding

    if( !file.exists(dirname(outputfile)) ) {
      dir.create(dirname(outputfile))  
      if(debug) { print(paste("dir.create: ", dirname(outputfile))) }
    }
    
    if( !file.exists(inputfile) ) {
      print(paste("!file.exists: ", inputfile))
    } else {
      if( !file.exists(outputfile) ) { 
        # File Doesn't Exists - Copy Original
        if(debug) { print(paste("file.copy: ", outputfile)) }

        file.copy(inputfile, outputfile)
      } else {
        # File Exists - Merge Copy
        if(debug) { print(paste("write: ", outputfile)) }
        
        outputhandle <- file(outputfile,"a")
        write(readLines(inputfile), outputhandle)
        close(outputhandle)        
      }    
    }
  });
  list.files.absolute(outputdir,recursive=TRUE)
}


# Returns a list of absolute filenames included within the directory tree
list.files.absolute <- function(path=".", include.dirs=FALSE, recursive=TRUE, ...) {
  sapply(path, function(dir) {
    paste(dir, list.files(dir, include.dirs=include.dirs, recursive=recursive, ...), sep="/" )
  });  
}

main()
