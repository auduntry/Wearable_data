# This is an R script created as the course project for the Getting 
# and Cleaning Data Course by John Hopkins University on Coursera.

# The script tidies data collected by the accelerometers on a Samsung 
# Galaxy S smartphone from 30 different subjects. The original data
# was split into a training set (70%) and a test set (30%). This 
# script will combine the test and training set and extract the 
# mean and standard deviations of all measurements. Finally, the 
# means and SDs will be averaged and stored as a new data file. 


### Important! ###
# Set the working directory to the unzipped "UCI HAR Dataset" folder. 

library(dplyr)
library(stringr)

# Each participant in the study has their own ID. For the training 
# set and the test set the subject ID is found in the files 
# subject_train.txt and subject_test.txt, respectively. 

# Read in the subject files using read.table()
subject_train <- read.table("./train/subject_train.txt", col.names = "subject")
subject_test <- read.table("./test/subject_test.txt", col.names = "subject")

# The subjects performed six different activities that have been
# labeled with number 1 to 6 in the dataset.
# The activity lables for the training and test data sets
# are located in the files y_train.txt and y_test.txt, respectively. 

# Read in the activity lables using read.table()
activity_train <- as_tibble(read.table("./train/y_train.txt", col.names = "activity"))
activity_test <- as_tibble(read.table("./test/y_test.txt", col.names = "activity"))

# recode the activity numbers to descriptive names
activity_train <- activity_train %>% mutate(activity = recode(
  activity, "1" = "walking", "2" = "walking_upstairs", "3" = "walking_downstairs", "4" = "sitting", "5" = "standing", "6" = "laying"))

activity_test <- activity_test %>% mutate(activity = recode(
  activity, "1" = "walking", "2" = "walking_upstairs", "3" = "walking_downstairs", "4" = "sitting", "5" = "standing", "6" = "laying"))

# Each column in the dataset (561 columns) contains data on a feature
# from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ 
# and tGyro-XYZ. We are interested in selecting the columns containig
# the mean and standard deviation of each feature. The full feature list
# (i.e. the colulmn names) is located in the file features.txt.

# Read in the features using readLines()
# Use regular expressions for splitting the column number from the 
# lecture about editing text variables.
column_names <- strsplit(readLines("./features.txt"), " ")

# extract the second element, which contain the feature name.
secondElement <- function(x){x[2]}
column_names <- sapply(column_names, secondElement)

# Make the variable names more descriptive by spelling out abbreviations. 
column_names <- column_names %>% 
  str_replace_all("-(std|mean)\\(\\)-(.)", "_\\1_\\2") %>% #remove "()" for all mean and std values of all axis
  str_replace_all("-(std|mean)\\(\\)", "_\\1") %>% # same as above for non-axis
  str_replace_all("BodyBody", "Body") %>% #remove the occurence of 'BodyBody'
  str_replace_all("Acc", "Accelerometer") %>% # making the abbreviations more descriptive
  str_replace_all("Mag", "Magnitude") %>%
  str_replace_all("^t", "time_") %>%
  str_replace_all("^f", "frequency_")

# The data for the training and test sets are located in the
# files X_train.txt and X_test.txt, respectively.

#Read in the data using read.table()
data_train <- read.table("./train/X_train.txt", col.names = column_names)
data_test <- read.table("./test/X_test.txt", col.names = column_names)

# Now we start to merge all the elements of the dataframe
subjecActivity_train <- cbind(subject_train, activity_train)
subjectActivity_test <- cbind(subject_test, activity_test)

final_train <- as_tibble(cbind(subjecActivity_train, select(data_train, matches("mean|std"))))
final_test <- as_tibble(cbind(subjectActivity_test, select(data_test, matches("mean|std"))))

# combine the train and test datasets and select all columns
# containing mean OR std
dfTotal <- rbind(final_test, final_train)

# Group and summarise all variables for each subject and each activity
dfSumarised <- dfTotal %>%
  group_by(subject) %>%
  group_by(activity, add = TRUE) %>%
  summarise_all(funs(mean))

# save the summarized data to a new fileS
write.table(dfSumarised, file = "tidyWearableData.txt", row.names = FALSE)
