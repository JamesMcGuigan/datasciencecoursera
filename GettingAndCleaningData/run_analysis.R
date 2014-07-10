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
basedir     <- paste(getwd(), "UCI HAR Dataset", sep="/"); basedir
inputdirs   <- sapply( c("test","train"), function(dir) { paste(basedir, dir, sep="/") }); inputdirs
outputdir   <- sapply( c("merged"),       function(dir) { paste(basedir, dir, sep="/") }); inputdirs
zipurl      <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
zipfile     <- "./UCI HAR Dataset.zip"


main <- function() {
  # Merges the training and the test sets to create one data set.
  download.zipfile()
  mergedirs(inputdirs=inputdirs, outputdir=outputdir)
  mergedfiles <- list.files.absolute(inputdirs); mergedfiles
  
  # Extracts only the measurements on the mean and standard deviation for each measurement. 
  # Uses descriptive activity names to name the activities in the data set
  # Appropriately labels the data set with descriptive variable names. 
  # Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
}

extract.summary(inputfiles) {
  
}


download.zipfile < function() {
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
mergedirs <- function(inputdirs=inputdirs, outputdir=outputdir) {
  # Delete Existing Merge Data
  unlink( outputdir, recursive=TRUE, force=TRUE )
  dir.create(outputdir);
  print(paste("unlink + dir.create: ", outputdir ))

  filenames <- list.files.absolute(inputdirs)
  sapply( filenames, function(inputfile) {
    outputfile <- gsub( '(test|train)\\b', "merged", inputfile, perl=TRUE ); # Nasty hardcoding

    if( !file.exists(dirname(outputfile)) ) {
      dir.create(dirname(outputfile))  
      print(paste("dir.create: ", dirname(outputfile)))
    }
    
    if( !file.exists(inputfile) ) {
      print(paste("!file.exists: ", inputfile))
    } else {
      if( !file.exists(outputfile) ) { 
        # File Doesn't Exists - Copy Original
        print(paste("file.copy: ", outputfile))

        file.copy(inputfile, outputfile)
      } else {
        # File Exists - Merge Copy
        print(paste("write: ", outputfile))
        
        outputhandle <- file(outputfile,"a")
        write(readLines(inputfile), outputhandle)
        close(outputhandle)        
      }    
    }
  });
  list.files.absolute(outputdir)
}


# Helper Functions
list.files.absolute <- function(path=".", include.dirs=FALSE, recursive=TRUE, ...) {
  sapply(path, function(dir) {
    paste(dir, list.files(dir, include.dirs=include.dirs, recursive=recursive, ...), sep="/" )
  });  
}


# Run Program
main()
