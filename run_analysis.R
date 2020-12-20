## Set de directory
setwd('/Users/gustavoruizbuendia/Documents/Gustavo Ruiz/R data science/gettingandcleaningdata/gettingandcleaningdata')

## Install, and load the package data.table in order to read the files
install.packages('data.table')
library(data.table)
install.packages('dplyr')
library(dplyr)

##Reading the columns (features.txt) and activities (activity_labels.txt)
features<-fread('features.txt')
activity<-fread('activity_labels.txt')

##Asign names to the columns of activity
colnames(activity)<-c('activityNumber','activityName')

##Identify de rows of features that corresponds to mean() or std()
validcolumns<-grep('mean\\(\\)|std\\(\\)', features$V2)

## Reading the raw data into R and converting into data.table
##with the comand read.table('train/X_train.txt')[,validcolumns] extracts
##only the columns with mean() and std() information
train<-cbind(read.table('train/subject_train.txt'),read.table('train/y_train.txt'),
             read.table('train/X_train.txt')[,validcolumns])
colnames(train)<-c('subject','activity',features$V2[validcolumns])
train<-as.data.table(train)
test<-cbind(read.table('test/subject_test.txt'),read.table('test/y_test.txt'),
             read.table('test/X_test.txt')[,validcolumns])
colnames(test)<-c('subject','activity',features$V2[validcolumns])
test<-as.data.table(test)

##Insert a new columnd that identify weather the observation is train or test
test[,typedata:='test']
train[,typedata:='train']

##Create the new table with the data of train and test in one variable
total<-rbind(test,train)

##Merge the total data with the activudy identifier to define a new column
##activutName that set the descriptive name of the acitivity
total<-merge(activity,total, by.x='activityNumber',by.y = 'activity')

##Change the column name in order to have a total descriptive name
colnames(total)<-sub('Mag','magnitude',
                     sub('^f','fouriertransform',
                         sub('Gyro','gyroscope',
                             sub('Acc','accelerometer',
                                 sub('std\\(\\)','standardeivation',
                                     sub('mean\\(\\)','mean',
                                         sub('^tG','timeG',
                                             sub('^tB','timeB',
                                                 gsub('-','',colnames(total))))))))))
##save the tidy data in a .txt file
write.table(total,'runAnalysisMeanStandardDeviation.txt')

##Grouping the data by subject and actvity to crate the tidy dataset
subjectActivity<-group_by(total,activityName,subject)
dataColumnNames<-colnames(subjectActivity)

##calculate the mean for the first variable
meanSubjectActivity<-summarize(subjectActivity, mean(.data[[dataColumnNames[4]]]))
for (i in 5:length(dataColumnNames)-1){
  ##create the summary per column and merge with the previous
  meanSubjectActivity<-merge(meanSubjectActivity,summarize(subjectActivity, mean(.data[[dataColumnNames[i]]])))
}

##Change the column name in order to have a total descriptive name
colnames(meanSubjectActivity)<-sub('\\"\\]\\]\\)','',
                                     sub('\\(\\.data\\[\\[\\"','',colnames(meanSubjectActivity)))
##save the tidy data in a .txt file
write.table(meanSubjectActivity,'runAnalysisMeanByActivutyandSubject.txt')
