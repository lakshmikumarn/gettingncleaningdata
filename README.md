# About run_analysis.R



1) Intialize data frames loading all data set files individually. It helps to do basic sanity checks like number of rows, column/variable segregation etc. 
Note: Downloading and unzipping the dataset archive is an option that can be considered. But in our script we assume it is done manually.

2) After sanity checks on the loaded data frames are completed modify the script to merge X,Y and Subject data sets for training and test
sets respectively. 

3) Define readable column names for each merged data frame extracting it from features file, second delimited variable.

4) set column names from step 3 to _X, _Y, Subj dataframes created for test and train data sets

5) define column names for activity label data frame

6) Form a de-normalized data frame through cbind for each data frame (training and test) using cbind

7) Merge both de-norm data frame into single data frame/whole set using rbind

8) Extract mean and standard deviation columns along with activity id and subject

9) De normalize activity label (descriptive) and the data frame resulted out of step 8

10) Finally create a dataset that captures mean of each variable, each activity of each subject

11) Write into a file
