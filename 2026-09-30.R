
library(tidyverse)

exped_tidy <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-01-21/exped_tidy.csv')
peaks_tidy <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-01-21/peaks_tidy.csv')
#https://github.com/rfordatascience/tidytuesday/blob/107ff6c70de02dd807169e13aee7dc9d86ff88b6/data/2025/2025-01-21/read

exped <- exped_tidy
rm(exped_tidy)

peaks <- peaks_tidy
rm(peaks_tidy)

unique(peaks$REGION)

unique(peaks$REGION_FACTOR)

peaks %>%
  group_by(REGION_FACTOR) %>%
  summarise(avg = mean(HEIGHTF, na.rm = TRUE)) 

peaks %>%
  group_by(REGION_FACTOR) %>%
  summarise(avg = mean(HEIGHTF, na.rm = TRUE), peakmin = min(HEIGHTF, na.rm = TRUE),
            peakmax = max(HEIGHTF, na.rm = TRUE), total = n()) %>%
  arrange(desc(total)) 

peaks %>%
  group_by(REGION_FACTOR) %>%
  ggplot(., aes(x=REGION_FACTOR, y= HEIGHTF)) +
  geom_boxplot(fill="pink")+ theme_light()

exped %>%
  arrange(desc(SMTDAYS)) %>%
  select(YEAR,SMTDAYS, LEADERS, SEASON_FACTOR)

exped %>%
  arrange(desc(SMTDAYS)) %>%
  select(PEAKID, YEAR, SMTDAYS, LEADERS, SEASON_FACTOR)

exped %>%
  group_by(SEASON_FACTOR) %>%
  ggplot(., aes(x= SEASON_FACTOR, y= SMTDAYS)) + geom_boxplot(fill= "pink")

exped %>%
  group_by(SEASON_FACTOR) %>%
  ggplot(., aes(x= SEASON_FACTOR, y= SMTDAYS)) + geom_violin(fill= "pink")

exped <- exped %>%
  mutate(iseverest = ifelse(PEAKID == "EVER", "ISEVER", "NOTEVER")) 

exped %>%
  group_by(SEASON_FACTOR) %>%
  ggplot(., aes(x= SEASON_FACTOR, y= SMTDAYS, fill = iseverest)) + geom_boxplot()

exped %>%
  group_by(SEASON_FACTOR) %>%
  filter(iseverest == "NOTEVER") %>%
  ggplot(., aes(x= SEASON_FACTOR, y= SMTDAYS)) + geom_boxplot()
  
exped %>%
  group_by(SEASON_FACTOR) %>%
  filter(iseverest == "ISEVER") %>%
  group_by(CLAIMED) %>%
  summarise(total = n())

exped %>%
  group_by(SEASON_FACTOR) %>%
  filter(iseverest == "NOTEVER") %>%
  group_by(CLAIMED) %>%
  summarise(total = n())

exped %>%
  filter(iseverest == "ISEVER") %>%
  group_by(CLAIMED) %>%
  summarise(total = n())

table(exped$CLAIMED)

