
library(tidyverse)

historical_spending <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2024/2024-02-13/historical_spending.csv')
gifts_age <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2024/2024-02-13/gifts_age.csv')
gifts_gender <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2024/2024-02-13/gifts_gender.csv')
#https://github.com/rfordatascience/tidytuesday/blob/107ff6c70de02dd807169e13aee7dc9d86ff88b6/data/2024/2024-02-13/readme.md


# scatter plot looking at spending over the years and avg amount spent on flowers
# noticed dip around 2017
ggplot (historical_spending, (aes(x=Year, y=Flowers)))+
  geom_point()+
  geom_line()

# same as above, but now avg amount spent on candy
# still has more subtle dip around 2017
ggplot (historical_spending, (aes(x=Year, y=Candy)))+
  geom_point()+
  geom_line()

# scatter plot of flowers and percent of ppl celebrating vday
ggplot (historical_spending, (aes(x=Flowers, y=PercentCelebrating)))+
  geom_point()+
  geom_line()

# scatter plot of year and percent of ppl celebrating vday
# dip now present around 2018/2019
# somewhat overall decreasing trend, as yr inc, percent of ppl celebrating dec
ggplot (historical_spending, (aes(x=Year, y=PercentCelebrating)))+
  geom_point()+
  geom_line()

# bar chart of age (grouped in bins), and avg percent spending on jewelry
# see decreasing trend, as age increases, avg percent spending on jewelry dec
ggplot (gifts_age, (aes(x=Age, y=Jewelry)))+
  geom_col()

# bar chart of age (grouped in bins), and avg percent spending on candy
# see more slight but still see decreasing trend as age increases
ggplot (gifts_age, (aes(x=Age, y=Candy)))+
  geom_col()

# bar chart of age (grouped in bins), and avg percent spending on an evening out
# see decreasing trend, as age increases, avg percent spending on an evening out dec
ggplot (gifts_age, (aes(x=Age, y=EveningOut)))+
  geom_col()

# bar chart of age (grouped in bins), and avg percent spending on flowers
# see decreasing trend, as age increases, avg percent spending on flowers dec
ggplot (gifts_age, (aes(x=Age, y=Flowers)))+
  geom_col()

# boxplot of gender and flowers
# only shows two bars
ggplot (gifts_gender, (aes(x=Gender, y=Flowers)))+
  geom_boxplot()

# filters 'gifts_age' data set to just age group 18-24
gifts_age %>%
  filter(Age == "18-24")

# adds a column to 'historical_spending' data set
# new column is sum of many other variables
# creates scatter plot using this data set w new column, plots year and total
# shows overall increasing trend of average amount spending
historical_spending %>%
  mutate(total = Candy + Flowers+ Jewelry + GreetingCards+ EveningOut+ Clothing+ GiftCards)%>%
  ggplot(., aes(x=Year, y= total))+
           geom_point()+
           geom_line()

# same scatter plot as above, but colored by avg amount spending on greeting cards
historical_spending %>%
  mutate(total = Candy + Flowers+ Jewelry + GreetingCards+ EveningOut+ Clothing+ GiftCards)%>%
  ggplot(., aes(x=Year, y= total, colour = GreetingCards))+
  geom_point()+
  geom_line(lwd=3)

# scatter plot, percent of ppl celebrating and avg amount each person is spending
# shows when more ppl celebrate it's more of a casual thing
ggplot(historical_spending, aes(x=PercentCelebrating, y=PerPerson, color= Year))+ 
  geom_point(size=3)+ 
  theme_minimal()



