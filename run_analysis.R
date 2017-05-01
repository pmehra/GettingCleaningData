library(dplyr)
library(tidyr)

##
# Get the data file
#
# Rdir="C:/Users/PankajMehra/Documents/R"
# setwd(Rdir)
# ProjectDir=cat(Rdir,"GalaxyS_data")
# if (!dir.exists(ProjectDir)) dir.create(ProjectDir)
#
# dataset_url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
# download.file(dataset_url,"GalaxyS.zip",method="wininet")
# unzip("GalaxyS.zip", exdir = ProjectDir)
#
# Now navigate into the data set
#
# setwd("GalaxyS_data/UCI HAR Dataset")

## Comment out everything above this line
# "The code should have a file run_analysis.R in the main directory
# that can be run as long as the Samsung data is in your working directory."
#
#
# Read the features info into a names vector
#
GSnamesfile <- "features.txt"
GSnamesdata <- read.delim(GSnamesfile,sep=" ",stringsAsFactors = FALSE,header = FALSE)
names(GSnamesdata) <- c("fNum","fName")
# GSnamesdata$fName contains the vector of 561 FEATURE NAMES
#
# Select those columns that contain mean() and std() of measurements
#
GScolsOfInterest <- sort(union(contains("mean()",,GSnamesdata$fName),contains("std()",,GSnamesdata$fName)))
# GScolsofInterest contains the indices for features of interest
GSnamesForColsofInterest <-
        c("BodyMeanAccelerationInXbyTime",
          "BodyMeanAccelerationInYbyTime",
          "BodyMeanAccelerationInZbyTime",
          "BodyStdAccelerationInXbyTime",
          "BodyStdAccelerationInYbyTime",
          "BodyStdAccelerationInZbyTime",
          "GravityMeanAccelerationInXbyTime",
          "GravityMeanAccelerationInYbyTime",
          "GravityMeanAccelerationInZbyTime",
          "GravityStdAccelerationInXbyTime",
          "GravityStdAccelerationInYbyTime",
          "GravityStdAccelerationInZbyTime",
          "BodyMeanJerkAccelerationInXbyTime",
          "BodyMeanJerkAccelerationInYbyTime",
          "BodyMeanJerkAccelerationInZbyTime",
          "BodyStdJerkAccelerationInXbyTime",
          "BodyStdJerkAccelerationInYbyTime",
          "BodyStdJerkAccelerationInZbyTime",
          "BodyMeanGyroAccelerationInXbyTime",
          "BodyMeanGyroAccelerationInYbyTime",
          "BodyMeanGyroAccelerationInZbyTime",
          "BodyStdGyroAccelerationInXbyTime",
          "BodyStdGyroAccelerationInYbyTime",
          "BodyStdGyroAccelerationInZbyTime",
          "BodyMeanJerkGyroAccelerationInXbyTime",
          "BodyMeanJerkGyroAccelerationInYbyTime",
          "BodyMeanJerkGyroAccelerationInZbyTime",
          "BodyStdJerkGyroAccelerationInXbyTime",
          "BodyStdJerkGyroAccelerationInYbyTime",
          "BodyStdJerkGyroAccelerationInZbyTime",
          "BodyMeanAbsAccelerationbyTime",
          "BodyStdAbsAccelerationbyTime",
          "GravityMeanAbsAccelerationbyTime",
          "GravityStdAbsAccelerationbyTime",
          "BodyMeanAbsJerkAccelerationbyTime",
          "BodyStdAbsJerkAccelerationbyTime",
          "BodyMeanAbsGyroAccelerationbyTime",
          "BodyStdAbsGyroAccelerationbyTime",
          "BodyMeanAbsJerkGyroAccelerationbyTime",
          "BodyStdAbsJerkGyroAccelerationbyTime",
          "BodyMeanAccelerationInXbyFreq",
          "BodyMeanAccelerationInYbyFreq",
          "BodyMeanAccelerationInZbyFreq",
          "BodyStdAccelerationInXbyFreq",
          "BodyStdAccelerationInYbyFreq",
          "BodyStdAccelerationInZbyFreq",
          "BodyMeanJerkAccelerationInXbyFreq",
          "BodyMeanJerkAccelerationInYbyFreq",
          "BodyMeanJerkAccelerationInZbyFreq",
          "BodyStdJerkAccelerationInXbyFreq",
          "BodyStdJerkAccelerationInYbyFreq",
          "BodyStdJerkAccelerationInZbyFreq",
          "BodyMeanGyroAccelerationInXbyFreq",
          "BodyMeanGyroAccelerationInYbyFreq",
          "BodyMeanGyroAccelerationInZbyFreq",
          "BodyStdGyroAccelerationInXbyFreq",
          "BodyStdGyroAccelerationInYbyFreq",
          "BodyStdGyroAccelerationInZbyFreq",
          "BodyMeanAbsAccelerationInbyFreq",
          "BodyStdAbsAccelerationbyFreq",
          "BodyMeanAbsJerkBodyAccelerationbyFreq",
          "BodyStdAbsJerkBodyAccelerationbyFreq",
          "BodyMeanAbsGyroBodyAccelerationbyFreq",
          "BodyStdAbsBodyGyroAccelerationbyFreq",
          "BodyMeanAbsBodyGyroJerkAccelerationbyFreq",
          "BodyStdAbsBodyGyroJerkAccelerationbyFreq"
        )
