## Introduction

This file is used to explain the varibales, the data, and transformations I performed to clean up the data

## Data cleaning procedure

To get the tidy data set:
* 1. Crete a "data" folder if not already created
* 2. Download zip file using direct download from link
* 3. Unzip the file to "data" folder
* 4. Set working directory to "data" folder
* 5. Load data from files (train, test, subject and features files)
* 6. Merge training data and test data and store the data in dataframe "MergedData" 
* 7. Load the measurements file and create a vector "feature" to store the measurements
* 8. Extract mean and std measurements and modify the vector "feature" with only the extracted measurements
* 9. Create a new dataframe "NewDate" contains columns with only the extracted measurements
* 10. Rename columns of "NewData" with "feature"
* 11. Convert activity value to activity names (based on activity_labels.txt file)
* 12. Label the "NewData" with descriptive variable names:
	* For all columns start with "t", transform "t" to "Time"
	* For all columns start with "f", transform "f" to "Frequency"	
	* For all columns contain "-mean", transform "-mean" to "Mean"
	* For all columns contain "-std", transform "-std" to "Std"
	* For all colunms contain "()", delete "()"
* 13. Transform "NewData" with the keys are subject and activity, the other variables are calculated by mean
* 14. Create a new dataframe "TidyData" based on "NewData"
* 15. Export the "TidyData" dataframe to a text file named "TidyData.txt" in the same folder with run_analysis.R file
