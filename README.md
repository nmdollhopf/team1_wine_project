# team1_wine_project
Final Project of Wine Classification for the UNC Data Analytics Bootcamp

Note: Project Readme file currently located in Team member Browning Wipper's Branch

Week 1 Notes:

Data Set:

https://www.kaggle.com/datasets/uciml/red-wine-quality-cortez-et-al-2009

https://archive.ics.uci.edu/ml/datasets/wine+quality

Intial Data files:

winequality-red.csv
winequality-white.csv

Exploratory analysis:

read in datafiles
coverted to csv (was ";" delimited)
cleaned up naming of columns (removed quotes and added _ to replace spaces)
checked column data types
checked for Null values
remove outliers (entire row) for extreme outliers (3*IQR)
added column (wine type) to each file
concatenated red and white wine files
box plots
historgrams
scatter plots
heat maps (to observe correlations)
distributions