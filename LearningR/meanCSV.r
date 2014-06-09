mydata = read.csv("/Users/jamie/Dropbox/Programming/Coursera/datasciencecoursera/LearningR/hw1_data.csv");

solarR = mydata$Solar.R[mydata$Temp > 90 & mydata$Ozone > 31];
solarR = solarR[!is.na(solarR)]
Q18 = mean(solarR)
Q18

Q19 = mean(mydata$Temp[mydata$Month == 6])
Q19