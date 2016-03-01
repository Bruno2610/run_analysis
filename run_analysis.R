#course project:

#reading test archives
s_test<-read.table("subject_test.txt")
x_test<-read.table("x_test.txt")
y_test<-read.table("y_test.txt")
feat<-read.table("features.txt")
names<-as.character(feat[,2])
names<-gsub("tBody"," ",names)
names<-gsub("tGravity"," ",names)
names<-gsub("fBodyAcc"," ",names)
names<-gsub("fBodyGyro"," ",names)
names<-gsub("fBodyBodyGyro"," ",names)
names<-gsub("fBodyBody"," ",names)
names<-gsub("^ -","",names)
names<-gsub("^ ","",names)

#reading train archives
s_train<-read.table("subject_train.txt")
x_train<-read.table("x_train.txt")
y_train<-read.table("y_train.txt")

#puts the data together
test<-cbind(s_test,x_test,y_test)
train<-cbind(s_train,x_train,y_train)
#number of columns
ntest<-ncol(test)
ntrain<-ncol(train)
#calculates means and standard deviations
means_test<-apply(test[2:ntest-1],2,mean)
means_train<-apply(train[2:ntrain-1],2,mean)
sd_test<-apply(test[2:ntest-1],2,sd)
sd_train<-apply(train[2:ntrain-1],2,sd)
means<-cbind(means_test,means_train)
write.table(means,file="./means",row.names=FALSE,col.names=TRUE)


