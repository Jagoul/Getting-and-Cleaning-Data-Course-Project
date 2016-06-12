# prepare reshape library to use melt and aggregate data 
library(reshape2)

MyDataSet <- "getdata_dataset.zip"

## Download and unzip the targeted dataset:
if (!file.exists(MyDataSet)){
  filePath <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip "
  download.file(filePath, MyDataSet, method="libcurl")
}  
if (!file.exists("UCI HAR Dataset")) { 
  unzip(MyDataSet) 
}

# Get Activity Labels and features 
labels <- read.table("UCI HAR Dataset/labels.txt")
labels[,2] <- as.character(labels[,2])
feature <- read.table("UCI HAR Dataset/feature.txt")
feature[,2] <- as.character(feature[,2])

# Get mean and standard deviation
myFeature <- grep(".*mean.*|.*std.*", feature[,2])
myFeature.names <- features[myFeature,2]
myFeature.names = gsub('-mean', 'Mean', myFeature.names)
myFeature.names = gsub('-std', 'Std', myFeature.names)
myFeature.names <- gsub('[-()]', '', myFeature.names)


# Load the datasets
xtrain <- read.table("UCI HAR Dataset/train/X_train.txt")[myFeature]
trainActivities <- read.table("UCI HAR Dataset/train/Y_train.txt")
trainSubjects <- read.table("UCI HAR Dataset/train/subject_train.txt")
xtrain <- cbind(trainSubjects, trainActivities, xtrain)

temp <- read.table("UCI HAR Dataset/test/X_test.txt")[myFeature]
tempActivities <- read.table("UCI HAR Dataset/test/Y_test.txt")
tempSubjects <- read.table("UCI HAR Dataset/test/subject_test.txt")
temp <- cbind(testSubjects, testActivities, temp)

# append all datasets and label all columns
allData <- rbind(train, test)
colnames(allData) <- c("subject", "activity", myFeature.names)

# turn activities & subjects into factors
allData$activity <- factor(allData$activity, levels = labels[,1], labels = labels[,2])
allData$subject <- as.factor(allData$subject)

allData.melted <- melt(allData, id = c("subject", "activity"))
allData.mean <- dcast(allData.melted, subject + activity ~ variable, mean)

write.table(allData.mean, "tidy.txt", row.names = FALSE, quote = FALSE)