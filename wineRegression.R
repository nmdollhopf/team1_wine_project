# set working directory
setwd('/Users/catherinesmith/Desktop/unc_bootcamp/finalProject')

# load packages
library(tidyverse)
library(MASS)
library(glmnet) # RIDGE regression / LASSO regression / Elastic Net regression

# read in data
data <- read.csv('winequality-red.csv', sep = ';')
white <- read.csv('winequality-white.csv', sep = ';')

# full OLS model, predict quality
model <-lm(data = data, quality ~ .)
summary(model)

# compute variance inflation factors
# VIF exceeds 5 for fixed acidity anf density, indicating a problematic
# degree of multicollinearity among these predictors
vif(model)

# make diagnostic plots
# it is clear that condition of homoscedasticity among predictors
# is not met by the pattern among residuals observed in the 
# Scale-Location plot, meaning that the variance of predictors is not
# independent of their values.
jpeg(file = "linearDiganosticPlots.jpg")
par(mfrow=c(2,2))
plot(model)
dev.off()

# try transforming the data to deal with lack of multivariate normality
# apply box-cox power transformation
bc <- boxcox(model, lambda = seq(-3, 3))
best_lambda <- bc$x[which(bc$y==max(bc$y))]


X <- data[,!names(data) %in% c('quality')] %>% as.matrix()
y <- data$quality

# split into train and test
train_rows <- sample(1:nrow(X), 0.7*nrow(X))
X.train <- X[train_rows,]
X.test <- X[-train_rows,]
y.train <- y[train_rows]
y.test <- y[-train_rows]

# try lasso for variable selection
# by default, 10-fold cross-validation is performed
lasso <- cv.glmnet(X.train, y.train, type.measure = 'mse', alpha=1, family='gaussian')
lasso.predicted <-predict(lasso, s=lasso$lambda.1se, newx=X.test)
mean((y.test - lasso.predicted)^2)

# try ridge regression
ridge <- cv.glmnet(X.train, y.train, type.measure = 'mse', alpha=0, family='gaussian')
ridge.predicted <-predict(ridge, s=ridge$lambda.1se, newx=X.test)
mean((y.test - ridge.predicted)^2)

# try elastic net, optimize alpha
# after running a few times, there does not appear to be any optimal value for alpha
alpha_list<- list()
mean_errors <- list()
results <-data.frame()

for(i in 0:10){
  fit.name <- paste0('alpha', i/10)
  alpha_list[[fit.name]] <- cv.glmnet(X.train, y.train, type.measure = 'mse', alpha=i/10, family='gaussian')
  predicted <- predict(alpha_list[[fit.name]], s=alpha_list[[fit.name]]$lambda.1se, newx=X.test)
  mse <- mean((y.test-predicted)^2)
  temp <- data.frame(alpha=i/10, mse=mse, fit.name=fit.name)
  results = rbind(results, temp)
    }


