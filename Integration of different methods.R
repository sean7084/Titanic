# Make sure all survived are the same data type
test.lm$Survived = as.factor(test.lm$Survived)
test.wcg$Survived = as.factor(test.wcg$Survived)
test.knn$Survived = as.factor(test.knn$Survived)

# Integrate lm an knn with wcg1
test.lm.wcg = test.lm %>% inner_join(test.wcg, by = 'PassengerId') %>%
              inner_join(test.wcg) %>%
              mutate(Survived = coalesce(Survived.x, Survived.y)) %>%
              select(PassengerId, Survived)

test.knn.wcg = test.knn %>% inner_join(test.wcg, by = 'PassengerId') %>%
               inner_join(test.wcg) %>%
               mutate(Survived = coalesce(Survived.x, Survived.y)) %>%
               select(PassengerId, Survived)
# Output the result into .csv file for submission
write.csv(test.lm.wcg,'~/Dropbox/R/Titanic/test_lm_wcg_1.csv',row.names = F)
write.csv(test.knn.wcg,'~/Dropbox/R/Titanic/test_knn_wcg_1.csv',row.names = F)
