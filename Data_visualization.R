# Libraries
library(tidyverse)
library(ggplot2)

plot(train)

train$Survived = as.factor(train$Survived)
ggplot(train) +
  geom_bar(mapping = aes(Sex, fill=Survived))
ggplot(train) +
  geom_bar(mapping = aes(cabin_code, fill=Survived))
ggplot(train) +
  geom_bar(mapping = aes(agesexgroup, fill=Survived))
