= Getting and Cleaning Data - Project =
[https://class.coursera.org/getdata-005/human_grading/view/courses/972582/assessments/3/submissions]

== File Structure ==
- run_analysis.R    | main script
- data.mean.sd.csv  | 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
- data.avg.csv      | 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

== Description ==
- run_analysis.R will download and extract the "UCI HAR Dataset.zip" 
- the dataset contains "/test" and "/train" directories, which will be merged into "/merged"
- downloaded files contain a list of individual readings from various instruments
- data.mean.sd.csv - contains a table of the mean and standard deviation for each of the readings
- data.avg.csv     - contains a table with the averages of each of the activites

== Code Table ==
"body.acc"  - The average body acceleration signal obtained by subtracting the gravity from the total acceleration. 
"body.gyro" - The average angular velocity vector measured by the gyroscope for each window sample. The units are radians/second. 
"total.acc" - The average acceleration signal from the smartphone accelerometer XYZ axis in standard gravity units 'g'.
