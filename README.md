# team1_wine_project
Final Project of Wine Classification for the UNC Data Analytics Bootcamp

## Objective
Wine quality assessments are often based on the opinions connoisseurs which some consider to be highly subjective. We think it would be interesting to determine if the physicoshemical properties of wine can be used to predicts its color (red or white) and quality (poor or high). To accomplish this, we plan to use K-Means clusting and Support Vector Classification (SVC) machine learning methods.

## Data

Our data was obtained from the University of California, Irvine (UCI) Machine Learning repository. This data is also available on Kaggle.com. This data is already nicely organized in csv format, which serves as our database.

https://archive.ics.uci.edu/ml/datasets/wine+quality

https://www.kaggle.com/datasets/uciml/red-wine-quality-cortez-et-al-2009

This dataset contains 1599 red wine observations and 4898 whinte wine observations of the following 12 factors:
   1 - fixed acidity
   2 - volatile acidity
   3 - citric acid
   4 - residual sugar
   5 - chlorides
   6 - free sulfur dioxide
   7 - total sulfur dioxide
   8 - density
   9 - pH
   10 - sulphates
   11 - alcohol
   Output variable (based on sensory data): 
   12 - quality (score between 0 and 10)

## Catherine's work so far

### What did not work

linear regression (OLS, box-cox transformation, and lasso) to predict alcohol content. Most predictors are not normally distributed and could not find a good transformation. There is also a problem with multicollinearity among the predictors. LASSO dropped out all predictors, indicating none are particularly good at prediciting alcohol content (using elastic net, density is the best predictor which makes sense as ethanol is less than water)

### What to try next

A method that does not require the same assumptions as linear regression, e.g. support vector machines. Right now, trying to use SVM to classify good wines (quality > 6) vs bad wines (quality < 7).

for a good youtube series on SVM and other ML methods, checkout StatQuest!
