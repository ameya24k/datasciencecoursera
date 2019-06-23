# Reference Dataset -
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

# Creating tables for each dataset
features <- read.table("./features.txt", col.names = c("n","functions"))
activities <- read.table("./activity_labels.txt", col.names = c("code", "activity"))
subject_test <- read.table("./test/subject_test.txt", col.names = "subject")
x_test <- read.table("./test/X_test.txt", col.names = features$functions)
y_test <- read.table("./test/y_test.txt", col.names = "code")
subject_train <- read.table("./train/subject_train.txt", col.names = "subject")
x_train <- read.table("./train/X_train.txt", col.names = features$functions)
y_train <- read.table("./train/y_train.txt", col.names = "code")

# Merging test and train data sets into single dataset.
X <- rbind(x_train, x_test)
Y <- rbind(y_train, y_test)
Subject <- rbind(subject_train, subject_test)
Merged_Data <- cbind(Subject, Y, X)

# Selecting only the mean and standard deviation columns from the merged data as per the requirement.
TidyData <- Merged_Data %>% select(subject, code, contains("mean"), contains("std"))

# Joining the Tidy data set with Activities table in order to fetch activity names based on code field.
TidyData <- activities %>% inner_join(TidyData, by = "code")

# Naming the Tidy data set as per required standards
# All the short forms are replaced by descriptive names.
names(TidyData)[1] <- "ActivityCode"
names(TidyData)[2] <- "ActivityName"
names(TidyData)<-gsub("Acc", "Accelerometer", names(TidyData))
names(TidyData)<-gsub("Gyro", "Gyroscope", names(TidyData))
names(TidyData)<-gsub("BodyBody", "Body", names(TidyData))
names(TidyData)<-gsub("Mag", "Magnitude", names(TidyData))
names(TidyData)<-gsub("^t", "Time", names(TidyData))
names(TidyData)<-gsub("^f", "Frequency", names(TidyData))
names(TidyData)<-gsub("tBody", "TimeBody", names(TidyData))
names(TidyData)<-gsub("-mean()", "Mean", names(TidyData), ignore.case = TRUE)
names(TidyData)<-gsub("-std()", "STD", names(TidyData), ignore.case = TRUE)
names(TidyData)<-gsub("-freq()", "Frequency", names(TidyData), ignore.case = TRUE)
names(TidyData)<-gsub("angle", "Angle", names(TidyData))
names(TidyData)<-gsub("gravity", "Gravity", names(TidyData))

# Getting the final data set with the average of each variable for each activity and each subject.
TidyDataSet <- TidyData %>%
  group_by(subject, ActivityName, ActivityCode) %>%
  summarise_all(funs(mean))

# Writing the final dataset into an output .txt file
write.table(TidyDataSet, "TidyDataSet.txt", row.name=FALSE)