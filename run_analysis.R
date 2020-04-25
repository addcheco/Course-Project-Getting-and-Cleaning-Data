#download the dataset and load packages
library(dplyr) #load necessary file
filename <- "Coursera_DS3_Final.zip"
if (!file.exists(filename)){ #if file don't exist, add it
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileURL, filename, method="curl")
}
if (!file.exists("UCI HAR Dataset")) { #if dataset don't exist, add it
unzip(filename)
}

#Creating data frames 
feat  <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity")) 
activity <- read.table("UCI HAR Dataset/features.txt", col.names = c("n","functions"))
test_subject <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
xtest <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
ytest <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "code")
subjecttrainset <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
xtrain <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$functions)
ytrain <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "code")


#Merge the training and the test sets to create one data set
X <- rbind(xtrain, xtest) #merge xtrain and xtest
Y <- rbind(ytrain, ytest) #merge ytrain and ytest
Subject <- rbind(subjecttrainset, test_subject) #merge subjects, test and train
MergedData <- cbind(Subject, Y, X) #merge all the above


#Extracts only the measurements on the mean and standard deviaton for each measurement 
BeautifulData <- MergedData %>% select(subject, code, contains("mean"), contains("std")) #new dataframe with merged data
#new dataframe also includes mean and standard deviation

#Uses descriptive activity names to name the activities in the data set 
BeautifulData$code <- activities[BeautifulData$code, 2] 

#Appropriately labels the data set with descriptive variable names 
names(BeautifulData)[2] = "activity"
names(BeautifulData)<-gsub("Acc", "Accelerometer", names(BeautifulData)) 
names(BeautifulData)<-gsub("Gyro", "Gyroscope", names(BeautifulData))
names(BeautifulData)<-gsub("BodyBody", "Body", names(BeautifulData))
names(BeautifulData)<-gsub("Mag", "Magnitude", names(BeautifulData))
names(BeautifulData)<-gsub("^t", "Time", names(BeautifulData))
names(BeautifulData)<-gsub("^f", "Frequency", names(BeautifulData))
names(BeautifulData)<-gsub("tBody", "TimeBody", names(BeautifulData))
names(BeautifulData)<-gsub("-mean()", "Mean", names(BeautifulData), ignore.case = TRUE)
names(BeautifulData)<-gsub("-std()", "STD", names(BeautifulData), ignore.case = TRUE)
names(BeautifulData)<-gsub("-freq()", "Frequency", names(BeautifulData), ignore.case = TRUE)
names(BeautifulData)<-gsub("angle", "Angle", names(BeautifulData))
names(BeautifulData)<-gsub("gravity", "Gravity", names(BeautifulData))
#all the above are fixing the acronym names in columns with the full names to make it more understandable 


#Create independent tidy data set with the average of each variable for each activity and each subject 
FinalData <- BeautifulData %>%  #create new data set with all the above labelled as FinalData
  group_by(subject, activity) %>%
  summarise_all(funs(mean))
write.table(FinalData, "FinalData.txt", row.name=FALSE)

