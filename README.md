Getting and Cleaning Data Project
=================================

**Project Objectives**

The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis.

**Data**

Full Description: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Project Data: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

**Data Transformations**

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each        variable for each activity and each subject.

**Steps to use program**

1. Download the `UCI HAR Dataset` folder. This folder contains the necessary files that are needed to run the program succesfully.
2. Ensure you have the `reshape2` and `data.table` packages installed. 
3. Set your working directory to be the same location as the `UCI HAR Dataset` folder.
4. You can then run the program and find the output located in a file titled `tidyData.txt`.