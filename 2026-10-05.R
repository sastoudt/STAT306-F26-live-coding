
library(tidyverse)

absolute_judgements <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-03-10/absolute_judgements.csv')
pairwise_comparisons <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-03-10/pairwise_comparisons.csv')
respondent_metadata <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-03-10/respondent_metadata.csv')
#https://github.com/rfordatascience/tidytuesday/blob/107ff6c70de02dd807169e13aee7dc9d86ff88b6/data/2026/2026-03-10/readme.md

absolute_judgements %>%
  group_by(term) %>%
  summarize(avg_probability=mean(probability,na.rm=TRUE)) %>%
  arrange(desc(avg_probability))


ggplot(absolute_judgements,aes(x=term, y = probability)) +
  geom_boxplot()+
  coord_flip()

names(pairwise_comparisons)
head(pairwise_comparisons)

data <- absolute_judgements %>%
  left_join(
    respondent_metadata,
    by = "response_id"
  )

data %>%
  filter(term %in% c("Probable", "Improbable", "Remote Chance", "Likely", "Unlikely")) %>%
  group_by(term, education_level) %>%
  summarize(avg_probability=mean(probability,na.rm=TRUE))  %>%
  view()

data %>%
  filter(term %in% c("Probable", "Improbable", "Remote Chance", "Likely", "Unlikely")) %>%
  ggplot(.,aes(x=term, y = probability, fill = education_level)) +
  geom_boxplot()+
  coord_flip()

data %>%
  group_by(english_background,term) %>%
  filter(term %in% c("Probable", "Improbable", "Remote Chance", "Likely", "Unlikely")) %>%
  summarize(avg_probability=mean(probability,na.rm=TRUE)) %>%
  arrange(term)
