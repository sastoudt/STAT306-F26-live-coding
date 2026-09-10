
library(tidyverse)

england_wales_names <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-06-16/england_wales_names.csv')
ni_names <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-06-16/ni_names.csv')
scotland_names <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-06-16/scotland_names.csv')
#https://github.com/sastoudt/tidytuesday/blob/master/data/2026/2026-06-16/readme.md

# Understand the England/Wales Dataframe 
england_wales_names

#How many names in England/Wales Dataframe are girls
england_wales_names %>%
  filter(Sex == "Girl") %>%
  nrow()

#How many names in England/Wales Dataframe are boys
england_wales_names %>%
  filter(Sex == "Boy") %>%
  nrow()


# How many unique names for girls
england_wales_names %>%
  filter(Sex == "Girl") %>%   #Filter down to just girls
  group_by(Name) %>%          #Group by the name
  summarize(avg_rank = mean(Rank)) %>% #find the mean rank for each name
  nrow()                      # finds how many unique names are girls

#What name was ranked 1 in 2020 for England/Wales
england_wales_names %>%
  filter(Sex == "Girl") %>%
  filter(Year == "2020") %>%
  filter(Rank == 1)

#Plot of Rank for Olivia over Time in England/wales
england_wales_names %>%
  filter(Sex == "Girl") %>%
  filter(Name == "Olivia") %>%
  ggplot(., aes(x = Year, y = -Rank)) + geom_line() + theme_minimal() #Adding ggplot to the pipe!
    #Note rank is negative because a low rank means a more popular name, so it flips the axis

#Plot of Rank for Olivia over Time in England/wales
england_wales_names %>%
  filter(Sex == "Girl") %>%
  filter(Name == "Olivia") %>%
  ggplot(., aes(x = Year, y = Number)) + geom_line() + theme_minimal()

#Compare the Rank plot for Olivia with Scotland
scotland_names %>%
  filter(Sex == "Girl") %>%
  filter(Name == "Olivia") %>%
  ggplot(., aes(x = Year, y = -Rank)) + geom_line() + theme_minimal()

#... and the same for northern Ireland
ni_names %>%
  filter(Sex == "Girl") %>%
  filter(Name == "Olivia") %>%
  ggplot(., aes(x = Year, y = -Rank)) + geom_line() + theme_minimal()

# Only looking at names in 2020, group by sex and find the proportion of names are boy/girl per year
scotland_names %>%
  filter(Year == "2020") %>%
  group_by(Sex) %>%
  summarize(prop = n()/(nrow(scotland_names[scotland_names$Year == "2020", ])))