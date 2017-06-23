

relUrl <- "~ /coursera/datascience/Data-cleaning/week4/UCI-HAR-Dataset"


## intialize data frames and load all data sets.
## Merging data at file level is another option. For portability and scriptability in R merge performed at data frames level

  setwd(relUrl)
  ptm <- proc.time()
  print(paste("<<<< Loading time starts",ptm))
  
  
  ## Load Training data sets (Tr prefixed)
  ## Load all files to do basic sanity checks
  
  # Tr_body_acc_x <- read.csv("./train/InertialSignals/body_acc_x_train.txt", sep="", header = FALSE)
  # Tr_body_acc_y <- read.csv("./train/InertialSignals/body_acc_y_train.txt", sep="", header = FALSE)
  # Tr_body_acc_z <- read.csv("./train/InertialSignals/body_acc_z_train.txt", sep="", header = FALSE)
  # Tr_body_gyr_x <- read.csv("./train/InertialSignals/body_gyro_x_train.txt", sep="", header = FALSE)
  # Tr_body_gyr_y <- read.csv("./train/InertialSignals/body_gyro_y_train.txt", sep="", header = FALSE)
  # Tr_body_gyr_z <- read.csv("./train/InertialSignals/body_gyro_z_train.txt", sep="", header = FALSE)
  # Tr_tot_acc_x <- read.csv("./train/InertialSignals/total_acc_x_train.txt", sep="", header = FALSE)
  # Tr_tot_acc_y <- read.csv("./train/InertialSignals/total_acc_y_train.txt", sep="", header = FALSE)
  # Tr_tot_acc_z <- read.csv("./train/InertialSignals/total_acc_z_train.txt", sep="", header = FALSE)
  
  Tr_subj <- read.csv("./train/subject_train.txt", sep="", header = FALSE)
  Tr_X <- read.csv("./train/X_train.txt", sep="", header = FALSE)
  Tr_Y  <- read.csv("./train/y_train.txt", sep="", header = FALSE)
  
  features <- read.csv("./features.txt", sep="", header = FALSE)
  actLabels <- read.csv("./activity_labels.txt", sep="", header = FALSE)

  ## Load test data sets (T prefixed)
  ## Load all files to do basic sanity checks
  
  # T_body_acc_x <- read.csv("./test/InertialSignals/body_acc_x_test.txt", sep="", header = FALSE)
  # T_body_acc_y <- read.csv("./test/InertialSignals/body_acc_y_test.txt", sep="", header = FALSE)
  # T_body_acc_z <- read.csv("./test/InertialSignals/body_acc_z_test.txt", sep="", header = FALSE)
  # T_body_gyr_x <- read.csv("./test/InertialSignals/body_gyro_x_test.txt", sep="", header = FALSE)
  # T_body_gyr_y <- read.csv("./test/InertialSignals/body_gyro_y_test.txt", sep="", header = FALSE)
  # T_body_gyr_z <- read.csv("./test/InertialSignals/body_gyro_z_test.txt", sep="", header = FALSE)
  # T_tot_acc_x <- read.csv("./test/InertialSignals/total_acc_x_test.txt", sep="", header = FALSE)
  # T_tot_acc_y <- read.csv("./test/InertialSignals/total_acc_y_test.txt", sep="", header = FALSE)
  # T_tot_acc_z <- read.csv("./test/InertialSignals/total_acc_z_test.txt", sep="", header = FALSE)
  
  T_subj <- read.csv("./test/subject_test.txt", sep="", header = FALSE)
  T_X <- read.csv("./test/X_test.txt", sep="", header = FALSE)
  T_Y  <- read.csv("./test/y_test.txt", sep="", header = FALSE)

 
  # Combine T_X and T_Y (activity and labels) and respective Training data
  
  colnames(Tr_X) <- features[,2] 
  colnames(Tr_Y) <-"activityId"
  colnames(Tr_subj) <- "subjectId"
  
  colnames(T_X) <- features[,2] 
  colnames(T_Y) <-"activityId"
  colnames(T_subj) <- "subjectId"
  
  colnames(actLabels) <- c('activityId','activityType')
  
  # Merge the Training data sets , test data sets individually and then merge those finally
  
  mergeTrain <- cbind(Tr_Y, Tr_subj,Tr_X )
  mergeTest <- cbind(T_Y, T_subj,T_X )
  mergeAll <- rbind(mergeTrain, mergeTest)
  
  colN <- colnames(mergeAll)
  
  meanNstd <- (grepl("activityId" , colN) | 
                     grepl("subjectId" , colN) | 
                     grepl("mean.." , colN) | 
                     grepl("std.." , colN))
  
  subMeanNStd <- mergeAll[ , meanNstd == TRUE]
  
  # Merge activity labels to make activity id readable
  
  expandActivityLabel <- merge(subMeanNStd, actLabels,
                                by='activityId',
                                all.x=TRUE)
  
  # find the mean for each activity by each subject
  tidyFinal <- aggregate(. ~subjectId + activityId, expandActivityLabel, mean)
  tidyFinal <- tidyFinal[order(tidyFinal$subjectId, tidyFinal$activityId),]
  
  # Write the data to a file.
  write.table(tidyFinal, "tidyFinal.txt", row.name=FALSE)
  
  ptm <- proc.time() - ptm
  print(paste("Loading time ends >>>",ptm))
  
  
  
