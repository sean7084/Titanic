setwd('~/Dropbox/R/Titanic')

# Libraries
library(tidyverse)
library(ggpubr)

# Imprt data
train = read.csv('train.csv')
test = read.csv('test.csv')

# Summary
head(train)
summary(train)

# List cateogorical data into factors.
train$Sex = as.factor(train$Sex)
train$Survived = as.factor(train$Survived)
train$PassengerId = as.factor(train$PassengerId)
train$Pclass = as.factor(train$Pclass)
train$Embarked = as.factor(train$Embarked)

# Check normaility of numerical data
shapiro.test(train$Age)
shapiro.test(train$SibSp)
shapiro.test(train$Parch)
shapiro.test(train$Fare)

# Create a column for last name
train$LastName = gsub("^(.*?),.*", "\\1", train$Name)
#str_extract(train$Name,"(\\w+)") cannot extract first name like O'Really


train$agesexgroup = rep(NA,nrow(train))
# Create age & sex groups: young men, young women, married men, married women
# Inspired by WCG model
for (i in 1:nrow(train)){
  if ('Mr' %in% train$Name[i]){
    train$agesexgroup[i] = 'married man'
  } else if ('Mrs'  %in% train$Name[i]){
    train$agesexgroup[i] = 'married woman'
  } else if ('Miss'  %in% train$Name[i]){
    train$agesexgroup[i] = 'young woman'
  } else if ('Master'  %in% train$Name[i]){
    train$agesexgroup[i] = 'young man'
  }
}

# Create cabin area column
train$cabin_code = substr(train$Cabin,1,1)
