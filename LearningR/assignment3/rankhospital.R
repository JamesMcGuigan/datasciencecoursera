rawdata <- read.csv("./data/outcome-of-care-measures.csv", colClasses = "character")
#rawdata[,"Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure"] <- as.numeric(rawdata[,"Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure"])
names(rawdata);


rankhospital <- function(state, outcome, num = "best") { 
  print(state)
  print(outcome)
  print(num)
  name      <- paste("^Hospital.30.Day.Death.*",gsub(" ",".",outcome),sep=""); name
  colnames  <- grep(name, names(rawdata), ignore.case=T); colnames # 11, 17, 23
  
  # filter by state
  data     <- subset(rawdata, State == state); head(data)

  if( length(colnames) == 0 ) { stop("invalid outcome") }
  if( nrow(data)       == 0 ) { stop("invalid state")   }
  
  data$Rate <- as.numeric(data[,colnames]);      head(data)
  data      <- data[order(data$Hospital.Name),]; head(data)
  data      <- data[order(data$Rate),];          head(data)
  data      <- subset(data, !is.na(Rate));       head(data)
  data$Rank <- 1:nrow(data);                     head(data)
  
  if( num == "best"    ) { num <- 1; }
  if( num == "worst"   ) { num <- nrow(data); }
  if( num > nrow(data) ) { return(NA); }
  print(head(data[,c("Hospital.Name","Rate","Rank")]))
  print(tail(data[,c("Hospital.Name","Rate","Rank")]))
  
  data[num,"Hospital.Name"]
}

#rankhospital("NC", "heart attack", "worst")

# state   <- "MD" 
# outcome <- "heart attack"
# num     <- "worst"
# 
# rankhospital("TX", "heart failure")
# rankhospital("TX", "heart failure", 4)
# rankhospital("MD", "heart attack", "worst")
# rankhospital("MN", "heart attack", 5000)
