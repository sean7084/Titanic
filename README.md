# Titanic

This repository is for codes for the Titanic ML competition on Kaggle.com.

The first attempt is made by linear regression. After ignoring the "PassengerId","Name","Ticket","Cabin" variables, the linear model shows "Pclass","Sex","Age","SibSp" are significant, thus are used for the prediction model. Rows include NA are replaced by rbinom(n=1,size=1,prob=.3838), .3838 is the overall survival rate. The linear regression model reahes a score of 0.64114. (.4856 when NAs are kept)

2.1 attempt used women children group (WCG) as the only predictor. People are identified through their names only. Simply categorizing adult man as dead would give us a score of 0.75119, which is better than the last attempt. It shows choosing a better predictor is more useful than better methods or using wide arrange of predictors.

The third attempt using kNN failed due to too many NAs in the test dataset (100/418). Can only reach 0.64 after the run. Could be useful if trying integrate this method with others. (.5239 if NAs are kept)
