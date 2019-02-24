#CodeBook

The Analysis.R script performs the data cleanning required as described in the course project’s definition.

1.Download the dataset,check if the file exist or not.

2.Assign each data to variables
features <- features.txt 
activity <- activity_labels.txt
subject_test <- test/subject_test.txt
x_test <- test/X_test.txt 
y_test <- test/y_test.txt 
subject_train <- test/subject_train.txt
x_train <- test/X_train.txt 
y_train <- test/y_train.txt

3.Merges the training and the test sets to create one data set
Xdata is created by merging x_train and x_test using rbind() function
Ydata is created by merging y_train and y_test using rbind() function
Subject is created by merging subject_train and subject_test using rbind() function
Merged_Data is created by merging Subject, Y and X using cbind() function

4.Extracts only the measurements on the mean and standard deviation for each measurement
TData is created by subsetting Merged_Data, selecting only columns: subject, code and the measurements 

5. Uses descriptive activity names to name the activities in the data set

6.Appropriately labels the data set with descriptive variable names
replace the abbreviated name with full name or descriptive names.

7.FinalData: a sub-data containing the mean values for each column. Export final data by writing a new txt file.
