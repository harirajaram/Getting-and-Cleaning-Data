# Getting and Cleaning Data

## run_analysis.R Details

* Require reshape2.
* Load the features and activity labels.
* Load both test and train data
* Extract the mean and standard deviation column names and data.
* Process the data. There are two parts processing test and train data respectively.
* Merge data set.

## Steps to run

* Download the data source and put into a folder on your local drive. You'll have a UCI HAR Dataset folder.
* Put run_analysis.R in the parent folder of UCI HAR Dataset, then set it as your working directory using setwd() function in RStudio.
* Run source("run_analysis.R"), then it will generate a new file tidy.txt in your working directory.


