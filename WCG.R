# Create age & sex groups: young men, young women, married men, married women
# Inspired by WCG model

train$agesexgroup = rep(NA,nrow(train))

for (i in 1:nrow(train)){
  if (grepl('Mr',train$Name[i])){
    train$agesexgroup[i] = 'married man'
  } else if (grepl('Miss',train$Name[i])){
    train$agesexgroup[i] = 'young woman'
  } else if (grepl('Master',train$Name[i])){
    train$agesexgroup[i] = 'young man'
  } else if (grepl('Rev',train$Name[i])){
    train$agesexgroup[i] = 'priest'
  }
  if (grepl('Mrs',train$Name[i])){
    train$agesexgroup[i] = 'married woman'
  }
}

train$agesexgroup = as.factor(train$agesexgroup)
train %>% group_by(Survived,agesexgroup) %>% summarize(n=n()) 

ggplot(train, na.rm=T) +
  geom_bar(mapping = aes(agesexgroup, fill=Survived))

# As we can see young people and married woman have a higher survival rate

# Attempt 1: Assign women and young men as survived and others as not survived
for (i in 1:nrow(test)){
  if (grepl('Mr',test$Name[i])){
    test$Survived[i] = 0 
  } else if (grepl('Miss',test$Name[i])){
    test$Survived[i] = 1
  } else if (grepl('Master',test$Name[i])){
    test$Survived[i] = 1
  } else if (grepl('Rev',test$Name[i])){
    test$Survived[i] = 0 
  } else{
    test$Survived[i] = rbinom(1,1,.5)
  }
  if (grepl('Mrs',test$Name[i])){
    test$Survived[i] = 0 
  }
}
# Output the result into .csv file for submission
write.csv(select(test,c(PassengerId,Survived)),'~/Dropbox/R/Titanic/test_wcg_1.csv',row.names = F)

# Attempt 2: A






