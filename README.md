# datascience.cleaningdata.assignment
## Name: Omer Ansari, 2.28.16

This repo contains:
* this README.md file
* Codebook.md , which goes through the transformations and variables in detail
* run_analysis.R : the actual script which tidied the data 
* course3_finalAssignment_tidyData.csv : the tidy data produced by the script.

The  README.md file is required to explain how all scripts work. What follows are the details
* It is really simple, since everything is in  the same script run_analysis.R.
* I created separate functions, 
	* one for downloading, and unzipping the raw (untidy) data set
	* one for creating the csv
* The script just simply, 
	* reads in as tables, the activity, features, test and train data, and then 
	* reduces the data columns to just mean and std values, and appends the activity and features columns to this data. Then finally,
	* uses the dplyr function to group_by the volunteer and activity data, and the summarize_each function to apply the mean() function each of the data points resulting from the group_by function. It also
	* ensures the title of the variable stated "averageOf_" since each value now is the average of the whole column.


-------

Deliverables:

1) a link to a Git repository with your script for performing the analysis,  
In the Git:
  - README.md (this file) : This repo explains how all of the scripts work and how they are connected.
  - run_analysis.R : that 
  	1. Merges the training and the test sets to create one data set.
  	2. Extracts only the measurements on the mean and standard deviation for each measurement.
  	3. Uses descriptive activity names to name the activities in the data set
  	4. Appropriately labels the data set with descriptive variable names.
  	5. From the data set in step 4, creates a second, independent tidy data set with 
  	 1. the average of each variable for each activity and
  	 2. each subject.

2) a tidy data (output from above step 1.5)
		
3) CodeBook.md. code book that describes 
    - the variables, 
    - the data, 
    - and any transformations or work that you performed to clean up the data

https://www.coursera.org/learn/data-cleaning/peer/FIZtT/getting-and-cleaning-data-course-project
