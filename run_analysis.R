# Returns one data set by reading and merging all component files.
parseData <- function(fileName, path) {
        
        # read the y date file
        fpath <- file.path(path, paste0("y_", fileName))
        # just get the acitiy id
        y_data <- read.table(fpath, header=F, col.names=c("ActivityID"))
        #append the acity label
        y_data[,2] = activity_labels[y_data[,1]]
        names(y_data) = c("ActivityID", "ActivityLabel")
        
        # read the X data file
        fpath <- file.path(path, paste0("X_", fileName))
        # get the measurements
        data <- read.table(fpath, header=F, col.names=feature_columns$MeasureName)
        
        # read the subject file
        fpath <- file.path(path, paste0("subject_", fileName))
        # get the sbuject id
        subject_data <- read.table(fpath, header=F, col.names=c("SubjectID"))
        
        
        # names of subset columns required
        subset_data_cols <- grep(".*mean\\(\\)|.*std\\(\\)", feature_columns$MeasureName)
        
        # subset the data
        data <- data[,subset_data_cols]
        
        # append the activity id and subject id columns
        data$ActivityID <- y_data$ActivityID
        data$ActivityLabel<- y_data$ActivityLabel
        data$SubjectID <- subject_data$SubjectID
        
        # return the data
        data
}

# read test data set
parseTestData <- function() {
        parseData("test.txt", "test")
}

# read test data set
parseTrainData <- function() {
        parseData("train.txt", "train")
}

# merge
mergeData <- function() {
        # read the column names
        rbind(parseTestData(), parseTrainData())
}

# Create a tidy data set 
createTidyFile <- function(data) {
        if (!require("reshape2")) {
                install.packages("reshape2")
        }
       
        require("reshape2")
        # melt the dataset
        id_vars = c("ActivityID", "ActivityLabel", "SubjectID")
        measure_vars = setdiff(colnames(data), id_vars)
        melted_data <- melt(data, id=id_vars, measure.vars=measure_vars)
        tidy_data=dcast(melted_data, ActivityLabel + SubjectID ~ variable, mean)  
        write.table(tidy_data, "tidy.txt",row.name=FALSE)
}
# read features
feature_columns <- read.table("features.txt", header=F, as.is=T, col.names=c("MeasureID", "MeasureName"))
# read activity label
activity_labels <- read.table("activity_labels.txt")[,2]
createTidyFile(mergeData())


