Code Book
=========
Describes the variables, data, and any transformations or work performed to clean up the data.

####Data Introduction

Contains data collected from experiments that have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities while wearing a smartphone (Samsung Galaxy S II) on the waist. Data captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. Experiments were video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 


####Data Files and Content

* `features_info.txt`: Shows information about the variables used on the feature vector.
* `features.txt`: List of all features. Used for the column labels.
* `activity_labels.txt`: Links the class labels with their activity name. Contains the text values of the activity paired with their key value.
* `X_train.txt and X_test.txt`: Train and Test participants data set.
* `y_train.txt and y_test.txt`: Contains the key values of the activity for the Train and Test data set.
* `subject_train.txt and subject_test.txt`: Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

####Variables

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

####Script Data Transformation Procedures

**Load Necessary Files**
The following files are the raw data sets for train and test participants, the activity keys for both sets, the feature data (column labels) and activity text values.
`````
train_data <- read.table("./UCI HAR Dataset/train/X_train.txt")
test_data <- read.table("./UCI HAR Dataset/test/X_test.txt")
train_activity_keys <- read.table("./UCI HAR Dataset/train/y_train.txt")
test_activity_keys <- read.table("./UCI HAR Dataset/test/y_test.txt")
train_subject_keys <- read.table("./UCI HAR Dataset/train/subject_train.txt")
test_subject_keys <- read.table("./UCI HAR Dataset/test/subject_test.txt")
features <- read.table("./UCI HAR Dataset/features.txt")[,2]
activities <- read.table("./UCI HAR Dataset/activity_labels.txt")
`````

**Add Column Names**

Using the feature file we hadd the column names
`````
names(train_data) <- features
names(test_data) <- features
`````

**Extract Columns**

We then extract columns that contains either a mean or std dev in the name
`````
mean_stddev_features <- grepl("mean|std", features)
train_data <- train_data[, mean_stddev_features]
test_data <- test_data[, mean_stddev_features]
`````

**Add column names and combine data**

We then add the subject and acitivity column names and combine the data
`````
names(train_subject_keys) <- "subject"
names(test_subject_keys) <- "subject"
names(train_activity_keys) <- "activity"
names(test_activity_keys) <- "activity"

train_data <- cbind(train_subject_keys, train_activity_keys, train_data)
test_data <- cbind(test_subject_keys, test_activity_keys, test_data)
total_data <- rbind(train_data, test_data)
`````

**Replace values and create average for subject and activity**

Lastly, we replace the activity key values with the text value and calculate the average across subject and activity.
`````
total_data$activity <- factor(total_data$activity, levels=activities$V1, labels=activities$V2)
melt_data <- melt(total_data, id=c("subject", "activity"))
tidy_data <- dcast(melt_data, subject+activity ~ variable, mean)
`````




