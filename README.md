# Titanic

This repository is for the Titanic project on Kaggle.com. (https://www.kaggle.com/competitions/titanic) The mission is to predict the result of survival using the sample dataset.

The first attempt uses linear regression. After ignoring the nominal variables, the linear model shows "Pclass","Sex","Age","SibSp" are significant, thus are used for the prediction model. Rows include NA are replaced by rbinom(n=1,size=1,prob=.3838), .3838 is the overall survival rate. The linear regression model reaches a score of 0.64114. (.4856 when NAs are kept)

2.1 attempt used women children group (WCG) as the only predictor. People are identified through their names only. Simply categorizing adult man as dead would give us a score of 0.75119, which is better than the first attempt. It shows choosing a better predictor is more useful than better methods or using wide arrange of predictors.

The third attempt using kNN failed due to too many NAs in the test dataset (100/418). Can only reach 0.64 accuracy. The method could be useful if trying integrate this method with others. (.5239 if NAs are kept)
