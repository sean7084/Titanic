library(tidyverse)

train_lm = lm(Survived~.,data = select(train,-c(Name,Ticket,Cabin)))
summary(train_lm)

train_lm_alt = lm(Survived~.,data = select(train,c(Survived,Pclass,Sex,Age,SibSp)))
summary(train_lm_alt)

test$survival_rate = train_lm_alt$coefficients['(Intercept)']+
                     test$Pclass * train_lm_alt$coefficients['Pclass'] +
                     ifelse(test$Sex == 'male',train_lm_alt$coefficients['Pclass'],0) +
                     test$Age * train_lm_alt$coefficients['Age'] +  
                     test$SibSp * train_lm_alt$coefficients['SibSp']
test$Survived = ifelse(test$survival_rate>.5,1,0)
test$Survived = ifelse(is.na(test$survival_rate) == T,rbinom(n=1,size=1,prob=.5),test$Survived)

select(test,c(PassengerId,Survived))

write.csv(select(test,c(PassengerId,Survived)),'~/Dropbox/R/Titanic/test_lm.csv',row.names = F)