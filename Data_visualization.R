# Libraries
library(tidyverse)
library(ggplot2)

train$Survived = as.character(train$Survived)
ggplot(train) +
  geom_bar(mapping = aes(Sex, fill=Survived))

