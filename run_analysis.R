#course project:

#load test data  
subject_test<-read.table("subject_test.txt")
X_test<-read.table("X_test.txt")
Y_test<-read.table("Y_test.txt")
  
#load training data
subject_train<-read.table("subject_train.txt")
X_train<-read.table("X_train.txt")
Y_train<-read.table("Y_train.txt")
  
#load lookup information
features<-read.table("features.txt", col.names=c("featureId", "featureLabel"))
activities<-read.table("activity_labels.txt", col.names=c("activityId", "activityLabel"))
activities$activityLabel<-gsub("_", "", as.character(activities$activityLabel))
includedFeatures<-grep("-mean\\(\\)|-std\\(\\)", features$featureLabel)
  
#merge test and training data and name then
subject<-rbind(subject_test, subject_train)
names(subject)<-"subjectId"
X<-rbind(X_test, X_train)
X<-X[, includedFeatures]
names(X)<-gsub("\\(|\\)", "", features$featureLabel[includedFeatures])
Y<-rbind(Y_test, Y_train)
names(Y)<-"activityId"
activity<-merge(Y, activities, by="activityId")$activityLabel
  
#merge data frames of different columns to form one data table
data<-cbind(subject, X, activity)
write.table(data, "merged_tidy_data.txt")
  
#create a dataset grouped by subject and activity with the recquired information (mean and sd)
library(data.table)
dataDT<-data.table(data)
calculatedData<-dataDT[, lapply(.SD, mean), by=c("subjectId", "activity")]
write.table(calculatedData, "calculated_data.txt")
