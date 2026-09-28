
library(tidyverse)
library(lubridate)

judges_appointments <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-06-10/judges_appointments.csv')
judges_people <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-06-10/judges_people.csv')
#https://github.com/rfordatascience/tidytuesday/blob/107ff6c70de02dd807169e13aee7dc9d86ff88b6/data/2025/2025-06-10/readme.md

judges_appointments %>% 
  group_by(president_name) %>%
  summarize(total = n())

judges_appointments %>% 
  group_by(president_name) %>%
  summarize(total = n()) %>% 
  arrange(desc(total))

judges_appointments %>% 
  filter(termination_reason == "Impeachment & Conviction") %>% 
  group_by(president_party) %>%
  summarize(total = n())

judges_appointments %>% 
  filter(termination_reason == "Death") %>% 
  group_by(president_party) %>%
  summarize(total = n())

judges_people %>% 
  group_by(gender) %>%
  summarize(total = n())

judges_people %>% 
  group_by(race) %>%
  summarize(total = n())

judges_people %>% 
  group_by(race, gender) %>%
  summarize(total = n())

judges_people %>% 
  filter(birth_date > 1900) %>%
  group_by(race, gender) %>%
  summarize(total = n())

judges_people %>% 
  filter(birthplace_state %in% c("PA", "NY", "MA", "NJ", "CA", "ND")) %>%
  ggplot(., aes(x = birthplace_state)) + 
  geom_bar()

judges_people %>% 
  filter(birthplace_state %in% c("PA", "NY", "MA", "NJ", "CA", "ND", "AK", "HI")) %>%
  ggplot(., aes(x = birthplace_state)) + 
  geom_bar()

data <- judges_people %>%
  left_join(judges_appointments, by = "judge_id") 

year(data$commission_date, format = "%m/%d/%Y")

ymd(data$commission_date)

data %>% 
  group_by(gender, president_party) %>%
  summarize(total = n()) %>% 
  arrange(president_party)
  


