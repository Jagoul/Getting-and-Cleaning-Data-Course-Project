# Getting and Cleaning Data - Course Project

This project contains the following code `Clean_DataSet.R` that executes the following tasks:

1. Download the dataset,if it does not exist in the working directory
2. Load the activity and features
3. Loads training and test datasets, extracting only columns which
   reflect a mean or standard deviation
4. Loads the activity and subject data for each dataset, and merges those
   columns with the dataset
5. Merges the two datasets
6. Converts the `activity` and `subject` columns into factors
7. Creates a tidy dataset that consists of the average (mean) value of each
   variable for each subject and activity pair.

The end result is shown in the file `Tidy DataSet.txt`.
