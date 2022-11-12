library(class)
library(tidyverse)

train.numeric = train.omit %>% select(PassengerId,Pclass,Age,SibSp,Parch,Fare)
class(train.omit)
str(train.numeric)
train.numeric$Pclass = as.numeric(train.numeric$Pclass)
train.numeric$SibSp = as.numeric(train.numeric$SibSp)
train.numeric$Parch = as.numeric(train.numeric$Parch)

train.numeric$Fare.scaled = log(train.numeric$Fare)
train.numeric$Age.scaled = log(train.numeric$Age)
train.numeric.scaled = train.numeric %>% select(PassengerId,Pclass,Age.scaled,SibSp,Parch,Fare.scaled)

train.survived = train.omit$Survived

test.numeric = test.omit %>% select(PassengerId,Pclass,Age,SibSp,Parch,Fare)
str(test.numeric.scaled)
test.numeric$Pclass = as.numeric(test.numeric$Pclass)
test.numeric$SibSp = as.numeric(test.numeric$SibSp)
test.numeric$Parch = as.numeric(test.numeric$Parch)

test.numeric$Fare.scaled = log(test.numeric$Fare)
test.numeric$Age.scaled = log(test.numeric$Age)
test.numeric.scaled = test.numeric %>% select(PassengerId,Pclass,Age.scaled,SibSp,Parch,Fare.scaled)

k = sqrt(nrow(train))
Survived = knn(as.matrix(train.numeric.scaled[,2:5]), as.matrix(test.numeric.scaled[,2:5]), as.matrix(train.survived), round(k))
test.numeric.scaled = cbind(test.numeric.scaled,Survived) 
test.numeric.scaled = test.numeric.scaled %>% 
                      complete(PassengerId = first(PassengerId):1309)
test.knn = select(test.numeric.scaled,c(PassengerId,Survived))

# Replace NAs with nearby values
test.knn.na = test.knn %>% fill(Survived)

test.knn$Survived = as.numeric(test.knn$Survived)

for (i in 1:nrow(test.knn)){
  if(is.na(test.knn$Survived[i]) == T){
    test.knn$Survived[i] = rbinom(n=1,size=1,prob=.3838)
  }
  else if(test.knn$Survived[i] == 1){
    test.knn$Survived[i] = 0
    } 
  else if(test.knn$Survived[i] == 2){
    test.knn$Survived[i] = 1
    } 
}

test.knn.na2 = test.knn %>% replace_na(list())
str(test.knn)

write.csv(test.knn,'~/Dropbox/R/Titanic/test_knn.csv',row.names = F)
write.csv(test.knn.na,'~/Dropbox/R/Titanic/test_knn.csv',row.names = F)
write.csv(test.knn.na2,'~/Dropbox/R/Titanic/test_knn.csv',row.names = F)
