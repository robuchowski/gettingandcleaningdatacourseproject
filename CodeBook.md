The run_analysis. R takes the messy data given in the assignment prompt and performs data preparation followed by the steps required per the course project's instructions.  

1. Download the dataset
        A. Data set downloaded and extracted under the "UCI HAR Dataset" folder

2. Assign data to variables
        A. features <- features.txt (561 rows, 2 columns) The features selected come from the accelerometer and gyroscopr 3-axial raw signal tAcc-XYZ and tGyro-XYZ.
        B. activities <- activity_labels.txt (6 rows, 2 columns) These are a list of activities performed when the measures were taken.
        c. subject_test <- test/subject_test.txt (2947 rows, 1 column) This contains test data of the test subjects that were observed
        D. x_test <-test/X_test.txt (2947 rows, 561 columns) This contains recorded features test data
        E. x_train <- test/X_train.txt (7352 rows, 561 colums) contains train data on the recorded features
        F. y_test <- test/y_test.txt (2947 rows, 561 columns) This is the test data of activites code labels
        G. y_train <- test/y_train.txt (7352 rows, 1 column) this contains train data of activities'code labels

3. Merge the training and the test sets to create one data set. 
        A. I merged the x_train and x_test data sets into X using the rbind function. 
        B. I merged y_train and y_test in order to create the Y data set using the rbind function. 
        C. I created subject by merging the subject_train and the subject_test using the rbind function 
        D. I merged all of those merged datasets to create merged_data with the cbind function (subject, Y, X)
        
4. Extract only the measurements on mean and standard deviation for each measurement. 
        A. I created tidydata by subsetting the merged_data by only the columns: subject, code, and the measurements on the mean and standard deviation for each measurement. 

5. Use descriptive activity names to name activities in the data set. 
        A. Entire numbers in the code column of the tidydata were replaced with the activity taken from the second column of activities variable. 
        
6. Labeled the data set with descriptive variable names 
        A. code column was renamed to activities 
        B. Acc was replaced by Accelerometer
        C. Gyrp was replaced by Gyroscope 
        D. BodyBag was replaced by Body 
        E. Mad was replaced with Magnitude 
        F. Every start with character f was repplaced by Frequency 
        G. Every start with character t was replaced by Time 

7. From the data set in step 4, created a second, independent tidy data set with the average of each variable for each activity and each subject.
        A. finaldata (180 rows, 88 columns) was created by sumarizing the tidydata by taking the mean of each variable for activity and each subject and then grouped by the subject and activity. 
        B. I exported the finaldata into the finaldata.txt file