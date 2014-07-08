rawdata <- read.csv("./data/outcome-of-care-measures.csv", colClasses = "character")
names(rawdata);


rankall <- function(outcome, num = "best") { 
  print(outcome)
  print(num)
  
  name      <- paste("^Hospital.30.Day.Death.*",gsub(" ",".",outcome),sep=""); name
  colnames  <- grep(name, names(rawdata), ignore.case=T); colnames # 11, 17, 23
  
  # filter by state
  data      <- rawdata
  data$Rate <- as.numeric(data[,colnames]);      head(data)
  data      <- subset(data, !is.na(Rate));       head(data)
  data      <- data[order(data$Hospital.Name),]; head(data)
  
  if( length(colnames) == 0 ) { stop("invalid outcome") }
  if( nrow(data)       == 0 ) { stop("invalid state")   }
  
  output <- lapply( unique(rawdata$State), function(state) {
    statedata <- subset(data, State == state);      head(statedata)
    statedata <- statedata[order(statedata$Rate),]; head(statedata)
    statedata$Rank <- 1:nrow(statedata);            head(statedata)

    #print(head(statedata[,c("Hospital.Name","Rate","Rank")]))
    #print(tail(statedata[,c("Hospital.Name","Rate","Rank")]))
    
    rownum = num
    if( num == "best"    ) { rownum = 1; }
    if( num == "worst"   ) { rownum = nrow(statedata); }
    
    selected <- statedata[rownum,  c("Hospital.Name","State")];
    names(selected) <- c("hospital","state");
    selected
  });
  do.call("rbind", output)
}

#outcome <- "heart attack"
#num     <- "worst"
#head(rankall("heart attack", 4))

