---
title: "CodeBook.md"
author: "Daniel Dugan"
date: "Thursday, July 24, 2014"
output: html_document
---
The site where the data was obtained:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The data for the project:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The original data set

The original data set is split into training and test sets (70% and 30%, respectively) where each partition is also split into three files that contain

measurements from the accelerometer and gyroscope
activity label
identifier of the subject
Getting and cleaning data
If the data is not already available in the data directory, it is downloaded from UCI repository.

The first step of the preprocessing is to merge the training and test sets. Two sets combined, there are 10,299 instances where each instance contains 561 features (560 measurements and subject identifier). After the merge operation the resulting data, the table contains 562 columns (560 measurements, subject identifier and activity label).

After the merge operation, mean and standard deviation features are extracted for further processing. Out of 560 measurement features, 33 mean and 33 standard deviations features are extracted, yielding a data frame with 68 features (additional two features are subject identifier and activity label).

Next, the activity labels are replaced with descriptive activity names, defined in activity_labels.txt in the original data folder.

The final step creates a tidy data set with the average of each variable for each activity and each subject. 10299 instances are split into 180 groups (30 subjects and 6 activities) and 66 mean and standard deviation features are averaged for each group. The resulting data table has 180 rows and 66 columns. The tidy data set is exported to UCI_HAR_tidy.csv where the first row is the header containing the names for each column.
