

## Assumed:
## the program starts from the UCI HAR Dataset-folder
## as the working directory.
## For changing working directory:
## setwd("???/UCI HAR Dataset/")
## getwd()


## 1. Merge Training- and Test-Data
########################################################

### Load activity-labels, Initialization
actLab <- read.table("./activity_labels.txt")
subject <- 1:30
activities <- 1:6

### Load Test-Data 
TE1 <- read.table("./test/X_test.txt")
TE1y <- read.table("./test/y_test.txt")
TE1subject <- read.table("./test/subject_test.txt")

### Merging training activity number with description
### this is indeed part 3. of the exercise
TE1y <- merge(TE1y, actLab, by.x="V1", by.y="V1", all=F, sort=F)

### cbind all Test-Data
TE <- cbind(TE1subject, (cbind(TE1y, TE1)))

### load and cbind Train-Data 
TR1 <- read.table("./train/X_train.txt")
TR1y <- read.table("./train/y_train.txt")
TR1subject <- read.table("./train/subject_train.txt")

### Merging training activity number with description
### this is indeed part 3. of the exercise
TR1y <- merge(TR1y, actLab, by.x="V1", by.y="V1", all=F, sort=F)
TRsubject = rbind(TE1subject, TR1subject)

### cbind all Train-Data
TR <- cbind(TR1subject, (cbind(TR1y, TR1)))

### rbind Test- and Train-Data, add Column-Names
T <- rbind (TE, TR)
colnames(T)[1:3] <- c("Subject", "ActivityNr", "Activity")

## 2. Extracts only the measurements on the mean and
##    standard deviation for each measurement
########################################################

T_Extraction <- T[, c("Subject", "ActivityNr", "Activity",
                      "V1", "V2","V3","V4","V5","V6","V41",
                      "V42","V43","V44","V45","V46","V81",
                      "V82","V83","V84","V85","V86","V121",
                      "V122","V123","V124","V125","V126",
                      "V161","V162","V163","V164","V165",
                      "V166","V201","V202","V214","V215",
                      "V227","V228","V240","V241","V253",
                      "V254","V266","V267","V268","V269",
                      "V270","V271","V345","V346","V347",
                      "V348","V349","V350","V424","V425",
                      "V426","V427","V428","V429","V503",
                      "V504","V516","V517","V529","V530",
                      "V542","V543")]


## 3. Uses descriptive activity names to name the
##    activities in the data set 
########################################################
## done in part 1. already.

## 4. Appropriately labels the data set with descriptive
##    activity names.
########################################################

### The columns were named with the variable number and name given.
### The number is for better reference.

names(T_Extraction)[4:ncol(T_Extraction)] <- c("1-tBodyAcc-mean()-X", "2-tBodyAcc-mean()-Y",
      "3-tBodyAcc-mean()-Z", "4-tBodyAcc-std()-X", "5-tBodyAcc-std()-Y", "6-tBodyAcc-std()-Z",
      "41-tGravityAcc-mean()-X", "42-tGravityAcc-mean()-Y", "43-tGravityAcc-mean()-Z",
      "44-tGravityAcc-std()-X", "45-tGravityAcc-std()-Y", "46-tGravityAcc-std()-Z",
      "81-tBodyAccJerk-mean()-X", "82-tBodyAccJerk-mean()-Y", "83-tBodyAccJerk-mean()-Z",
      "84-tBodyAccJerk-std()-X", "85-tBodyAccJerk-std()-Y", "86-tBodyAccJerk-std()-Z",
      "121-tBodyGyro-mean()-X", "122-tBodyGyro-mean()-Y", "123-tBodyGyro-mean()-Z",
      "124-tBodyGyro-std()-X", "125-tBodyGyro-std()-Y", "126-tBodyGyro-std()-Z",
      "161-tBodyGyroJerk-mean()-X", "162-tBodyGyroJerk-mean()-Y", "163-tBodyGyroJerk-mean()-Z",
      "164-tBodyGyroJerk-std()-X", "165-tBodyGyroJerk-std()-Y", "166-tBodyGyroJerk-std()-Z",
      "201-tBodyAccMag-mean()", "202-tBodyAccMag-std()", "214-tGravityAccMag-mean()",
      "215-tBodyGravityAccMag-std()", "227-tBodyAccJerkMag-mean()", "228-tBodyAccJerkMag-std()",
      "240-tBodyGyroMag-mean()", "241-tBodyGyroMag-std()", "253-tBodyGyroJerkMag-mean()",
      "254-tBodyGyroJerkMag-std()", "266-fBodyAcc-mean()-X", "267-fBodyAcc-mean()-Y", "268-fBodyAcc-mean()-Z",
      "269-fBodyAcc-std()-X", "270-fBodyAcc-std()-Y", "271-fBodyAcc-std()-Z", "345-fBodyAccJerk-mean()-X",
      "346-fBodyAccJerk-mean()-Y", "347-fBodyAccJerk-mean()-Z", "348-fBodyAccJerk-std()-X",
      "349-fBodyAccJerk-std()-Y", "350-fBodyAccJerk-std()-Z", "424-fBodyGyro-mean()-X",
      "425-fBodyGyro-mean()-Y", "426-fBodyGyro-mean()-Z", "427-fBodyGyro-std()-X",
      "428-fBodyGyro-std()-Y",  "429-fBodyGyro-std()-Z",  "503-fBodyAccMag-mean()",
      "504-fBodyAccMag-std()",  "516-fBodyBodyAccJerkMag-mean()", "517-fBodyBodyAccJerkMag-std()",
      "529-fBodyBodyGyroMag-mean()", "530-fBodyBodyGyroMag-std()", "542-fBodyBodyGyroJerkMag-mean()",
      "543-fBodyBodyGyroJerkMag-std()")



## 5. Creates a second, independent tidy data set with
##    the average of each variable for each activity and
##    each subject
########################################################

subject_activity_average <- data.frame()

for (k in subject) {
  for (l in activities) {
    T4 <- T_Extraction[(T_Extraction$Subject==k & T_Extraction$ActivityNr==l),]
    
    if (nrow(T4) > 0) {
      meanT4 <- apply(T4[,4:ncol(T4)], 2, mean)
      xy <- data.frame(k, l, actLab[l, "V2"], t(meanT4))
      subject_activity_average <- rbind(subject_activity_average, xy)
    }
  }
}
names(subject_activity_average) <- names(T_Extraction)

### save Summary-Data
write.table(subject_activity_average, "subject_activity_average.txt")
### a short look on the data
print(subject_activity_average[1:10, 1:6])
########################################################





