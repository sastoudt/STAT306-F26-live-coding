
library(tidyverse)

england_wales_names <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-06-16/england_wales_names.csv')
ni_names <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-06-16/ni_names.csv')
scotland_names <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-06-16/scotland_names.csv')
#https://github.com/sastoudt/tidytuesday/blob/master/data/2026/2026-06-16/readme.md

england_wales_names

england_wales_names %>%
  filter(Sex == "Girl") %>%
  nrow()

england_wales_names %>%
  filter(Sex == "Boy") %>%
  nrow()

england_wales_names %>%
  filter(Sex == "Girl") %>%
  group_by(Name) %>%
  summarize(avg_rank = mean(Rank)) %>%
  nrow()

england_wales_names %>%
  filter(Sex == "Girl") %>%
  filter(Year == "2020") %>%
  filter(Rank == 1)

england_wales_names %>%
  filter(Sex == "Girl") %>%
  filter(Name == "Olivia") %>%
  ggplot(., aes(x = Year, y = -Rank)) + geom_line() + theme_minimal()

england_wales_names %>%
  filter(Sex == "Girl") %>%
  filter(Name == "Olivia") %>%
  ggplot(., aes(x = Year, y = Number)) + geom_line() + theme_minimal()

scotland_names %>%
  filter(Sex == "Girl") %>%
  filter(Name == "Olivia") %>%
  ggplot(., aes(x = Year, y = -Rank)) + geom_line() + theme_minimal()

ni_names %>%
  filter(Sex == "Girl") %>%
  filter(Name == "Olivia") %>%
  ggplot(., aes(x = Year, y = -Rank)) + geom_line() + theme_minimal()

scotland_names %>%
  filter(Year == "2020") %>%
  group_by(Sex) %>%
  summarize(prop = n()/(nrow(scotland_names[scotland_names$Year == "2020", ])))