
library(tidyverse)

# Read in the sightings dataset
ufo_sightings <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2023/2023-06-20/ufo_sightings.csv')

#Read in the places dataset
places <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2023/2023-06-20/places.csv')

#Read in the day parts mapping dataset
day_parts_map <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2023/2023-06-20/day_parts_map.csv')
#https://github.com/rfordatascience/tidytuesday/blob/107ff6c70de02dd807169e13aee7dc9d86ff88b6/data/2023/2023-06-20/readme.md 

# Questions (ufo_sightings.csv)

## Shapes of the UFOS
#Creates a frequency table showing how many sightings were reported for each UFO shape.
table(ufo_sightings$shape)

## Shape by Country
#Creates a new variable, is_US, that identifies whether each sighting occurred in the United States (1=US, 0=not US). Then counts the total number of observations in each group.
totals_is_us = ufo_sightings %>%
  mutate(is_US = ifelse(country_code == "US", 1, 0)) %>%
  group_by(is_US) %>%
  summarise(count_is_us = n())

### NOTE: Does not work, left_join()
#Calculates the number and proportion of each UFO shape within the US and non-US groups.
#mutate() creates the US/non-US indicator.
#left_join() adds the total number of sightings for each group.
#group_by() groups the data by UFO shape and whether the sighting was in the US.
#summarise() calculates the number of sightings and the proportion of each shape withtin the group.
summary_is_us = ufo_sightings %>%
  mutate(is_US = ifelse(country_code == "US", 1, 0)) %>%
  left_join(totals_is_us, by = "is_US") %>%
  group_by(shape, is_US, count_is_us) %>% 
  summarise(ind_count = n(), prop = (ind_count / count_is_us))

#Opens the summary table so the results can be viewed.
view(summary_is_us)

## Plot: Reported Time UTC  vs Duration Seconds
#Creates a scatterplot showing the relationship between the reported date/time of a UFO sighting and its duration.
#Each point represents one UFO sighting.
#ylim() limits the y-axis to durations between 0 and 1,000 seconds.
ggplot(ufo_sightings, aes(y = duration_seconds, 
                          x = reported_date_time_utc)) + 
  geom_point() + ylim(0, 1000)

## Plot: Boxplot of duration of seconds by shape
#Filters the dataset to only include sightings described as curbes, fireballs, or lights
ufo_sightings_filtered = ufo_sightings %>%
  filter(shape %in% c("cube", "fireball", "light"))

#Creates boxplots comparing the distribution of UFO sighting durations across the three selected shapes.
#The x-axis shows the UFO shape.
#The y-axis shows the duration of the sighting in seconds.
ggplot(ufo_sightings_filtered, aes(y = duration_seconds, 
                          x = shape)) +
  geom_boxplot() + ylim(0, 7500)

#View the UFO sightings dataset.
view(ufo_sightings$summary)


