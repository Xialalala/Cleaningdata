#step1:downpoad the data and check if there exist a same named file or not and create a new file for this project.
library(dplyr)
filename <- "peergradingcapstone.zip"
if (!file.exists(filename)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileURL, filename, method="curl")
}  
#Unzip the file
if (!file.exists("UCI HAR Dataset")) { 
  unzip(filename) 
}

#step2: load the datasets downloaded to R. Creating column names for each of them.
features <- read.table("UCI HAR Dataset/features.txt", col.names = c("n","feature"))
activity <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))

#in fold subject,load the data to R
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
x_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$feature)
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "code")

#in fold test, load the data to R
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
x_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$feature)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "code")
#head(x_test) #have a look at the dataset

#combine or merge datasets that have the same variables
Xdata <- rbind(x_train, x_test)
Ydata <- rbind(y_train, y_test)
Subjectdata <- rbind(subject_train, subject_test)

#merge all the datasets into merged_Data
Merged_Data <- cbind(Subjectdata, Ydata, Xdata)

#extract the mean and standard deviation from merged_data and create a new dataset TData
TData <- Merged_Data %>% select(subject, code, contains("mean"), contains("std"))
#head(TData)
TidyData$code <- activity[TData$code, 2]

#give the variables descriptive names. Replace some abbreviations to full name.
names(TidyData)[2] = "activity"
names(TidyData)<-gsub("BodyBody", "Body", names(TidyData))

#use metacharacters to find the special characters and replace them
names(TidyData)<-gsub("^t", "Time", names(TidyData))
names(TidyData)<-gsub("^f", "Frequency", names(TidyData))
names(TidyData)<-gsub("-mean()", "Mean", names(TidyData), ignore.case = TRUE)
names(TidyData)<-gsub("-std()", "STD", names(TidyData), ignore.case = TRUE)
names(TidyData)<-gsub("-freq()", "Frequency", names(TidyData), ignore.case = TRUE)
#head(TidyData, n=2)
#finally get a tidy dataset
FinalData <- TidyData %>%
  group_by(subject, activity) %>%
  summarize_all(funs(mean))
#export to a .txt file
write.table(FinalData, "FinalData.txt", row.name=FALSE)
