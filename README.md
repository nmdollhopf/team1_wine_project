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

# Initial website for displaying graphs for Wine Quality anlaysis

## List of Graphs

### Distributions of data set (raw data or infamily data)

   -Distributions of physicochemical properties of red wine

   -Distributions of physicochemical properties of white wine

### Unsupervised learning model-K-means (prediction of red or white wine based on physicochemical properties) secondary analysis

#### Selected scatterplots of physicochemical properites showing clear separation of red vs white wines

    -scatter plot #1 
    -scatter plot #2
    -scatter plot #3

#### Accuracy Scores

    -unsupervised Kmeans confusion matrix

### Supervised learning model (prediction of quality of wine  based on physicochemical properties) primary analysis

#### logit model; Quality binned into (5) outcomes 3-4,5,6,7,8-9 (note red wine does not have 9)

    -confusion matrix for red wine 
    -confusion matrix for white wine 
    

#### SVC model; Quality binned into (3) outcomes 3-4, 5-7, 8-9 (note red wine does not have 9) REMOVE

    -confusion matrix for red wine
    -confusion matrix for white wine 
   

### Optimized SVC model; Quality binned into (2-binary) outcomes 3-5, 6-9 (note red wine does not have 9)- confirm split

    -confusion matrix for red wine (image pending)
    -confusion matrix for white wine (image pending)
    -confusion matrix for combined white and red wine (image pending)
























