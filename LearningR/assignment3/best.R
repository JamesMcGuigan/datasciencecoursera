rawdata <- read.csv("./data/outcome-of-care-measures.csv", colClasses = "character")
names(rawdata);

state <- "NN" 
outcome <- "pneumonia"

best <- function(state, outcome) { 
  # print(c(state, outcome))
  
  name     <- paste("^Hospital.30.Day.Death.*",gsub(" ",".",outcome),sep=""); name
  colnames <- grep(name, names(rawdata), ignore.case=T); colnames # 11, 17, 23
  
  # filter by state
  statedata <- subset(rawdata, State == state); head(data)
  data      <- statedata[c(colnames,7,2)];          head(data);
  deaths    <- statedata[c(colnames)];              head(deaths);
  
  if( length(colnames) == 0 ) { stop("invalid outcome") }
  if( nrow(statedata)  == 0 ) { stop("invalid state")   }
  
  if( nrow(statedata) > 0 & length(colnames) > 0 ) {
    data$deaths <- sapply( 1:nrow(deaths), function(n) { sum(as.numeric(deaths[n,]), na.rm=T); } )  
    data        <- subset(data, deaths != 0);
    data        <- data[order(data$Hospital.Name),]; 
    data        <- data[order(data$deaths),]; 
  }
  
  # return name
  data[1,"Hospital.Name"]
}