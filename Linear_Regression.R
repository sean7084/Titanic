# Library
library(tidyverse)

# List factors into numeric variables for linear regression
train$Sex = as.character(train$Sex)
train$Survived = as.numeric(train$Survived)
train$PassengerId = as.numeric(train$PassengerId)
train$Pclass = as.numeric(train$Pclass)
train$Embarked = as.character(train$Embarked)

# Initial linear model
train_lm = lm(Survived~.,data = select(train,-c(PassengerId,Name,Ticket,Cabin)))
summary(train_lm)

# Linear model after removing non-significant IVs
train_lm_alt = lm(Survived~.,data = select(train,c(Survived,Pclass,Sex,Age,SibSp)))
summary(train_lm_alt)

# Prediction using linear regression results
test$survival_rate = train_lm_alt$coefficients['(Intercept)']+
                     test$Pclass * train_lm_alt$coefficients['Pclass'] +
                     ifelse(test$Sex == 'male',train_lm_alt$coefficients['Pclass'],0) +
                     test$Age * train_lm_alt$coefficients['Age'] +  
                     test$SibSp * train_lm_alt$coefficients['SibSp']
test$Survived = ifelse(test$survival_rate>.5,1,0)

# Replace NAs with random binomial values with p = Overall survival rate
summary(train$Survived)
test$Survived = ifelse(is.na(test$survival_rate) == T,rbinom(n=1,size=1,prob=.3838),test$Survived)

# Output the result into .csv file for submission
write.csv(select(test,c(PassengerId,Survived)),'~/Dropbox/R/Titanic/test_lm.csv',row.names = F)