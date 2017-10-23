# Wearable Data Repocitory
This repo contain my submission to the Peer-graded Assignment: Getting and Cleaning Data Course Project (Coursera). 

## run_analysis.R
This R-script imports the data collected by the accelerometers on a Samsung Galaxy S smartphone from 30 different subjects. 
The data can be downloaded from here:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

A full description of the data can be found at the following link:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The run_analysis.R script takes the unzipped data as input and combines the trainig data set and the test data set into one data frame. The activity lables (1-6) is recoded to descriptive names. The variable names are described in the wearable_codebook.md.

Finally, the run_analysis.R finds the average of all variables for each subject and each activity and. The summarized data can be found in the tidyWearableData.txt file. 
