# Samsung accelerometer and gyroscope data

The raw data was obtained from the following link:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The task was to combine the training and test datasets, assign descriptive names for the 
activities, extract the mean and standard deviation for each measure, and assign descriptive 
names for the variables. Finally, the data was summarized to get the average of the mean 
and SD for each activity for each subject.

* All files containg activity variables, subject identifiers, variable names, and the
  data values were loaded separately. 
* The activities were recoded from numbers to descriptive names using the recode function 
  from the dplyr package.
* The column names were cleaned using regex functions from the strinr package.
* The acitivty table, subject table, and the datavalues were combined using cbind.
* The columns containing the mean and standard deviations were extracted using the select
  function from dplyr with the argument "matches" to search for "mean" or "std".
* The training and test data sets were joined using rbind. 
* The average of the mean and SD values were averaged for each activity for each subject by 
  grouping and summarising using dplyr functions. 
* The tidy data is saved to a csv file named tidyWearableData.txt.

## Variables
The dimensions of the dataframe is 180 rows and 88 columns. 

* subject - ID of each subject participating in the study. Range 1 to 30.
* activity - the activity performed by each subject (walking, walking upstairs, walking downstairs, sitting, standing, laying).

The remainig variables are named in the following manner: 
* "time" or "frequency" - denotes that the data are in the the time domain or frequency domain
* "Body" or "Gravity" - denotes body or gravity signals
* "Acellerometer" - data from the phones accelerometer
* "Gyroscope" - data from the phones gyroscope
* "Jerk" - indicates jerk of the body by the accelerometer or gyroscope
* "X, Y, Z" - denotes three-axial signals
* "Magnitude" - Magnitude of the three-dimensional signgals calculated using the Eucledean norm
* "mean" - denotes the mean value
* "std" - denotes standard deviation
