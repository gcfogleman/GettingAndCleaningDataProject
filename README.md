GettingAndCleaningDataProject
=============================



GettingAndCleaningDataProject

Class project for "Getting and Cleaning Data" Coursera class


The run_analysis.R  script creates the tidyDataSet.txt  dataset.  
This ReadMe file describes how the R script works.
The codebook for the tidyDataSet is in the CodeBook.md file.


First read the X_test, y_test, and subject_test files into dataframes.
Then read the X_train, y_train, and subject_train files into dataframes.
These files contain the measurements the Activity codes (1 to 6) and the Suject numbers (1 to 30).
Note that the test data contains only subjects 2  4  9 10 12 13 18 20 24.
The train data contains only subjects 1  3  5  6  7  8 11 14 15 16 17 19 21 22 23 25 26 27 28 29 30.

Then read in the features and activity_labels files into dataframes.
The activity_labels file translates the Activity Codes (1 to 6) to Activities.
Activities are WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, and LAYING. 
The features file contains the variable names for the variables (columns) in x_test and y_test.


Change the column headings in x_test and x_train to the variable names given by features.


Create new dataframes with additional columns at the beginning:
testDataSetDF adds "test" as the value of the first variable (TestOrTrain), SubjectLabel and the second, and TestLabel as the third.
TrainDataSetDF adds "train" s the value of the first variable (TestOrTrain), SubjectLabel and the second, and TestLabel as the third.

Combine the two datasets into a single dataset called DataSetDF.
The first column says whether the row is from the test or the train dataset.
The second column gives the subject number (1 to 30).
The third column gives the Test label (1 to 6).
The other 561 columns give the values of the 561 variables listed in features.

Use grep to extract only the mean measurements and the standard deviation measurements.
This dataset, ReducedDataSetDF, has the same first three columns as DataSetDF, but
  only 79 variable measurements (out of the original 561 measurments).


Next use the merge function to relable the TestLabel column with the corresponding activities.
The corresponding dataframe, called mergedData, has 10299 rows and 82 columns.


Load the plyr package.
Use the ddply function to create the required tidy data set.

The tidy data set, called tidyDataSet, conatains 180 rows (6 activities times 30 subjects) and 81 columns.
The first column gives the activity name, and second give the SubjectLabel, and 
    the other 79 columns give the averages of the measurements for mean and std for the
    Activity in the first column and the Subject in the second column.

Finally, write the tidyDataSet dataframe to the text file tidyDataSet.txt.




