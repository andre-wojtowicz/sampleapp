library(shiny)
library(tidyr)
library(yaml)

df = read.csv("data/file.csv") %>%
     pivot_wider(names_from=condition,
                 values_from=measurement)

if (file.exists(".build_data.yml"))
{
    build_yml = read_yaml(".build_data.yml")
} else {
    build_yml = list(app = "unknown", data = "unknown")
}
