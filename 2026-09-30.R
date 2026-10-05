
library(tidyverse)

exped_tidy <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-01-21/exped_tidy.csv')
peaks_tidy <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-01-21/peaks_tidy.csv')
#https://github.com/rfordatascience/tidytuesday/blob/107ff6c70de02dd807169e13aee7dc9d86ff88b6/data/2025/2025-01-21/read

# turn exped_tidy into exped, get rid of exped_tidy
exped <- exped_tidy
rm(exped_tidy)

# turn peaks_tidy into peaks, remove peaks_tidy
peaks <- peaks_tidy
rm(peaks_tidy)

# see all of the possible values of REGION column
unique(peaks$REGION)

# see all of the possible values of REGION_FACTOR
unique(peaks$REGION_FACTOR)

# take the peaks df, group rows by REGION_FACTOR, and then get the mean HEIGHT_F of each group, do not include NA rows. 
peaks %>%
  group_by(REGION_FACTOR) %>%
  summarise(avg = mean(HEIGHTF, na.rm = TRUE)) 

# take peaks df, group rows by REGION_FACTOR, get the average height, the minimum and maximum height of each region, and the total
# arrange in descending order, highest total will be first. 
peaks %>%
  group_by(REGION_FACTOR) %>%
  summarise(avg = mean(HEIGHTF, na.rm = TRUE), peakmin = min(HEIGHTF, na.rm = TRUE),
            peakmax = max(HEIGHTF, na.rm = TRUE), total = n()) %>%
  arrange(desc(total)) 

# take peaks df, group by REGION_FACTOR, make box plots with height in feet on the x-axis and each region on the y-axis
# color each boxplot, and use light theme
peaks %>%
  group_by(REGION_FACTOR) %>%
  ggplot(., aes(x=REGION_FACTOR, y= HEIGHTF)) +
  geom_boxplot(fill="pink")+ theme_light()

# take exped df, arrange in descending order by the amount of days for each trip, and only keep the year, smtdays, leaders, and season_factor columns
exped %>%
  arrange(desc(SMTDAYS)) %>%
  select(YEAR,SMTDAYS, LEADERS, SEASON_FACTOR)

# take exped df, arrange in descending order by amount of days for each trip, only keep the year, smtdays, leaders, season_factor and peakid
exped %>%
  arrange(desc(SMTDAYS)) %>%
  select(PEAKID, YEAR, SMTDAYS, LEADERS, SEASON_FACTOR)

# take esped df, group by season_factor, and then make a vertical boxplot of smtdays by each season in each season factor
exped %>%
  group_by(SEASON_FACTOR) %>%
  ggplot(., aes(x= SEASON_FACTOR, y= SMTDAYS)) + geom_boxplot(fill= "pink")

# same thing as above expect makes a violin plot, which shows density of points on boxplot
exped %>%
  group_by(SEASON_FACTOR) %>%
  ggplot(., aes(x= SEASON_FACTOR, y= SMTDAYS)) + geom_violin(fill= "pink")

# make a new column in exped which uses peakid to make binary variable "iseverest": "ISEVER" if yes, "NOTEVER" if no. 
exped <- exped %>%
  mutate(iseverest = ifelse(PEAKID == "EVER", "ISEVER", "NOTEVER")) 

# take esped df, group by season, and then plot the same vertical boxplot but with two boxplots, one for is everest, and one for not everest
exped %>%
  group_by(SEASON_FACTOR) %>%
  ggplot(., aes(x= SEASON_FACTOR, y= SMTDAYS, fill = iseverest)) + geom_boxplot()

# take exped df, group by season, filter for only peaks that are not on everest, and then plot the boxplots of amount of days (y) vs seasons (x).
exped %>%
  group_by(SEASON_FACTOR) %>%
  filter(iseverest == "NOTEVER") %>%
  ggplot(., aes(x= SEASON_FACTOR, y= SMTDAYS)) + geom_boxplot()
  
# take exped df group by season, filter for only everest peaks, group rows by claimed status, and then find the total for each group
exped %>%
  group_by(SEASON_FACTOR) %>%
  filter(iseverest == "ISEVER") %>%
  group_by(CLAIMED) %>%
  summarise(total = n())

# take exped df group by season, filter for only non-everest peaks, group rows by claimed status, and then find the total for each group
exped %>%
  group_by(SEASON_FACTOR) %>%
  filter(iseverest == "NOTEVER") %>%
  group_by(CLAIMED) %>%
  summarise(total = n())

# take exped df, filter for everest peaks only, and then group by values of CLAIMED, 
exped %>%
  filter(iseverest == "ISEVER") %>%
  group_by(CLAIMED) %>%
  summarise(total = n())

# get the unique values along with the frequency in the CLAIMED column
table(exped$CLAIMED)

