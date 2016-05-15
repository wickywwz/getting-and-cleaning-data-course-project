##Create downloading directory
if(!file.exists("./data")) dir.create("./data")

##Download course project file and unzip it under the directory
fileURL <-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileURL,destfile =  "./data/Getting_and_Cleaning_Data_Course_Project.zip")
unzip("./data/Getting_and_Cleaning_Data_Course_Project.zip", exdir = "./data")

##Set working directory
setwd("./data")

##Load data from individual file
trainX <- read.table("UCI HAR Dataset/train/X_train.txt")
trainY <- read.table("UCI HAR Dataset/train/Y_train.txt")
trainSubject <- read.table("UCI HAR Dataset/train/subject_train.txt")
testX <- read.table("UCI HAR Dataset/test/X_test.txt")
testY <- read.table("UCI HAR Dataset/test/y_test.txt")
testSubject <- read.table("UCI HAR Dataset/test/subject_test.txt")

##Merge the training and the test sets to create one dataset
trainMerge <- cbind(trainSubject, trainY, trainX)
testMerge <- cbind(testSubject, testY, testX)
MergedData <- rbind(trainMerge,testMerge)

##Load the measurements file
feature <- read.table("UCI HAR Dataset/features.txt", stringsAsFactors = FALSE)
feature <- feature[,2]

##Extract the mean and std measurement and record their positions
positionNo <- grep(("mean\\(\\)|std\\(\\)"), feature)
feature <- feature[positionNo]
positionNo <- positionNo+2

##Extract mean and std columns and name these columns with features
NewData <- MergedData[, c(1, 2, positionNo)]
colnames(NewData) <- c("subject", "activity", feature)

##Use descriptive activity names to name the activities in the dataset
activityName <- read.table("UCI HAR Dataset/activity_labels.txt")
NewData$activity <- factor(NewData$activity, levels = activityName[,1], labels = activityName[,2])

##Label the dataset with descriptive variable names
names(NewData) <- gsub("^t", "Time", names(NewData))
names(NewData) <- gsub("^f", "Frequence", names(NewData))
names(NewData) <- gsub("-mean", "Mean", names(NewData))
names(NewData) <- gsub("-std", "Std", names(NewData))
names(NewData) <- gsub("\\()", "", names(NewData))

##Create tidy dataset with the average of each variable for each activity and each subject
##First we need to load the dplyr package
library(dplyr)
NewData <- group_by(NewData, subject, activity)
NewData <- summarise_each(NewData, funs(mean))
TidyData <- NewData

##Output tidy dataset
write.table(TidyData,"TidyData.txt",row.names = FALSE)
