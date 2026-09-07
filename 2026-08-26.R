library(tidyverse)

clutch <- readr::read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-03-03/clutch_size_cleaned.csv")
tort <- readr::read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-03-03/tortoise_body_condition_cleaned.csv")
# https://github.com/rfordatascience/tidytuesday/blob/main/data/2026/2026-03-03/readme.md

View(clutch)
View(tort)


## bodymass by age and sex
## what times of year are they most often caught
## new variable: weight and length (ratio)
## average body mass increase decrease throughout the year
## body mass change depending on season

## calculating
tort <- tort %>% mutate(body_ratio = body_mass_grams / straight_carapace_length_mm)
ggplot(tort, aes(body_ratio)) +
  geom_histogram()

tort %>%
  group_by(season, sex) %>%
  summarise(num = n(), mBM = mean(body_mass_grams))


females <- tort %>% filter(sex == "f")
males <- tort %>% filter(sex == "m")

ggplot(clutch, aes(age)) +
  geom_histogram()

ggplot(clutch, aes(age, body_mass_grams)) +
  geom_point()
