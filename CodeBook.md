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
