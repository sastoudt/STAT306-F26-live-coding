
library(tidyverse)
library(lubridate)

judges_appointments <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-06-10/judges_appointments.csv')
judges_people <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-06-10/judges_people.csv')
#https://github.com/rfordatascience/tidytuesday/blob/107ff6c70de02dd807169e13aee7dc9d86ff88b6/data/2025/2025-06-10/readme.md

#We wanted to see how many judges were appointed under each president so we performed a 'group_by/summarize'. 
# We see only the first couple of rows but originally we see that Barak Obama has appointed the most, no order

judges_appointments %>% 
  group_by(president_name) %>%
  summarize(total = n())

#We wanted to see how many judges were appointed under each president so we performed a 'group_by/summarize'. 
#we ordered the total judges appointed in descending orrder to see which president actually appointed the most judges
#The answer is Ronald Reagan 
judges_appointments %>% 
  group_by(president_name) %>%
  summarize(total = n()) %>% 
  arrange(desc(total))

#We wanted to see if the judges that were terminated due to Impeachment &n Conviction had a particular party affiliation.
#DIdn't really get a good reult, but more Democrats than Republican
judges_appointments %>% 
  filter(termination_reason == "Impeachment & Conviction") %>% 
  group_by(president_party) %>%
  summarize(total = n())

#We switched to check whether judges that had a termination reason of Death had a particular poltical party affiliation
#Republicans had the most with Democratic closely follwing 
judges_appointments %>% 
  filter(termination_reason == "Death") %>% 
  group_by(president_party) %>%
  summarize(total = n())

#We wanted to see how many judges were male vs. female. 
#More men were appaointed to be judges in comparison to female
judges_people %>% 
  group_by(gender) %>%
  summarize(total = n())

#We wanted to see the breakdown of appoined judges by race.
#White was the dominating race
judges_people %>% 
  group_by(race) %>%
  summarize(total = n())

#Wanting to further break the appointed judges down by both race and gender
# White mean and white women both dominate
judges_people %>% 
  group_by(race, gender) %>%
  summarize(total = n())

#We wanted to look at more recent judges to streamline the judges. Then to break down those judges by both race and gender
#We see the same pattern of white men and women having the highest numbers
judges_people %>% 
  filter(birth_date > 1900) %>%
  group_by(race, gender) %>%
  summarize(total = n())


#We picked out select states that we called out to look at the number of appointed judges from each of those states
#New York had the most amount of paper
judges_people %>% 
  filter(birthplace_state %in% c("PA", "NY", "MA", "NJ", "CA", "ND")) %>%
  ggplot(., aes(x = birthplace_state)) + 
  geom_bar()

#Added Alaska and Hawaii
# New York still had the most amount of judges
judges_people %>% 
  filter(birthplace_state %in% c("PA", "NY", "MA", "NJ", "CA", "ND", "AK", "HI")) %>%
  ggplot(., aes(x = birthplace_state)) + 
  geom_bar()

# Performed a left_join on the judges_people and judges-appointments for the chance to make more plots
data <- judges_people %>%
  left_join(judges_appointments, by = "judge_id") 

#Tried to troubleshoot lubridate
year(data$commission_date, format = "%m/%d/%Y")
#Tried to troubleshoot lubridate
ymd(data$commission_date)

#We wanted to see the breakdown of gener and preidential party ot summaize the number of woman/men in each party appointed to be judges
#Then we wanted to arrange by preidental party
data %>% 
  group_by(gender, president_party) %>%
  summarize(total = n()) %>% 
  arrange(president_party)
  


