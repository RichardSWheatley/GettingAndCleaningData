##########################################################################################################

# Coursera Getting and Cleaning Data Course Project
# Richard S. Wheatley
# 12/26/2015

# run_analysis.r File Description:

##########################################################################################################
# This script will perform the following steps on the UCI HAR Dataset downloaded from 
#
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
##########################################################################################################

##########################################################################################################
# Merges the training and the test sets to create one data set.
# Extracts only the measurements on the mean and standard deviation for each measurement. 
# Uses descriptive activity names to name the activities in the data set
# Appropriately labels the data set with descriptive variable names. 
# From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
##########################################################################################################

rm(list = ls())

setwd("C:/Users/rwheatley/Desktop/Coursera/Getting and Cleaning Data/Week3/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset");

# Read in the features
features <- read.table("./features.txt");
activity_labels <- read.table("./activity_labels.txt");

# Combine training and test data (#1 on Course)
# Assign proper names from the features file to the combined test data
# Read in the training and test datasets
# Read in the test and training subject ids
# Read in the test and training activity ids
training_set_data <- read.table("./train/x_train.txt", header=FALSE);
training_set_subjects <- read.table("./train/subject_train.txt", header=FALSE);
training_set_activities <- read.table("./train/y_train.txt", header=FALSE);

colnames(training_set_subjects) <-"subject_id";
colnames(training_set_activities) <- "activity";
colnames(training_set_data) <- features[,2];

training_data_all = cbind(training_set_subjects,training_set_activities,training_set_data);

# clean up variables no longer in use
rm(training_set_subjects,training_set_activities,training_set_data)

test_set_data <- read.table("./test/X_test.txt", header=FALSE);
test_set_subjects <- read.table("./test/subject_test.txt", header=FALSE);
test_set_activities <- read.table("./test/y_test.txt", header=FALSE);

colnames(test_set_subjects) <-"subject_id";
colnames(test_set_activities) <- "activity";
colnames(test_set_data) <- features[,2];

test_data_all = cbind(test_set_subjects,test_set_activities,test_set_data);

# clean up variables no longer in use
rm(test_set_activities,test_set_subjects,test_set_data,features)

combined_dataset <- rbind(training_data_all,test_data_all);

# clean up variables no longer in use
rm(training_data_all,test_data_all)

# Use grepl to extract data from all indices that contain "mean" or "std" and the newly created activity and subject
indx <- grepl("mean|std|subject_id|activity", names(combined_dataset), ignore.case=TRUE);
mean_std_data_set <- combined_dataset[,indx];

# clean up variables no longer in use
rm(indx,combined_dataset);

mean_std_data_set$activity <- factor(mean_std_data_set$activity, levels = activity_labels[,1], labels = activity_labels[,2]);
mean_std_data_set$subject_id <- as.factor(mean_std_data_set$subject_id);

# clean up variables no longer in use
rm(activity_labels);

tidy_data <- aggregate(. ~ activity + subject_id, data = mean_std_data_set, mean)
tidy_data <- tidy_data[order(tidy_data$subject_id,tidy_data$activity),]

# clean up variables no longer in use
rm(mean_std_data_set);

write.table(tidy_data, file = "tidy_data.txt", row.names = FALSE)
