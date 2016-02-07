
#Loading required packages
library(dplyr)
library(data.table)



#reading train  files
X_train_file<-read.table(file = "UCI HAR Dataset/train/X_train.txt")
Y_train_file <-read.table(file = "UCI HAR Dataset/train/y_train.txt")
subject_train_file <-read.table(file = "UCI HAR Dataset/train/subject_train.txt")

#reading test files
X_test_file<-read.table(file = "UCI HAR Dataset/test/X_test.txt")
Y_test_file <-read.table(file = "UCI HAR Dataset/test/y_test.txt")
subject_test_file <-read.table(file = "UCI HAR Dataset/test/subject_test.txt")


#features file 
features<-read.table(file = "UCI HAR Dataset/features.txt")


#1
#Merges the training and the test sets to create one data set.

X_merged <- rbind(X_test_file,X_train_file)
Y_merged<- rbind(Y_test_file,Y_train_file)
subject_merged<- rbind(subject_test_file,subject_train_file)

#adding column names for merged data sets

colnames(X_merged)<- features[,2]
colnames(Y_merged) <- "Activities"
colnames(subject_merged) <- "Participant"

Merged_Data_Set <- cbind(X_merged,Y_merged,subject_merged)

#2
#Extracts only the measurements on the mean and standard deviation for each measurement.

measures_means<- grep("mean()",names(X_merged),value = FALSE,fixed = TRUE)
measures_std<-grep("std()",names(X_merged),value = FALSE,fixed = TRUE)
X_mergedmeans<-X_merged[, measures_means ]
X_mergedstd<-X_merged[, measures_std ]

X_means_std <- cbind(X_mergedmeans,X_mergedstd)

#Merging final data set

Final_Data <- cbind(X_means_std,Y_merged,subject_merged)




#3
#Uses descriptive activity names to name the activities in the data set

activity_labels <- read.table(file = "UCI HAR Dataset/activity_labels.txt")
Final_Data <- merge(Final_Data,activity_labels,by.x = "Activities",by.y = "V1")

Final_Data<-Final_Data[,2:69]
Final_Data<-rename(Final_Data,activity = V2)

#4
#Appropriately labels the data set with descriptive variable names.

#label the partisipants
for (i in 1:30){
        Final_Data$Participant[Final_Data$Participant==i] <- paste("Partisipant",i,sep = " ")
        
}


names(Final_Data) <- gsub("Acc", "Accelerator", names(Final_Data))
names(Final_Data) <- gsub("Mag", "Magnitude", names(Final_Data))
names(Final_Data) <- gsub("Gyro", "Gyroscope", names(Final_Data))
names(Final_Data) <- gsub("^t", "time", names(Final_Data))
names(Final_Data) <- gsub("^f", "frequency", names(Final_Data))



#5
#From the data set in step 4, creates a second, independent tidy data set with
#the average of each variable for each activity and each subject.

tidy_average_data <- ddply(Final_Data, .(Participant, activity), function(x) colMeans(Final_Data[, 1:66]))
write.table(tidy_average_data, "tidy_average_data.txt", row.name=FALSE)



