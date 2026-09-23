
library(tidyverse)

historical_spending <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2024/2024-02-13/historical_spending.csv')
gifts_age <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2024/2024-02-13/gifts_age.csv')
gifts_gender <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2024/2024-02-13/gifts_gender.csv')
#https://github.com/rfordatascience/tidytuesday/blob/107ff6c70de02dd807169e13aee7dc9d86ff88b6/data/2024/2024-02-13/readme.md

ggplot (historical_spending, (aes(x=Year, y=Flowers)))+
  geom_point()+
  geom_line()

ggplot (historical_spending, (aes(x=Year, y=Candy)))+
  geom_point()+
  geom_line()

ggplot (historical_spending, (aes(x=Flowers, y=PercentCelebrating)))+
  geom_point()+
  geom_line()

ggplot (historical_spending, (aes(x=Year, y=PercentCelebrating)))+
  geom_point()+
  geom_line()

ggplot (gifts_age, (aes(x=Age, y=Jewelry)))+
  geom_col()

ggplot (gifts_age, (aes(x=Age, y=Candy)))+
  geom_col()

ggplot (gifts_age, (aes(x=Age, y=EveningOut)))+
  geom_col()

ggplot (gifts_age, (aes(x=Age, y=Flowers)))+
  geom_col()

ggplot (gifts_gender, (aes(x=Gender, y=Flowers)))+
  geom_boxplot()

gifts_age %>%
  filter(Age == "18-24")

historical_spending %>%
  mutate(total = Candy + Flowers+ Jewelry + GreetingCards+ EveningOut+ Clothing+ GiftCards)%>%
  ggplot(., aes(x=Year, y= total))+
           geom_point()+
           geom_line()

historical_spending %>%
  mutate(total = Candy + Flowers+ Jewelry + GreetingCards+ EveningOut+ Clothing+ GiftCards)%>%
  ggplot(., aes(x=Year, y= total, colour = GreetingCards))+
  geom_point()+
  geom_line(lwd=3)

ggplot(historical_spending, aes(x=PercentCelebrating, y=PerPerson, color= Year))+ 
  geom_point(size=3)+ 
  theme_minimal()



