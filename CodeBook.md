# Introduction

The script `run_analysis.R`performs the 5 steps described in the course project's definition.

* First, all the similar data is merged using the `rbind()` function. By similar, we address those files having the same number of columns and referring to the same entities.
* Then, only those columns with the mean and standard deviation measures are taken from the whole dataset. After extracting these columns, they are given the correct names, taken from `features.txt`.
* As activity data is addressed with values 1:6, we take the activity names and IDs from `activity_labels.txt` and they are substituted in the dataset.
* On the whole dataset, those columns with vague column names are corrected.
* Finally, we generate a new dataset with all the average measures for each subject and activity type (30 subjects * 6 activities = 180 rows). The output file is called `tidy_average_data.txt`, and uploaded to this repository.


# Variables

* `x_train_file`, `y_train_file`, `x_test_file`, `y_test_file`, `subject_train_file` and `subject_test_file` contain the data from the downloaded files.
* `X_merged`, `Y_merged` and `subject_merged` merge the previous datasets to further analysis.
* `features` contains the correct names for the `X_merged` dataset, which are applied to the column names stored in `mean_and_std_features`, a numeric vector used to extract the desired data.
* A similar approach is taken with activity names through the `activities` variable.
* `all_data` merges `X_merged`, `Y_merged` and `subject_merged` in a big dataset.
* Finally, `tidy_average_data` contains the relevant averages which will be later stored in a `.txt` file. 

# Explanation of Files Used
* activity_labels.txt - Lists each activity with ID.
* features.txt - List of the 561 features.
* subject_test.txt - Vector of 2947 integers, showing the volunteer ID related to the observations in X_test.txt.
* subject_train.txt - Vector of 7352 integers, showing the volunteer ID related to the observations in X_train.txt.
* X_test.txt - 2947 observations of the 561 features, for 9 of the 30 volunteers.
* X_train.txt - 7352 observations of the 561 features, for 21 of the 30 volunteers.
* y_test.txt - A vector of 2947 integers, showing the activity ID related to the observations in X_test.txt.
* y_train.txt - A vector of 7352 integers, showing the activity ID related to the observations in X_train.txt.