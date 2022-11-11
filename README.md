# Titanic

This repository is for codes for the Titanic ML competition on Kaggle.com.

The first attempt is made by linear regression. After ignoring the "PassengerId","Name","Ticket","Cabin" variables, 
the linear model shows "Pclass","Sex","Age","SibSp" are significant, thus are used for the prediction model. Rows include NA
are replaced by rbinom(n=1,size=1,prob=.3838), .3838 is the overall survival rate. The linear regression model reahes a 
score of 0.64114.
