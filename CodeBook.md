# Codebook for Cleaning Data Final Assignment
## Omer Ansari . 2.28.2016

### This codebook will document the following items:
  1. all transformations performed to clean up the data
  2. what the corresponding data and variables are

### Assumptions:
* the dataset directory has been downloaded, zipped and put in the same folder as the script



### 1. all transformations performed to clean up the data
1. First, I read in the activity labels ("UCI HAR Dataset/activity_labels.txt") into a table. These are sitting, walking etc... I blessed them with appropriate column names
2. Then, I read in the feature function names themselves ("UCI HAR Dataset/features.txt") into a vector (e.g. tBodyAcc-mean()-X)  These are the 561 odd function names that were performed on the received data ranging from body and gravity acceleration signals to linear and angular velocity along with fourier transforms. This is detailed in depth in the "UCI HAR Dataset/features_info.txt" file.
3. I then cleaned up these feature function names of the following characters: "-" , "(", ")", and ",". The reason I am doing this is because I intend to use these same names as the column names for my eventual data set.
4. Now its time to suck in all the data. I pull in the test ("UCI HAR Dataset/test/X_test.txt") and train ("UCI HAR Dataset/train/X_train.txt") data and used the same cleaned up feature function name vector created in the last step as the column names vector for this data set
5. I then sucked in the subject's (or volunteer's) ID for both the test ("UCI HAR Dataset/test/subject_test.txt") and the train ("UCI HAR Dataset/train/subject_train.txt") data, and provided (the same) column Name (volunteerID) to each
6. After this I sucked in the activitity data into a vector, for both test ("UCI HAR Dataset/test/y_test.txt") and train ("UCI HAR Dataset/train/y_train.txt") data
7.  Time for merging all the data into 1 data set. I combine the activity (step 6), and the volunteer doing that activity (step5) to each of the now comprehensive test and train data tables (step4). I then combine both these test and train data tables.
8.  we are only interested in the mean and standard deviation columns, so I use a simple grep command to catch any utterances of "mean or std" (and while i'm at it, volunteer and activity as well) and put them in a slimmer data table.
9.  I then iterate through the numeric activity column and replace it with the respective activity name (WALKING, LYING etc) 
10.  now to create the final tidy data. I use dplyr functions to first group the data by two variables (volunteer and activity)
11.  I apply the summarize_each() function on this data set created in 10, applying the mean() function to each of the data columns
12.  as a final touch, i prepend "averageOf_" to each of the column name containing the mean or std data for accuracy's sake.
13.  finally, I create the csv file.

### 2. what the corresponding data and variables are
#### The Data:
* The *data* is basically a massaged output of the signals captured from the device at a rate of 50Hz (or 0.02 seconds). 
* The specifics of the "massage" are documented in the "UCS HAR Dataset/features_info.txt".
* There were 30 unique volunteer subjects used to collect the data
* Each subject was asked to do 6 things , while the device on them was collecting the data. These things were: WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING

#### The Variables:
Essentially, the tidy data has each column as an independent data variable, and each row item represents the value of the sample for that variable.

* volunteerID : the ID of the volunteer subject
* activityType: the type of activity he/she was doing

The remaining following columns were computed for each activity for that subject". These are literally only the mean and standard deviation functions (81) out of the total functions (561) listed in the dataset's features.txt file. 
Of importance is the fact that each of these values are the mean (or average of the complete data sampled for that specific variable). This mean is computed in terms of the volunteer and the activity type. example...

| volunteerID   | activityType | averageOf_tBodyAccmeanX | ..etc... |
| ------------- | ------------- | ------------- |  -------------
| 1  | "LAYING"   | 0.22159824394  | ..etc... |
| 1  | "SITTING"  | 0.261237565425532  | ..etc... |
| .. | .... | ..... | ...|
... and so on..
e.g. Look at the bold item: There were literally a ton of data points for even the laying activity (polled 0.02s for the duration  volunteer #1 lay down). however the tidy data only presents the mean of this activity for volunteer #1 above (whic is 0.221598...)

I will not explain the specifics of each variable below, as you can glean that from the features_info.txt file.

* averageOf_tBodyAccmeanX
* averageOf_tBodyAccmeanY
* averageOf_tBodyAccmeanZ
* averageOf_tBodyAccstdX
* averageOf_tBodyAccstdY
* averageOf_tBodyAccstdZ
* averageOf_tGravityAccmeanX
* averageOf_tGravityAccmeanY
* averageOf_tGravityAccmeanZ
* averageOf_tGravityAccstdX
* averageOf_tGravityAccstdY
* averageOf_tGravityAccstdZ
* averageOf_tBodyAccJerkmeanX
* averageOf_tBodyAccJerkmeanY
* averageOf_tBodyAccJerkmeanZ
* averageOf_tBodyAccJerkstdX
* averageOf_tBodyAccJerkstdY
* averageOf_tBodyAccJerkstdZ
* averageOf_tBodyGyromeanX
* averageOf_tBodyGyromeanY
* averageOf_tBodyGyromeanZ
* averageOf_tBodyGyrostdX
* averageOf_tBodyGyrostdY
* averageOf_tBodyGyrostdZ
* averageOf_tBodyGyroJerkmeanX
* averageOf_tBodyGyroJerkmeanY
* averageOf_tBodyGyroJerkmeanZ
* averageOf_tBodyGyroJerkstdX
* averageOf_tBodyGyroJerkstdY
* averageOf_tBodyGyroJerkstdZ
* averageOf_tBodyAccMagmean
* averageOf_tBodyAccMagstd
* averageOf_tGravityAccMagmean
* averageOf_tGravityAccMagstd
* averageOf_tBodyAccJerkMagmean
* averageOf_tBodyAccJerkMagstd
* averageOf_tBodyGyroMagmean
* averageOf_tBodyGyroMagstd
* averageOf_tBodyGyroJerkMagmean
* averageOf_tBodyGyroJerkMagstd
* averageOf_fBodyAccmeanX
* averageOf_fBodyAccmeanY
* averageOf_fBodyAccmeanZ
* averageOf_fBodyAccstdX
* averageOf_fBodyAccstdY
* averageOf_fBodyAccstdZ
* averageOf_fBodyAccmeanFreqX
* averageOf_fBodyAccmeanFreqY
* averageOf_fBodyAccmeanFreqZ
* averageOf_fBodyAccJerkmeanX
* averageOf_fBodyAccJerkmeanY
* averageOf_fBodyAccJerkmeanZ
* averageOf_fBodyAccJerkstdX
* averageOf_fBodyAccJerkstdY
* averageOf_fBodyAccJerkstdZ
* averageOf_fBodyAccJerkmeanFreqX
* averageOf_fBodyAccJerkmeanFreqY
* averageOf_fBodyAccJerkmeanFreqZ
* averageOf_fBodyGyromeanX
* averageOf_fBodyGyromeanY
* averageOf_fBodyGyromeanZ
* averageOf_fBodyGyrostdX
* averageOf_fBodyGyrostdY
* averageOf_fBodyGyrostdZ
* averageOf_fBodyGyromeanFreqX
* averageOf_fBodyGyromeanFreqY
* averageOf_fBodyGyromeanFreqZ
* averageOf_fBodyAccMagmean
* averageOf_fBodyAccMagstd
* averageOf_fBodyAccMagmeanFreq
* averageOf_fBodyBodyAccJerkMagmean
* averageOf_fBodyBodyAccJerkMagstd
* averageOf_fBodyBodyAccJerkMagmeanFreq
* averageOf_fBodyBodyGyroMagmean
* averageOf_fBodyBodyGyroMagstd
* averageOf_fBodyBodyGyroMagmeanFreq
* averageOf_fBodyBodyGyroJerkMagmean
* averageOf_fBodyBodyGyroJerkMagstd
* averageOf_fBodyBodyGyroJerkMagmeanFreq
