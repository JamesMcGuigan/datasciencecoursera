outcome <- read.csv("./data/outcome-of-care-measures.csv", colClasses = "character")
outcome[, 11] <- as.numeric(outcome[, 11])


col <- 2; outcome[,col]; names(outcome)[col]; 
outcome[, col] <- as.numeric(outcome[, col]); hist(outcome[,col]); outcome[,col];
