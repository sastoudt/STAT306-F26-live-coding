
library(tidyverse)

groundhogs <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2024/2024-01-30/groundhogs.csv')
predictions <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2024/2024-01-30/predictions.csv')
#https://github.com/rfordatascience/tidytuesday/blob/107ff6c70de02dd807169e13aee7dc9d86ff88b6/data/2024/2024-01-30/readme.md
library(ggplot2)

ggplot(groundhogs, aes(x = longitude, y = latitude)) +
  geom_point() +
  theme_minimal()

ggplot(groundhogs, aes(x = longitude, y = latitude, color = active)) +
  geom_point() +
  theme_minimal()

groundhogs %>%
  group_by(region) %>%
  summarize(total = n()) %>%
  arrange(desc(total))

groundhogs %>%
  group_by(country, region) %>%
  summarize(total = n()) %>%
  arrange(desc(total))

merged_df <- groundhogs %>%
  left_join(y = predictions, by = "id")

merged_df %>%
  filter(slug == "punxsutawney-phil") %>%
  group_by(shadow) %>%
  summarize(total = n())

merged_df %>%
  filter(year >= 2000) %>%
  group_by(shadow, year) %>%
  summarize(total = n()) %>%
  ggplot(., aes(x = year, y = total, color = shadow)) +
  geom_line() + 
  theme_minimal()

merged_df %>%
  group_by(shadow, year) %>%
  summarize(total = n()) %>%
  ggplot(., aes(x = year, y = total, color = shadow)) +
  geom_line() + 
  theme_minimal()

merged_df %>%
  filter(year >= 2000, slug == "punxsutawney-phil") %>%
  group_by(shadow, year) %>%
  summarize(total = n()) %>%
  ggplot(., aes(x = year, y = total, color = shadow)) +
  geom_jitter() +
  theme_minimal()

merged_df %>%
  filter(year == 2022) %>%
  ggplot(., aes(x = longitude, y = latitude, color = shadow)) +
  geom_point(size = 2) +
  theme_minimal()

merged_df %>%
  filter(year == 2022) %>%
  ggplot(., aes(x = longitude, y = latitude, color = shadow, shape = country)) +
  geom_point(size = 2) +
  theme_minimal()

merged_df %>%
  group_by(country, shadow) %>%
  summarize(total = n())

unique(groundhogs$type)

bullfrog <- groundhogs %>%
  filter(type == "Bullfrog")

lobsters <- groundhogs %>%
  filter(type == "Atlantic lobster")

cat <- groundhogs %>%
  filter(type == "Cat")

bass <- groundhogs %>%
  filter(type == "Largemouth bass")