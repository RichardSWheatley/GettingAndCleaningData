# CodeBook.md

This is the Code Book for the run_analysis.R script created for the tidy_data.txt file
* There is data at the following location:
  * https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
* The data is from a study titled: _Human Activity Recognition Using Smartphones Data Set_
  * http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The immediately following information is taken directly from the above website

> Data Set Information:
   The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.

>  The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

> Attribute Information
  For each record in the dataset it is provided:
   - Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
   - Triaxial Angular velocity from the gyroscope.
   - A 561-feature vector with time and frequency domain variables.
   - Its activity label.
   - An identifier of the subject who carried out the experiment.

  Inside the folder _/UCI HAR Dataset/_ from the above zip file above is a ".README.txt"
  The following is an excerpt that describes the variables.'features_info.txt': Shows information about the variables used on the feature vector.

    'features.txt': List of all features.
    'activity_labels.txt': Links the class labels with their activity name.
    'train/X_train.txt': Training set.
    'train/y_train.txt': Training labels.
    'test/X_test.txt': Test set.
    'test/y_test.txt': Test labels.

    The following files are available for the train and test data. Their descriptions are equivalent.
    'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.
    'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis.
    'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration.
    'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second.


**run_analysis.R** performs the following transformations on the data found in the zip file and collected in the study

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

How my run_analysis.R implements the above steps:

* Load the test data, the training data, feature names and the activity labels using read.table() into the following variables
  * features
  * activity_labels
  * training_set_data
  * training_set_subjects
  * training_set_activities
  * test_set_data
  * test_set_subjects
  * test_set_activities
* Merge all of the test and training data sets.
  * Merge the training data together with _cbind_ using the following variable
    * training_data_all
  * Merge the test data together with _cbind_ using the following variable
    * test_data_all
  * Merge the training and test data together with _rbind_ using the following variable
    * combined_dataset
* Extract the data from only columns that contain mean and standard deviation data.
* Process the data by calculating the mean with respect to the subject's ID number and the activity name.
