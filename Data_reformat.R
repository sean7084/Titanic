setwd('~/Dropbox/R/Titanic')

# Libraries
library(tidyverse)
library(ggpubr)

# Imprt data
train = read.csv('train.csv')
train.omit = na.omit(train)
test = read.csv('test.csv')

# Numeric data
train.numeric = train.omit %>% select(Survived,Pclass,Age,SibSp,Parch,Fare)
summary(train.numeric)

# Summary
head(train)
summary(train)

# List categorical data into factors.
train$Sex = as.factor(train$Sex)
train$Survived = as.factor(train$Survived)
train$PassengerId = as.factor(train$PassengerId)
train$Pclass = as.factor(train$Pclass)
train$Embarked = as.factor(train$Embarked)

# Check normality of numerical data
shapiro.test(train$Age)
shapiro.test(train$SibSp)
shapiro.test(train$Parch)
shapiro.test(train$Fare)

# Create a column for last name
train$LastName = gsub("^(.*?),.*", "\\1", train$Name)
#str_extract(train$Name,"(\\w+)") cannot extract first name like O'Really

# Create cabin area column
train$cabin_code = substr(train$Cabin,1,1)
