library(tidyverse)

starbucks <- read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2021/2021-12-21/starbucks.csv")
# https://github.com/rfordatascience/tidytuesday/blob/main/data/2021/2021-12-21/readme.md


## types of milk and quant. var


## which drinks are healthiest? sugar, caffeine, cholesterol

##

ggplot(data = starbucks, aes(x = sugar_g)) +
  geom_histogram() +
  facet_wrap(~size)

just_normal <- starbucks %>% filter(size %in% c("tall", "grande", "venti"))

ggplot(data = just_normal, aes(x = sugar_g)) +
  geom_histogram() +
  facet_wrap(~size)


ggplot(data = just_normal, aes(x = caffeine_mg)) +
  geom_histogram() +
  facet_wrap(~size)

ggplot(data = just_normal, aes(x = cholesterol_mg)) +
  geom_histogram() +
  facet_wrap(~size)


caramel_frap <- starbucks %>% filter(product_name == "Caramel Frappuccino Blended")


caramel_frap %>%
  group_by(milk) %>%
  summarise(
    mS = mean(sugar_g), mF = mean(total_fat_g), mC = mean(total_carbs_g), mCal = mean(calories),
    sdS = sd(sugar_g), sdF = sd(total_fat_g), sdC = sd(total_carbs_g), sdCal = sd(calories),
  )


venti <- starbucks %>% filter(size == "venti")

venti$milk <- as.factor(venti$milk)

ggplot(venti, aes(x = milk, y = sugar_g)) +
  geom_boxplot() +
  theme_minimal()

ggplot(venti, aes(x = milk, y = total_fat_g)) +
  geom_boxplot() +
  theme_minimal()

ggplot(venti, aes(x = milk, y = calories)) +
  geom_boxplot() +
  theme_minimal()


ggplot(venti, aes(x = milk, y = saturated_fat_g)) +
  geom_boxplot() +
  theme_minimal()

ggplot(venti, aes(x = milk, y = trans_fat_g)) +
  geom_boxplot() +
  theme_minimal()

venti$whip <- as.factor(venti$whip)

ggplot(venti, aes(x = caffeine_mg, calories, col = milk)) +
  geom_point(alpha = .5, size = 2) +
  theme_minimal() +
  facet_wrap(~whip)


ggplot(venti, aes(x = sugar_g, calories, col = milk)) +
  geom_point(alpha = .5, size = 2) +
  theme_minimal() +
  facet_wrap(~whip)


starbucks[grep("tea", starbucks$product_name), ]

starbucks$isTea <- grepl("tea", starbucks$product_name, ignore.case = T)


venti <- starbucks %>% filter(size == "venti")

ggplot(venti, aes(x = isTea, y = caffeine_mg)) +
  geom_boxplot() +
  theme_minimal()

starbucks$isIced <- grepl("iced", starbucks$product_name, ignore.case = T)
starbucks$isBlended <- grepl("blended", starbucks$product_name, ignore.case = T)

starbucks$isIceBlend <- (starbucks$isIced | starbucks$isBlended)

venti <- starbucks %>% filter(size == "venti")

ggplot(venti, aes(x = isIced, y = calories)) +
  geom_boxplot() +
  theme_minimal()



