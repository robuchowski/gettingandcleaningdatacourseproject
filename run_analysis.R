fileurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
filename <- "~/Week 2 Data Analysis class.zip"
download.file(fileurl, filename)
if (!file.exists("UCI HAR Dataset")){
        unzip(filename)
}
features <- read.table("UCI HAR Dataset/features.txt", col.names = c("n","functions"))
activities <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
x_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "code")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
x_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$functions)
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "code")

X <- rbind(x_train, x_test)
Y <- rbind(y_train, y_test)
subject <- rbind(subject_train, subject_test)
merged_data <- cbind(subject, Y, X)

library(dplyr)
tidydata <- merged_data %>% select(subject, code, contains("mean"), contains("std"))
tidydata$code <- activities[tidydata$code, 2]

names(tidydata)[2] = "activity"
names(tidydata) <- gsub("ACC", "Accelerometer", names(tidydata))
names(tidydata) <- gsub("Gyro", "Gyroscope", names(tidydata))
names(tidydata) <- gsub("BodyBag", "Body", names(tidydata))
names(tidydata) <- gsub("Mag", "Magnitude", names(tidydata))
names(tidydata) <- gsub("^t", "Time", names(tidydata))
names(tidydata) <- gsub("^f", "Frequency", names(tidydata))
names(tidydata) <- gsub("tbody", "TimeBody", names(tidydata))
names(tidydata) <- gsub("-mean()", "Mean", names(tidydata), ignore.case = TRUE)
names(tidydata) <- gsub("-std()", "STD", names(tidydata), ignore.case = TRUE)
names(tidydata) <- gsub("-freq()", "Frequency", names(tidydata), ignore.case = TRUE)
names(tidydata) <- gsub("angle", "Angle", names(tidydata))
names(tidydata) <- gsub("gravity", "Gravity", names(tidydata))

finaldata <- tidydata %>% 
        group_by(subject, activity) %>%
        summarize_all(funs(mean))
write.table (finaldata, "finaldata.txt", row.name=FALSE)        

str(finaldata)
finaldata
