# set working directory
setwd('/Users/catherinesmith/Desktop/unc_bootcamp/finalProject')

# load packages
library(tidyverse)
library(MASS)
library(glmnet)

#set seed
set.seed(42)

# read in data
data <- read.csv('winequality-red.csv', sep = ';')
data <- data[,!names(data) %in% c('quality')]

long_data <- data %>%
  pivot_longer(colnames(data)) %>%
  as.data.frame()

ggplot(long_data, aes(x=value))+
  geom_histogram()+
  facet_wrap(~name, scales = 'free')

pairs(data)

# log transform all data
# drop rows with value ==0
# long_data[long_data==0] <- NA
# long_data <- long_data %>% drop_na()
# long_data$value <- log(long_data$value)

# does sqrt transformation of all data help --> some
long_data$value <- long_data$value^(1/2)
ggplot(long_data, aes(x=value))+
  geom_histogram()+
  facet_wrap(~name, scales = 'free')
pairs(data)

# transform and scale all data
data <- scale() %>%
  as.data.frame()
long_data <- data %>%
  pivot_longer(colnames(data)) %>%
  as.data.frame()
ggplot(long_data, aes(x=value))+
  geom_histogram()+
  facet_wrap(~name, scales = 'free')
  
#split into train and test
split = sample(c(rep(0,0.7*nrow(data)), rep(1,0.3*nrow(data))))
train = data[split==0,]
test = data[split==1,]

# full OLS model, predict alcohol content


# # log-transformed data looks better
# # make model with transformed response variable
# model <- glm(alcohol ~ .,data=train, family = 'gaussian')
# summary(model)
# par(mfrow=c(2,2))
# plot(model)
# dev.off()

# # remove high leverage points
# leverage_cutoff <- (2/nrow(data))*(ncol(data))
# high_hats <- which(hatvalues(model) > leverage_cutoff)
# data <- data[-high_hats,]

# apply Box-Cox transformation
# bc <- boxcox(model, lambda = seq(-3,3))
# best_lambda <- bc$x[which(bc$y==max(bc$y))]
# bc_value <- -1
# # new model without high leverage points & BC transformation
# model <- lm((alcohol)^best_lambda ~ ., data=data)
# par(mfrow=c(2,2))
# plot(model)
# high_hats <- which(hatvalues(model) > leverage_cutoff)

summary(model)

# perform variable selection with LASSO
# split data in response and predictors
y <- train$alcohol
x<- train[,!names(train) %in% c('alcohol')] %>% as.matrix()

# build the LASSO model
lasso.fit<- cv.glmnet(x,
                  y,
                  type.measure = 'mse',
                  alpha=0.5,
                  family = gaussian)
coef(lasso.fit, s=0.4)
lasso.predicted <- predict(lasso.fit,
                           s=lasso.fit$lambda.1se,
                           newx=tes$alcohol)
plot(lasso)
lm(alcohol~density, data=train) %>% summary()
plot(alcohol~density, data=train)

# find optimal value of lambda
lambda_min <- lasso$lambda.min
best_lasso<- glmnet(x,y,alpha=1, lambda = lambda_min)


# # simple linear model
# model<-lm(quality ~ alcohol +
#             volatile.acidity+ 
#             sulphates+
#             citric.acid+
#             total.sulfur.dioxide, data)
# summary(model)
# # diagnostic plots --> look very bad!
# par(mfrow=c(2,2))
# plot(model)
# 
# #scatter plot of each variable
pairs(~.,data=data,gap=0.4,cex.labels=1.5) 
# 
# 
# # try a glm - poisson
# model <- glm(quality ~ alcohol, data=data, family='poisson')
# par(mfrow=c(2,2))
# glm.diag.plots(model, glm.diag(model) )
# 
# # remove points of high leverage
# leverage_cutoff <- 4/length(data$quality)
# high_hat <- which(hatvalues(model) > leverage_cutoff)
# length(high_hat)
# data <- data[-high_hat,]
# 
# # try model without points of high leverage
# # model <- lm(sqrt(quality) ~ sqrt(alcohol), data=data)
# # par(mfrow=c(2,2))
# # plot(model)
# model <- glm(quality ~ alcohol, data=data, family='poisson')
# leverage_cutoff <- 4/length(data$quality)
# high_hat <- which(hatvalues(model) > leverage_cutoff)
# length(high_hat)
# data <- data[-high_hat,]
# par(mfrow=c(2,2))
# glm.diag.plots(model, glm.diag(model) )
# 
# # try lasso
# data <-read.csv('winequality-red.csv', sep = ';')
# y <- data$quality
# x<- data[,!names(data) %in% c('quality')]
# 
# ridge<- glmnet(x,y,alpha=0)
# plot(ridge)
# lambda_min <- lasso$lambda.min
# best_lasso<- glmnet(x,y,alpha=1, lambda = lambda_min)

