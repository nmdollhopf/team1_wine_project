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

### What did not work: Linear Regression

linear regression (OLS, box-cox transformation, and lasso) to predict wine quality (treated as a continuous variable) or alcohol content. Most predictors are not normally distributed and could not find a good transformation. There is also a problem with multicollinearity among the predictors. LASSO dropped out all predictors, indicating none are particularly good at prediciting alcohol content (using elastic net, density is the best predictor which makes sense as ethanol is less than water)

### What did work: Support Vector Classification

Linear regression did not work well due to a lack of normality and the presense of multicollinearity among the predictors. Thus, we decided to move forward with a Support Vector Classification (SVC) model that would be less sensitive to these attributes of the data.

Ultimately, we decided to convert the experimental variable, quality, into a binary outcome. Wines with a quality score >= 7 were classified as 'good'. The SVC model was trained on 70% of the data that had been scaled using sklearn's PowerTransformer scaler with the Yeo-Johnson method. This model consistently predicts test data with greater than 98% balanced accuracy, precision, and recall despite imbalance among the two classes. 
