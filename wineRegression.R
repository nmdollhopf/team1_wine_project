# set working directory
setwd('/Users/catherinesmith/Desktop/unc_bootcamp/finalProject')

# load packages
library(tidyverse)
library(GGally) # make pair plots
library(mvnormtest)
library (car) # compute variance inflation factors
library(glmnet) # RIDGE regression / LASSO regression / Elastic Net regression

# read in data
red <- read.csv('winequality-red.csv', sep = ';', check.names = F) %>% mutate(color='red')
white <- read.csv('winequality-white.csv', sep = ';', check.names = F) %>% mutate(color='white')
data <- rbind(white, red)
  
# make pair plots
ggpairs(data[,1:12],
        aes(color=data$color),
        upper = list(continuous = wrap("cor", size = 3)),
        lower = list(continuous = wrap('points', size=0.1, alpha=0.3)),
        labeller = label_wrap_gen(10)
        )+
  theme(panel.grid.major=element_blank(), panel.grid.minor=element_blank(),
        axis.text.x = element_text(angle = 45))+
  scale_fill_manual(values=c('#613969','#DAA4AC'))+
  scale_color_manual(values=c('#613969','#DAA4AC'))

# full OLS model, predict quality
model <-lm(data = data, quality ~ .)
summary(model)

# assess multivariate normality
# H0: The data follows a multivariate-normal distribution.
# Ha: The data does not follow a multivariate-normal distribution.
# sample <- data[sample(nrow(data),5000),1:11]
shapiro.test(sample(model$residuals, 5000))

# compute variance inflation factors
# VIF exceeds 5 for fixed acidity and density, indicating a problematic
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

# perform studentized Breusch-Pagan test to asssess homoscedasticity
# H0: The data is homoscedastic.
# Ha: The data is not homoscedastic.
bptest(model)

# try transforming the data to deal with lack of multivariate normality
# try a sqrt transformation
sqrt_data <- data[,1:11] %>% sqrt()
sqrt_data <- cbind(sqrt_data, data$quality) %>% rename('quality'='data$quality')
model <- lm(data=sqrt_data, quality~. )
shapiro.test(sample(model$residuals, 5000))

# apply box-cox power transformation
bc <- boxcox(model, lambda = seq(-3, 3))
best_lambda <- bc$x[which(bc$y==max(bc$y))]
best_lambda
bc_data <- data[,1:11]^best_lambda
bc_data <- cbind(bc_data, data$quality) %>% rename('quality'='data$quality')
model <- lm(data=bc_data, quality~.)
shapiro.test(sample(model$residuals, 5000))

# try lasso for variable selection
# split data into train and test
X <- data[,!names(data) %in% c('quality', 'color')] %>% as.matrix()
y <- data$quality
train_rows <- sample(1:nrow(X), 0.7*nrow(X))
X.train <- X[train_rows,]
X.test <- X[-train_rows,]
y.train <- y[train_rows]
y.test <- y[-train_rows]

# perform lasso, by default, 10-fold cross-validation is performed
lasso <- cv.glmnet(X.train, y.train, type.measure = 'mse', alpha=1, family='gaussian')
lasso.predicted <-predict(lasso, s=lasso$lambda.1se, newx=X.test)
mean((y.test - lasso.predicted)^2)
coef(lasso)

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


