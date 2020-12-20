# gettingandcleaningdata
---------------------------
This repository contains the deliverables for the "getting and cleaning data" course from coursera
---------------------------
Created by: Gustavo Andrés Ruiz
Getting and Cleaning data Courser course

----------------------------

This project consist in getting the data provided in the course and create two tidy
data sets with certain characteristics.

The core of the project is to load into R the data of:
1. X_train.txt: only the columns that contains information about means and standar
  deviation.
2. y_train.txt
3. subject_train.txt
4. X_test.txt: only the columns that contains information about means and standar
  deviation.
5. y_test.txt
6. subject_test.txt

After cleaning the data in terms of defining descriptive names for the columns
and some variables, the first data set is created.

The las part of the project consist in generate a new tidy data set that
summarize calculating the mean of the variables in data set 1, grouped by
activiy and subject.

------------------------------------------
Beyond the originals files, this repository contains the following
1. run_analysis.R: this R file contain the complete script that generate the .txt
  files. In this files the reader can replicate the work doing by the author in
  order to generate the files. the.R file contains some remarks that helps to follow
  the code. It is possible that other person can program the task in a different way
  that is the reason why every single lines is explained.
2. runAnalysisMeanStandarDeviation.txt: this file contains the tiny data set number
  in which the original data is presented only showing the columns corresponding
  to the means and standar deviation variables of the original data, an unified
  data between train and test, and the descriptive name of each activity. The
  explanation of each variable of this file can be find in codeBook.txt
3. runAnalysisMeanByActivutyabndSubject.txt: this .txt file contins de tiddy data
   number 2. This file has, for each activity and subject, the mean of the variables
   of the data set number 1. The explanation of each variable of this file can be      find in codeBook.txt
4. codeBook.txt: contains the definition of each of the columns in each of the new
   data det generated.