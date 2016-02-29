run_analysis <- function() {
  fetchData <- function(dataLocationURL) {
    if (!file.exists("getdata-projectfiles-UCI HAR Dataset.zip")) {
      print("downloading the data")
      download.file(url = dataLocationURL,"getdata-projectfiles-UCI HAR Dataset.zip","curl")
    } else {
     print("getdata-projectfiles-UCI HAR Dataset.zip already exists, skipping download")
   }

    if (!dir.exists("UCS HAR Dataset")) {
      print("unzipping the data file")
      unzip(zipfile = "getdata-projectfiles-UCI HAR Dataset.zip", overwrite = FALSE)
    } else {
      print("directory UCI HAR Dataset already exists, skipping steps")
    }
    
  }
  
  
  createCSV <- function(dataFrame) {
    if (!file.exists("course3_finalAssignment_tidyData.csv")) {
      print("creating the csv name: course3_finalAssignment_tidyData.csv")
      write.csv(dataFrame, file="course3_finalAssignment_tidyData.csv", row.names=FALSE)
    } else {
      print("course3_finalAssignment_tidyData.csv already exists, skipping write")
    }
  }
     
     
  ## MAIN CODE BELOW
  # clear the environment
  #rm(list = ls())
  file.remove("course3_finalAssignment_tidyData.csv")
  library(dplyr)
  
  # first we fetch the data 
  projectDataLocation <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  fetchData(projectDataLocation)

  # then, we read in the feature functions, and the various other data:
  activityLabels <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("activityID", "nameOfActivity"))
  featureFunctions <- read.table("UCI HAR Dataset/features.txt", col.names = c("activityNumber", "activityLabels"))
  # clean up the - ( and ) from the titles:
  featureFunctions$activityLabels <- gsub("[-(),]", "", featureFunctions$activityLabels)
  
  testData <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = featureFunctions$activityLabels)
  trainData <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = featureFunctions$activityLabels)
  
  subjectTestData <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = c("volunteerID"))
  subjectTrainData <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = c("volunteerID"))
  
  typeOfActivityTestData <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = c("activityType"))
  typeOfActivityTrainData <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = c("activityType"))
  
  # step(1) merging everything into 1 dataset
  
  #we combine the activity, and the volunteer doing that activity to the actual data vector..
  allTest <- cbind(subjectTestData, typeOfActivityTestData, testData)
  allTrain <- cbind(subjectTrainData, typeOfActivityTrainData, trainData)
  #putting both the tst and train data together
  combinedDataSet <- rbind(allTest, allTrain)
  
  # step(2) now we will only extract the columns which state mean or std (for standard deviation) 
  onlyMeanAndStdDataSet <- combinedDataSet[, grepl("mean|std|volunteer|activity", names(combinedDataSet))]
  
  # step(3) : descriptive activity names to name the activities in the data set
  for (i in activityLabels$activityID) {
    onlyMeanAndStdDataSet$activityType <- gsub(i, activityLabels$nameOfActivity[i], onlyMeanAndStdDataSet$activityType)
  }
  
  # step(4) : appropriately labeling.
    # I already took care of that above.
    
  # step(5) : create a 2nd tidy data set: average of each variable for each activity and each subject.
  # first we group the data by the subject and the activity
  tidyData <- group_by(onlyMeanAndStdDataSet, volunteerID, activityType)
  
  #then we summarize each variable (except the subject and activity) based on the group by applying mean on it.
  tidyData <- summarise_each_(tidyData, funs(mean), names(tidyData)[3:81])
  
  
  # final touch, we need to update the headers for each variable to update the fact that the values 
  # are now averageOf_x, not just x
  newHeaders <- names(tidyData)
  newHeaders[3:81] <- sub("^", "averageOf_", newHeaders[3:81])
  colnames(tidyData) <- newHeaders
  
  # time to create the csv:
  createCSV(tidyData)
}
