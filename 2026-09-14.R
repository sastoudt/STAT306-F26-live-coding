
library(tidyverse)

squirrel_data <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2023/2023-05-23/squirrel_data.csv')
#https://github.com/rfordatascience/tidytuesday/blob/107ff6c70de02dd807169e13aee7dc9d86ff88b6/data/2023/2023-05-23/readme.md

#Rename Squirrel_Data to Data and remove old frame
data <-squirrel_data 
rm(squirrel_data)

#Filter to only adults
#Group by foraging or not
#find counts
adult_df <- data %>% 
  filter(Age == "Adult") %>% 
  group_by(Foraging) %>% 
  summarize(count = n())


#Filter to only juveniles
#Group by foraging or not
#find counts
j_df <- data %>% 
  filter(Age == "Juvenile") %>% 
  group_by(Foraging) %>% 
  summarize(count = n())

#group by location and color then count
data %>% 
  group_by(Location, `Primary Fur Color`) %>% 
  summarize(count = n())

#group by location and count
#save to new data frame
data_by_loc <- data %>% 
  group_by(Location) %>%
  summarize( my_count = n())

## What 
# Attempt at finding proportions, did not work
data %>% 
  left_join(data_by_loc, by = "Location") %>% 
  group_by(Location, `Primary Fur Color`) %>% 
  summarize(prop = n() / my_count)

#Creating makeshift map of latitude vs longitude
data %>% ggplot(., aes(x= X, y= Y)) + geom_point() +theme_bw()

#Creating makeshift map of latitude vs longitude
#sorting color by fur color
data %>% 
  ggplot(., aes(x = X, y = Y, color = `Primary Fur Color`)) + 
  geom_point(alpha = 0.5) +
  theme_bw() + 
  facet_wrap(~`Primary Fur Color`)

#bar chart of squirrels seen twitching tail by age
data %>% 
  ggplot(., aes(x = Age, fill= `Tail twitches`)) + 
  geom_bar() +
  theme_bw()

#bar chart of proportion of squirrels seen twitching tail by age
data %>% 
  ggplot(., aes(x = Age, fill= `Tail twitches`)) + 
  geom_bar(position = "fill") +
  theme_bw()

#view unique interactions
unique(data$`Other Interactions`)

