
library(tidyverse)

data <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2024/2024-10-08/most_visited_nps_species_data.csv')
#https://github.com/rfordatascience/tidytuesday/blob/107ff6c70de02dd807169e13aee7dc9d86ff88b6/data/2024/2024-10-08/readme.md 


data_cat_name <- data %>%
  group_by(CategoryName) %>%
  summarize(total = n())


data_nativeness <- data %>%
  group_by(Nativeness) %>%
  summarize(total = n())


unique(data$ParkName)


barchart_data <- data %>%
  filter(ParkName %in% c("Grand Canyon National Park", "Olympic National Park", "Cuyahoga Valley National Park")) %>%
  group_by(Nativeness, ParkName) %>%
  summarize(total = n()) %>%
  arrange(ParkName)


barchart_data <- data %>%
  filter(ParkName %in% c("Grand Canyon National Park", "Olympic National Park", "Cuyahoga Valley National Park"))


ggplot(data = barchart_data, aes(x = ParkName, fill = Nativeness)) + geom_bar(position = "fill")



data %>%
  filter(TEStatus = "")

table(data$TEStatus)


table(data$Sensitive)

table(data$OzoneSensitiveStatus)

  
data_parks <- data %>%
  filter(ParkName %in% c("Grand Canyon National Park", "Olympic National Park", "Cuyahoga Valley National Park")) %>%
  group_by(Order, ParkName) %>%
  summarize(total = n())

data_cat_name_2 <- data %>%
  filter(ParkName %in% c("Grand Canyon National Park", "Olympic National Park", "Cuyahoga Valley National Park")) %>%
  group_by(CategoryName, ParkName) %>%
  summarize(total = n())



data_for_boxplot <- data %>%
  group_by(CategoryName, ParkName) %>%
  summarize(total = n()) %>%
  ggplot(., aes(x = CategoryName, y = total)) + geom_boxplot()

data_for_boxplot


data %>%
  group_by(CategoryName, ParkName) %>%
  summarize(total = n()) %>%
  arrange(desc(total))
  




