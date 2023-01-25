# team1_wine_project
Final Project of Wine Classification for the UNC Data Analytics Bootcamp

klaus' initial works

## Unsupervised K-Means Clustering

initial_unsupervised_clustering.ipynb

### question  

Red and white wines are different... right? We know they are, but can a computer tell the difference? How accurate is an unbiased KMeans clustering algorithm in separating red and white wines based on 11 measured chemical properties?  

### rough methodology

scikitlearn's KMeans class

- read in data. add 'r' and 'w', for red and white, designations to each dataframe. removed quality columns since it is superfluous to the unsupervised clustering
- combined the two dataframes into a single dataframe
- scaled the data in 3 ways. i wasn't sure which would give the most interesting results, so i tried all of them since it was easy
- 1) using StandardScaler
- 2) using MinMaxScaler
- 3) didn't scale (run clustering on unscaled data)- used KMeans models, one for each scaled version above, with 2 clusters (since we aimed for red v white) each
- fit each model
- made the fit predictions
- added each set of predictions to a single 'master' dataframe for easy comparisons- made confusion matrices (the value_counts() I did on [["type", "StandScalePreds", "MinMaxScalePreds", "UnscaledPreds"]] can be ignored because it wasn't quite what I wanted and isn't useful)
- *if we assume there is a physicochemical difference between red and white wines*,
- the unsupervised clustering on the StandardScaler data has a balanced accuracy of 98.55%.


## supervised logistic regression

initial_supervised_logit.ipynb

### question  

Can a linear logistc regression model accurately predict the qualities of rated wines based on the measured chemical differences?  

### rough methodology

try on white wines only to nail down a method

using scikitlearn's logisticregression class

1) first attempt
   - combine '3' and '4' qualities into '3-4' and combine '8' and '9' into '8-9' since it was so unblanced.  
   - split into 75%, 25% training, testing data
   - scale using StandardScaler based on clustering above. fit on train data, transform train and test
   - fit multinomial logistic regression
   - 53% accuracy on test  


2) try removing outliers
   - remove outliers based on Ken's method
   - combine qualities like above
   - split train/test the same 
   - scale the same
   - fit multinomial logistic regression
   - 55% accuracy on test

3) realize means of test data weren't as close to 0s as training data
   - use combined '3-4' and '8-9' qualities
   - do not remove outliers
   - scale using StandardScaler on whole dataset
   - split 75%, 25% training, testing data
   - (means for both training and testing now as bad as testing previously)
   - fit multinomial logit
   - 53% accuracy on test

4) from discussion during class, remove density column
   - drop density column
   - use combined '3-4' and '8-9' qualities
   - do not remove outliers
   - split as in (1)
   - scale as in (1)
   - multinomial logit
   - 53.2% accuracy on test

5) logit not guessing '8-9' category at all, problem still too unbalanced
   - combine '3', '4', '5' qualities into '3-5', combined '7', '8', '9' qualities into '7-9'. now 3 possible outcomes: '3-5', '6', '7-9'
   - do not remove columns
   - do not remove outliers
   - split as in (1)
   - scale as in (1)
   - multinomial logit
   - 59% accuracy on test

6) try binary logit
   - combine 3-6 scores into ~4k rows, combine 7-9 scores into ~1k rows. 
   - split as in (1)
   - scale as in (1)
   - fit binary multinomial logit
   - 81% accuracy on test  
   '7-9' category still not being guessed enough

7) label encode (ordinal) data
   - (1) encoded to 0, 1, 2, 3, 4
   - everything same as (1)
   - 53% accuracy on test  
   solver must encode the targets under the hood  

8) try other penalty schema (C=1.0 by default on others)
   - using (7),
   - solvers with C=0.001, 0.01, 0.1, 0.5, 2.0 (l2 penalty)
   - solver with penalty='none' (no C value)
   - mostly no changes to accuracies. not worth investigating further on (7) (perhaps on (5) with outliers removed, but unlikely)
