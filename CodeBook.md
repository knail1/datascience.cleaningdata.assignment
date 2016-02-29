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
* There were 30 unique volunteer subjects used to collect the data
* Each subject was asked to do 6 things , while the device on them was collecting the data. These things were: WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING

#### The Variables:
The specifics of the "massage" are documented in the "UCS HAR Dataset/features_info.txt".

"1" "volunteerID" : the ID of the volunteer subject
"2" "activityType": the type of activity he/she was doing
The following columns were computed for each activity for that subject:
"3" "averageOf_tBodyAccmeanX" : 
"4" "averageOf_tBodyAccmeanY"
"5" "averageOf_tBodyAccmeanZ"
"6" "averageOf_tBodyAccstdX"
"7" "averageOf_tBodyAccstdY"
"8" "averageOf_tBodyAccstdZ"
"9" "averageOf_tGravityAccmeanX"
"10" "averageOf_tGravityAccmeanY"
"11" "averageOf_tGravityAccmeanZ"
"12" "averageOf_tGravityAccstdX"
"13" "averageOf_tGravityAccstdY"
"14" "averageOf_tGravityAccstdZ"
"15" "averageOf_tBodyAccJerkmeanX"
"16" "averageOf_tBodyAccJerkmeanY"
"17" "averageOf_tBodyAccJerkmeanZ"
"18" "averageOf_tBodyAccJerkstdX"
"19" "averageOf_tBodyAccJerkstdY"
"20" "averageOf_tBodyAccJerkstdZ"
"21" "averageOf_tBodyGyromeanX"
"22" "averageOf_tBodyGyromeanY"
"23" "averageOf_tBodyGyromeanZ"
"24" "averageOf_tBodyGyrostdX"
"25" "averageOf_tBodyGyrostdY"
"26" "averageOf_tBodyGyrostdZ"
"27" "averageOf_tBodyGyroJerkmeanX"
"28" "averageOf_tBodyGyroJerkmeanY"
"29" "averageOf_tBodyGyroJerkmeanZ"
"30" "averageOf_tBodyGyroJerkstdX"
"31" "averageOf_tBodyGyroJerkstdY"
"32" "averageOf_tBodyGyroJerkstdZ"
"33" "averageOf_tBodyAccMagmean"
"34" "averageOf_tBodyAccMagstd"
"35" "averageOf_tGravityAccMagmean"
"36" "averageOf_tGravityAccMagstd"
"37" "averageOf_tBodyAccJerkMagmean"
"38" "averageOf_tBodyAccJerkMagstd"
"39" "averageOf_tBodyGyroMagmean"
"40" "averageOf_tBodyGyroMagstd"
"41" "averageOf_tBodyGyroJerkMagmean"
"42" "averageOf_tBodyGyroJerkMagstd"
"43" "averageOf_fBodyAccmeanX"
"44" "averageOf_fBodyAccmeanY"
"45" "averageOf_fBodyAccmeanZ"
"46" "averageOf_fBodyAccstdX"
"47" "averageOf_fBodyAccstdY"
"48" "averageOf_fBodyAccstdZ"
"49" "averageOf_fBodyAccmeanFreqX"
"50" "averageOf_fBodyAccmeanFreqY"
"51" "averageOf_fBodyAccmeanFreqZ"
"52" "averageOf_fBodyAccJerkmeanX"
"53" "averageOf_fBodyAccJerkmeanY"
"54" "averageOf_fBodyAccJerkmeanZ"
"55" "averageOf_fBodyAccJerkstdX"
"56" "averageOf_fBodyAccJerkstdY"
"57" "averageOf_fBodyAccJerkstdZ"
"58" "averageOf_fBodyAccJerkmeanFreqX"
"59" "averageOf_fBodyAccJerkmeanFreqY"
"60" "averageOf_fBodyAccJerkmeanFreqZ"
"61" "averageOf_fBodyGyromeanX"
"62" "averageOf_fBodyGyromeanY"
"63" "averageOf_fBodyGyromeanZ"
"64" "averageOf_fBodyGyrostdX"
"65" "averageOf_fBodyGyrostdY"
"66" "averageOf_fBodyGyrostdZ"
"67" "averageOf_fBodyGyromeanFreqX"
"68" "averageOf_fBodyGyromeanFreqY"
"69" "averageOf_fBodyGyromeanFreqZ"
"70" "averageOf_fBodyAccMagmean"
"71" "averageOf_fBodyAccMagstd"
"72" "averageOf_fBodyAccMagmeanFreq"
"73" "averageOf_fBodyBodyAccJerkMagmean"
"74" "averageOf_fBodyBodyAccJerkMagstd"
"75" "averageOf_fBodyBodyAccJerkMagmeanFreq"
"76" "averageOf_fBodyBodyGyroMagmean"
"77" "averageOf_fBodyBodyGyroMagstd"
"78" "averageOf_fBodyBodyGyroMagmeanFreq"
"79" "averageOf_fBodyBodyGyroJerkMagmean"
"80" "averageOf_fBodyBodyGyroJerkMagstd"
"81" "averageOf_fBodyBodyGyroJerkMagmeanFreq"
