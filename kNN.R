library(class)

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
Survived <- knn(as.matrix(train.numeric.scaled[,2:5]), as.matrix(test.numeric.scaled[,2:5]), as.matrix(train.survived), round(k))
test.numeric.scaled <- cbind(test.numeric.scaled,Survived) 

write.csv(select(test,c(PassengerId,Survived)),'~/Dropbox/R/Titanic/test_knn.csv',row.names = F)
