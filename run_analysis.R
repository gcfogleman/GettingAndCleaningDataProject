
## Make sure the file "UCI HAR Dataset" is in the working directory


#    1. Merge the training and the test sets (this step not completed until below, before step 5)

## Read the test data into dataframes
X_testDF <- read.table("UCI HAR Dataset/test/X_test.txt")     ##  2947 by 561
y_testDF <- read.table("UCI HAR Dataset/test/y_test.txt")     ##  2947 by 1
subject_testDF <- read.table("UCI HAR Dataset/test/subject_test.txt")    ##  2947 by 1

## Read the train data into dataframes
X_trainDF <- read.table("UCI HAR Dataset/train/X_train.txt")    ##  7352 by 561
y_trainDF <- read.table("UCI HAR Dataset/train/y_train.txt")    ##  7352 by 1
subject_trainDF <- read.table("UCI HAR Dataset/train/subject_train.txt")    ##  7352 by 1

## Read the information about the 561 variables into dataframes
featuresDF <- read.table("UCI HAR Dataset/features.txt")    ##  561 by 2; featuresDF$V2 contains the variable names

## Read the six activity names corresponding to TestLabels 1 through 6
activity_labelsDF <- read.table("UCI HAR Dataset/activity_labels.txt")


#     4. Actively label the data set with descriptive variable names

## Make the variable names be the column names for X_testDF and X_trainDF
colnames(X_testDF) <- featuresDF$V2
colnames(X_trainDF) <- featuresDF$V2

## Create dataframes containing subject labels and training labels for the test and train dataframes
colnames(y_testDF) <- "TestLabel"
colnames(y_trainDF) <- "TestLabel"
colnames(subject_testDF) <- "SubjectLabel"
colnames(subject_trainDF) <- "SubjectLabel"
testDataSetDF <- cbind(subject_testDF, y_testDF)
trainDataSetDF <- cbind(subject_trainDF, y_trainDF)

#  Make the first column of each DataSet "test" or "train"
Atest <- as.data.frame(rep("test", length(testDataSetDF$SubjectLabel)))
colnames(Atest) <- "TestOrTrain"
testDataSetDF <- cbind(Atest, testDataSetDF)

Atrain <- as.data.frame(rep("train", length(trainDataSetDF$SubjectLabel)))
colnames(Atrain) <- "TestOrTrain"
trainDataSetDF <- cbind(Atrain, trainDataSetDF)

## Add the test and train data to the DataSet dataframes
testDataSetDF <- cbind(testDataSetDF, X_testDF)
trainDataSetDF <- cbind(trainDataSetDF, X_trainDF)

## Create one giant dataframe with all data
DataSetDF <- rbind(testDataSetDF, trainDataSetDF)  ## This dataset has 10299 rows


#    2.   Extract only the measurements on mean and standard deviations

## Extract columns with means and standard deviations
MeanDataSetDF <- DataSetDF[, grep("mean", colnames(DataSetDF))]
StdDataSetDF <- DataSetDF[, grep("std", colnames(DataSetDF))]

## Combine those into a new dataset
## 10299 observations of 79 variables
ReducedDataSetDF <- cbind(MeanDataSetDF, StdDataSetDF)  

## Add back the first three columns that were lost in the above extraction
## Now have 10299 observations of 82 variables
ReducedDataSetDF <- cbind(DataSetDF[,1:3], ReducedDataSetDF)


#       3. Use descriptive activity names to name the test activities

##  Change test labels 1 through 6 to activity names by merging
mergedData <- merge(activity_labelsDF, ReducedDataSetDF, by.x = "V1", by.y = "TestLabel")
## Remove the first column, which still contains the test labels
mergedData <- mergedData[, 2:length(colnames(mergedData))]
## Change the column name for the first column to "Activities"
colnames(mergedData)[1] <- "Activity"
## mergedData is the one merged data set called for in question 1.


#    5. Create a second, independent tidy data set
library(plyr)

## Use the ddply function to create the required tidy data set
tidyDataSet <- ddply(mergedData, .(Activity, SubjectLabel), numcolwise(mean))

##  Create a .txt file with the dataset
write.table(tidyDataSet, file = "tidyDataSet.txt")
##  tidyDataSet.txt was uploaded to the Coursera web page

