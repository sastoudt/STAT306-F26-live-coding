# Loading in Needed Package #1

library(tidyverse)

# Load in Relevant Data Sets

groundhogs <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2024/2024-01-30/groundhogs.csv')
predictions <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2024/2024-01-30/predictions.csv')
#https://github.com/rfordatascience/tidytuesday/blob/107ff6c70de02dd807169e13aee7dc9d86ff88b6/data/2024/2024-01-30/readme.md

# Loading in Needed Package #2

library(ggplot2)

# ggplot used to produce scatter plot map of the location of each prediction animal in the data set

# Results: Majority of predictor animals in this data are on the east coast around in Pennsylvania or in states closer to Pennsylvania.

ggplot(groundhogs, aes(x = longitude, y = latitude)) +
  geom_point() +
  theme_minimal()

# ggplot used to produce scatter plot map of the location of each prediction animal in the data set differing based on if the animal is active or not

# Results: The majority of the animals in this data set are actively used to make predictions. 

ggplot(groundhogs, aes(x = longitude, y = latitude, color = active)) +
  geom_point() +
  theme_minimal()

# Summary of the number of predictor animals in each region ordered in descending order to see which location had the most prediction animals

# Results: Pennsylvania has the most predictor animals of all the areas in this data set with New York having the second. 

groundhogs %>%
  group_by(region) %>%
  summarize(total = n()) %>%
  arrange(desc(total))

# Summary of the number of predictor animals in each region grouped by country ordered in descending order to see which location had the most prediction animals

# Results: Pennsylvania has the most predictor animals of all the areas which as 15 predictor animals and is located in the United States. New York in the United States and Ontario in Canada having the second highest number of predictor animals at 6 animals. 

groundhogs %>%
  group_by(country, region) %>%
  summarize(total = n()) %>%
  arrange(desc(total))

# Predictions data set was left joined to the groundhogs data set and named 'merged_df'

# Results: New data set that contains joined data from both the groundhogs and the predictions data set. 

merged_df <- groundhogs %>%
  left_join(y = predictions, by = "id")

# merged_df data set was filter to show just the data for punxsutawney phil then summarized that data to see how often phil sees his shadow compared to does not see his shadow.

# Results: Punxsutawney phil sees his shadow more often then he doesn't see his shadow. There were also ten years in this data set when they could not tell if phil saw his shadow or not.

merged_df %>%
  filter(slug == "punxsutawney-phil") %>%
  group_by(shadow) %>%
  summarize(total = n())

# Merged data was filter down to see the predictors animals 2000 or later then plotted to see the trend between animals seeing their shadow and not seeing their shadow over time.

# Results: Over time both the shadow trend line and not shadow trend line increased. From the line graph it appears recently there are more predictor animals seeing there shadows then not.

merged_df %>%
  filter(year >= 2000) %>%
  group_by(shadow, year) %>%
  summarize(total = n()) %>%
  ggplot(., aes(x = year, y = total, color = shadow)) +
  geom_line() + 
  theme_minimal()

# Merged data was plotted to see the trend between animals seeing their shadow and not seeing their shadow over time.

# Results: The main difference in trend that can be seen between the first and second graph is how the trend changes over the years represented in this data set. When the years are zoomed out to see the full years of contained in the data set it can be seen that in the earlier years that it was harder for it be determined if a shadow was seen or not and predictor animals did not start not seeing their shadow until later

merged_df %>%
  group_by(shadow, year) %>%
  summarize(total = n()) %>%
  ggplot(., aes(x = year, y = total, color = shadow)) +
  geom_line() + 
  theme_minimal()

# A jitter plot was used to see the trend in punxsutawney phil seeing his shadow over time since 2000 to see how phil saw his shadow through the years.

# Results: It appears that phil sees his shadow more often than he doesn't see his shadow. It has been more recent that phil has seen his shadow. 

merged_df %>%
  filter(year >= 2000, slug == "punxsutawney-phil") %>%
  group_by(shadow, year) %>%
  summarize(total = n()) %>%
  ggplot(., aes(x = year, y = total, color = shadow)) +
  geom_jitter() +
  theme_minimal()

# A scatter plot of latitude and longitude colored by when shadow of all the prediction animals to make a map of the animals.

# Results: The map showed a mix of animals seeing their shadow and not seeing their shadow based on their location. It doesn't appear that their trend based on location.

merged_df %>%
  filter(year == 2022) %>%
  ggplot(., aes(x = longitude, y = latitude, color = shadow)) +
  geom_point(size = 2) +
  theme_minimal()

# A scatter plot of latitude and longitude colored by when shadow and country was mapped by shape of all the prediction animals to make a map of the animals.

# Results: We saw that there is not a trend based on country and location on the map for when an predictor animal sees it's shadow or not

merged_df %>%
  filter(year == 2022) %>%
  ggplot(., aes(x = longitude, y = latitude, color = shadow, shape = country)) +
  geom_point(size = 2) +
  theme_minimal()

# A summary was produced by country and shadow to see if more predictors animals in one country predictor animals see their shadow or not.

# Results: It was found that there is more predictor animals in the United States then there is Canada. There appears to be no relationship between country and if a predictor animal sees it's shadow.

merged_df %>%
  group_by(country, shadow) %>%
  summarize(total = n())

# Unique function was used to see the different types of predictor animals.

# Results: A large list of predictor animals appeared a lot of animals were different then groundhogs.

unique(groundhogs$type)

# We filtered for the bullfrog predictor animal data to see what the bullfrog looked like

bullfrog <- groundhogs %>%
  filter(type == "Bullfrog")

# We filtered for the bullfrog predictor animal data to see what the bullfrog looked like

# Results: very funny and very cute

lobsters <- groundhogs %>%
  filter(type == "Atlantic lobster")

# We filtered for the bullfrog predictor animal data to see what the bullfrog looked like

cat <- groundhogs %>%
  filter(type == "Cat")

# We filtered for the bullfrog predictor animal data to see what the bullfrog looked like

bass <- groundhogs %>%
  filter(type == "Largemouth bass")
