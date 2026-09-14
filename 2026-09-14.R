
library(tidyverse)

squirrel_data <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2023/2023-05-23/squirrel_data.csv')
#https://github.com/rfordatascience/tidytuesday/blob/107ff6c70de02dd807169e13aee7dc9d86ff88b6/data/2023/2023-05-23/readme.md


data <-squirrel_data 
rm(squirrel_data)

adult_df <- data %>% 
  filter(Age == "Adult") %>% 
  group_by(Foraging) %>% 
  summarize(count = n())

j_df <- data %>% 
  filter(Age == "Juvenile") %>% 
  group_by(Foraging) %>% 
  summarize(count = n())

data %>% 
  group_by(Location, `Primary Fur Color`) %>% 
  summarize(count = n())

data_by_loc <- data %>% 
  group_by(Location) %>%
  summarize( my_count = n())

## What 
data %>% 
  left_join(data_by_loc, by = "Location") %>% 
  group_by(Location, `Primary Fur Color`) %>% 
  summarize(prop = n() / my_count)


data %>% ggplot(., aes(x= X, y= Y)) + geom_point() +theme_bw()

data %>% 
  ggplot(., aes(x = X, y = Y, color = `Primary Fur Color`)) + 
  geom_point(alpha = 0.5) +
  theme_bw() + 
  facet_wrap(~`Primary Fur Color`)

data %>% 
  ggplot(., aes(x = Age, fill= `Tail twitches`)) + 
  geom_bar() +
  theme_bw()

data %>% 
  ggplot(., aes(x = Age, fill= `Tail twitches`)) + 
  geom_bar(position = "fill") +
  theme_bw()

unique(data$`Other Interactions`)