#
##
#
# Read the activity labels info into a labels vector
# (the CLASS LABELS in this classification experiment)
#
GSlabelsfile <- "activity_labels.txt"
GSlabelsdata <- read.delim(GSlabelsfile,sep=" ",stringsAsFactors = FALSE,header = FALSE)
names(GSlabelsdata) <- c("lNum","lName")
#
# GSlabelsdata$lName contains the vector of 6 ACTIVITY LABELS
#
##
#
# Now read in the training set
#
GStrgsetfile <- "train/X_train.txt"
GStrgsetdata <- read.table(GStrgsetfile)
GStrgSubsetData <- select(GStrgsetdata,GScolsOfInterest)
# names(GStrgsetdata) <- GSnamesdata$fName
names(GStrgSubsetData) <- GSnamesForColsofInterest
#
# Now read the training set subjects
#
GStrgsetsubjsFile <- "train/subject_train.txt"
GStrgsetsubjsData <- read.table(GStrgsetsubjsFile)
names(GStrgsetsubjsData) <- c("subjectId")
#
# Now read the training set labels
#
GStrgsetlabelsFile <- "train/y_train.txt"
GStrgsetlabelsData <- read.table(GStrgsetlabelsFile)
names(GStrgsetlabelsData) <- c("activityClass")
#
# column bind data and labels then add an identifying column of all training set data
#
GStrgSetData <- cbind.data.frame(GStrgSubsetData,GSlabelsdata$lName[GStrgsetlabelsData$activityClass],GStrgsetsubjsData, GSsubset="training")
names(GStrgSetData)[67]<-"activityClass"
#
# Now read in the test set
#
GStstsetfile <- "test/X_test.txt"
GStstsetdata <- read.table(GStstsetfile)
#names(GStstsetdata) <- GSnamesdata$fName
GStstSubsetData <- select(GStstsetdata,GScolsOfInterest)
names(GStstSubsetData) <- GSnamesForColsofInterest
#
# Now read the test set subjects
#
GStstsetsubjsFile <- "test/subject_test.txt"
GStstsetsubjsData <- read.table(GStstsetsubjsFile)
names(GStstsetsubjsData) <- c("subjectId")
#
# Next read in test set labels
#
GStstsetlabelsFile <- "test/y_test.txt"
GStstsetlabelsData <- read.table(GStstsetlabelsFile)
names(GStstsetlabelsData) <- c("activityClass")
#
# column bind data and labels then add an identifying column of all training set data
#
GStstSetData <- cbind.data.frame(GStstSubsetData,GSlabelsdata$lName[GStstsetlabelsData$activityClass],GStstsetsubjsData,GSsubset="test")
names(GStstSetData)[67]<-"activityClass"
#
# Now we are ready to row bind the training and test sets
#
GSdataSet <- rbind.data.frame(GStrgSetData,GStstSetData)

#
# Output the tidy data
#
write.table(GSdataSet, file = "Tidy dataset 1.txt", row.name=FALSE)
#
## Create and output a second data set that summarizes mean observations by subject and activity class
#
# gather(GSdataSet, subject_activity, subjectId, activityClass, -GSsubset)
# GSdataSet %>% melt(id.vars = c("subjectId", "activityClass", "GSsubset"), factorsAsStrings=F) %>%
# dcast(c(subjectId, activityClass) ~ variable, mean) %>% GSdataSet2
# GSdataSet2 <- (GSdataSet %>% melt(id.vars = c("subjectId", "activityClass", "GSsubset"), factorsAsStrings=F) %>% dcast(c(subjectId, activityClass) ~ variable, mean))
#GSdataSet2 <- melt(GSdataSet, id.vars = c("subjectId", "activityClass", "GSsubset"), factorsAsStrings=F)
#dcast(GSdataSet2, c(subjectId, activityClass) ~ variable, mean)
#
## Leave out the training versus test annotation in final column, and summarize rest
#
GSdataSet2 <- GSdataSet[,1:68] %>% group_by(subjectId,activityClass) %>% summarize_each(funs(mean))
write.table(GSdataSet2, file = "Tidy dataset 2.txt", row.name=FALSE)
