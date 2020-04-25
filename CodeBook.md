# Code Book
The R script, run_analysis.R, will perform data preparation and do the 5 steps as required by course project requirements. 
- **Download the dataset**

  -Data was downloaded and extracted under the folder called "UCI HAR Dataset"
- **Assign each data to variables**

        feat <- "feactures.txt" : 561 rows, 2 column
    
Data in features come from accelerometer and gyroscope 3-acial raw signals tAcc-XYZ and tGyro-XYZ.
     
        activity <- activity_labels.txt : 6 rows, 2 columns 
    
Activities performed when measurments taken in the form of a list. 
    
        test_subject <- test/subject_test.txt : 2497 rows, 1 column 
    
Test data of 9 volunteer test subjects being observed from the 30 volunteers.

        xtest <- test/X_test.txt : 2947 rows, 561 columns 
 
Test data

        ytest <- test/y_test.txt : 2947 rows, 1 columnn
       
Test data 2 
    
        subjecttrainset <- test/subject_train.txt : 7352 rows, 1 column 

Train data of remaining 21 volunteers 
        
        xtrain <- test/X_train.txt : 7352 rows, 561 columns 

Train data 

        ytrain <- test/y_train.txt : 7352 rows, 1 column

Train data 2

- **Merging codes for training set and test set**
     
     - X (10299 rows, 561 columns) : merges *xtrain* and *xtest* by **rbind()** function 
      
     - Y (10299 rows, 1 column) : merges *ytrain* and *ytest* by **rbind()** function
     
     - Subject (10299 rows, 1 column) : merges *subjecttrainset* and *test_subject* by **rbind()** function
    
     - MergedData (10299 rows, 563 columns) : merges X, Y and Subject with **cbind()** function 
      
- **Extracting each measurement on mean and standard deviation** 
 
      - BeautifulData (10299 rows, 88 columns) subsets MergedData by selecting columns subject, code and measuring mean and standard deviation 
      
- **Descriptive activity names to name activities**
      
      -Code column in BeautifulData is replaced with activity in activities variable 
      
-**Label the data with descriptive variable names 

      -Code column in BeautifulData renamed into activity 
      
      -All 'Acc' is now 'accelerometer' 
      
      -All 'Gyro' is now 'gyroscope'
      
      -All 'BodyBody' is now 'body' 
      
      -All 'Mag' is now 'magnitude'
      
      -All '^f' characters in column name is 'frequency'
      
      -All '^t' characters in column name is 'time'
      
-**Second, indepdent data set made with average of each variable for each activity and each subject**

      -FinalData (180 rows, 88 columns) summarizes BeautifulData by taking mean of each acitivity and subject 
      
      -Export 'FinalData' into 'FinalData.txt' file
  
      -
