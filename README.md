## Analysis of Wearable Data

(A Programming Exercise in R)
=============================

This program loads all data measured and generates a brief
summary. In detail the following is happening:

* The run_analysis.R program loads all the data from the train-
and test-folder.

* This data will be merged in only one file by run_analysis.R,
additionally the columns will be named according to the 
activities, and an additional column with the name of the 
activities is merged.

* From this file only the subject-, activities-, and means-columns
are selected. The means-columns comprises numeric values,
which were calculated from other measurement data earlier.

* Finally for each participant/activity-pair all the means of the
data are calculated and saved in a cleaned file.









