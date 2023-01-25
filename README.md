# team1_wine_project
Final Project of Wine Classification for the UNC Data Analytics Bootcamp


Define the columns and the data inside them. 

## Catherine

### What did not work

linear regression (OLS, box-cox transformation, and lasso) to predict alcohol content. Most predictors are not normally distributed and could not find a good transformation. There is also a problem with multicollinearity among the predictors. LASSO dropped out all predictors, indicating none are particularly good at prediciting alcohol content (using elastic net, density is the best predictor which makes sense as ethanol is less than water)

### What to try next

A method that does not require the same assumptions as linear regression, e.g. support vector machines. Right now, trying to use SVM to classify good wines (quality > 6) vs bad wines (quality < 7).

for a good youtube series on SVM and other ML methods, checkout StatQuest!
