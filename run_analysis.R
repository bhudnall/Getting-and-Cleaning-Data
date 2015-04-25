# run_analysis.R does the following:
# 1. Merge the training and the test sets to create one data set.
# 2. Extract only the measurements on the mean and standard deviation for each measurement. 
# 3. Use descriptive activity names to name the activities in the data set.
# 4. Appropriately label the data set with descriptive variable names. 
# 5. Create a second, independent tidy data set with the average of each variable for each 
# activity and each subject.

library(reshape2)
library(data.table)

# Load the data files - these files contains the coordinates and raw data
train_data <- read.table("./UCI HAR Dataset/train/X_train.txt")
test_data <- read.table("./UCI HAR Dataset/test/X_test.txt")

# Load the activity key for the data files - identifies the activity performed
train_activity_keys <- read.table("./UCI HAR Dataset/train/y_train.txt")
test_activity_keys <- read.table("./UCI HAR Dataset/test/y_test.txt")

# Load the subject keys (rows) - identifies the subject performing the activities
train_subject_keys <- read.table("./UCI HAR Dataset/train/subject_train.txt")
test_subject_keys <- read.table("./UCI HAR Dataset/test/subject_test.txt")

# Load the features (column) and acitivity labels
features <- read.table("./UCI HAR Dataset/features.txt")[,2]
activities <- read.table("./UCI HAR Dataset/activity_labels.txt")

# Add the column names to the raw data. (OBJECTIVE #4)
names(train_data) <- features
names(test_data) <- features

# Extract measurements of the mean and standard dev. (OBJECTIVE #2)
mean_stddev_features <- grepl("mean|std", features)
train_data <- train_data[, mean_stddev_features]
test_data <- test_data[, mean_stddev_features]

# Add column names to subject and activity files.
names(train_subject_keys) <- "subject"
names(test_subject_keys) <- "subject"
names(train_activity_keys) <- "activity"
names(test_activity_keys) <- "activity"

# Combine the data files to form one complete data set. (OBJECTIVE #1)
train_data <- cbind(train_subject_keys, train_activity_keys, train_data)
test_data <- cbind(test_subject_keys, test_activity_keys, test_data)
total_data <- rbind(train_data, test_data)

# Use descriptive activity names to name the activities (OBJECTIVE #3)
total_data$activity <- factor(total_data$activity, levels=activities$V1, labels=activities$V2)

# Create second data set, with average from each subject, activity and variable. (OBJECTIVE #5)
melt_data <- melt(total_data, id=c("subject", "activity"))
tidy_data <- dcast(melt_data, subject+activity ~ variable, mean)

# Create Tiny Data file
write.table(tidy_data, file = "./tidyData.txt", row.names=FALSE)
