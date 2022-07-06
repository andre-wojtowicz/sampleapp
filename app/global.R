library(shiny)
library(tidyr)

df = read.csv("data/file.csv") %>%
     pivot_wider(names_from=condition,
                 values_from=measurement)
