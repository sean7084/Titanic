train_lm = lm(Survived~.,data = select(train,-c(Name,Ticket,Cabin)))
summary(train_lm)

train_lm_alt = lm(Survived~.,data = select(train,c(Survived,Pclass,Sex,Age,SibSp)))
summary(train_lm_alt)