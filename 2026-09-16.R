
library(tidyverse)

ufo_sightings <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2023/2023-06-20/ufo_sightings.csv')
places <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2023/2023-06-20/places.csv')
day_parts_map <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2023/2023-06-20/day_parts_map.csv')
#https://github.com/rfordatascience/tidytuesday/blob/107ff6c70de02dd807169e13aee7dc9d86ff88b6/data/2023/2023-06-20/readme.md 

# Questions (ufo_sightings.csv)

## Shapes of the UFOS

table(ufo_sightings$shape)

## Shape by Country?

totals_is_us = ufo_sightings %>%
  mutate(is_US = ifelse(country_code == "US", 1, 0)) %>%
  group_by(is_US) %>%
  summarise(count_is_us = n())

### NOTE: Does not work, left_join()

summary_is_us = ufo_sightings %>%
  mutate(is_US = ifelse(country_code == "US", 1, 0)) %>%
  left_join(totals_is_us, by = "is_US") %>%
  group_by(shape, is_US, count_is_us) %>% 
  summarise(ind_count = n(), prop = (ind_count / count_is_us))

view(summary_is_us)

## Plot: Reported Time UTC  vs Duration Seconds

ggplot(ufo_sightings, aes(y = duration_seconds, 
                          x = reported_date_time_utc)) + 
  geom_point() + ylim(0, 1000)

## Plot: Boxplot of duration of seconds by shape

ufo_sightings_filtered = ufo_sightings %>%
  filter(shape %in% c("cube", "fireball", "light"))

ggplot(ufo_sightings_filtered, aes(y = duration_seconds, 
                          x = shape)) +
  geom_boxplot() + ylim(0, 7500)

view(ufo_sightings$summary)


