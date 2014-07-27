# check for and install reshape if needed.
pkg <- "reshape2"
if (!require(pkg, character.only = TRUE)) {
  +     install.packages(pkg)
  +     if (!require(pkg, character.only = TRUE)) 
    +         stop(paste("Load failure: ", pkg))
  + }

# Create Directories for database (DBD),datatest(DED) and dataTrain(DTD)
DBD <- "./UCI HAR Dataset/"
DED<- "./UCI HAR Dataset/test/"
DTD<- "UCI HAR Dataset/train/"

activities <- read.table(paste0(DBD, "activity_labels.txt"), header=FALSE, stringsAsFactors=FALSE)
features <- read.table(paste0(DBD, "features.txt"), header=FALSE, stringsAsFactors=FALSE)
# Import DED Data into R 
subject_test <- read.table(paste0(DED, "subject_test.txt"), header=FALSE)
x_test <- read.table(paste0(DED, "X_test.txt"), header=FALSE)
y_test <- read.table(paste0(DED, "y_test.txt"), header=FALSE)
tmp <- data.frame(Activity = factor(y_test$V1, labels = activities$V2))
testData <- cbind(tmp, subject_test, x_test)

# Import DTD Data into R
subject_train <- read.table(paste0(DTD, "subject_train.txt"), header=FALSE)
x_train <- read.table(paste0(DTD, "X_train.txt"), header=FALSE)
y_train <- read.table(paste0(DTD, "y_train.txt"), header=FALSE)
tmp <- data.frame(Activity = factor(y_train$V1, labels = activities$V2))
trainData <- cbind(tmp, subject_train, x_train)

# Create Tidy data (FTD) from Temp Tiny Data (TTD) from existing Data sets
TTD <- rbind(testData, trainData)
names(TTD) <- c("Activity", "Subject", features[,2])
select <- features$V2[grep("mean\\(\\)|std\\(\\)", features$V2)]
FTD <- TTD[c("Activity", "Subject", select)]

# Write Temp Tiday data to disk
write.table(FTD, file="./FTD.txt", row.names=FALSE)

# FTD Melt (TDM) and Cast (TDC)
TDM <- melt(FTD, id=c("Activity", "Subject"), measure.vars=select)
TDC <- dcast(TDM, Activity + Subject ~ variable, mean)

# Write average data
write.table(tidyDataMean, file="./tidyAverageData.txt", row.names=FALSE)


