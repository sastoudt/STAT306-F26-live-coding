
library(tidyverse)

data <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2024/2024-10-08/most_visited_nps_species_data.csv')
#https://github.com/rfordatascience/tidytuesday/blob/107ff6c70de02dd807169e13aee7dc9d86ff88b6/data/2024/2024-10-08/readme.md 

#Create new data frame called data_cat_name
#Group by the category name of the species (bird, mammal, vascular plant etc.)
#Find total number of species in each category
data_cat_name <- data %>%
  group_by(CategoryName) %>%
  summarize(total = n())

#Create new data frame called data_nativeness
#Group by whether or not the species is native to the area or not (Native/Non-native/Unkownn/NA)
#Find total number of species that are Native/Non-native/Unkownn/NA
data_nativeness <- data %>%
  group_by(Nativeness) %>%
  summarize(total = n())

#Find all unique National Park names in the data set
unique(data$ParkName)

#Create new data frame called barchart_data
#Filter down to just species in Grand Canyon, Olympic, and Cuyahoga Valley National Parks
#Find total number of species in each respective park
#Arrange by the park name to have all the Cuyahoga Valley totals, then the Grand Canyon totals, then the Olympic totals
barchart_data <- data %>%
  filter(ParkName %in% c("Grand Canyon National Park", "Olympic National Park", "Cuyahoga Valley National Park")) %>%
  group_by(Nativeness, ParkName) %>%
  summarize(total = n()) %>%
  arrange(ParkName)

#Reassign barchart_data data frame
#Filter down data to only include species from Grand Canyon, Olympic, and Cuyahoga Valley National Parks 
barchart_data <- data %>%
  filter(ParkName %in% c("Grand Canyon National Park", "Olympic National Park", "Cuyahoga Valley National Park"))

#Create a bar chart from barchart_data where each bar is one of the three national parks
#Have each bar filled by the proportions of each nativeness type so the proportions can be compared across parks
ggplot(data = barchart_data, aes(x = ParkName, fill = Nativeness)) + geom_bar(position = "fill")

#Comment out line of code which does not work
#data %>%
#  filter(TEStatus = "")

#Create table for counts of the attribute TEStatus, which indicates any FWS Threatened or Endangered species status
table(data$TEStatus)

#Create table for counts of the attribute Sensitive, which indicates whether or not the species is 'sensitive'
table(data$Sensitive)

#Create table for counts of the attribute OzoneSensitiveStatus, which indicates whether or not the species is sensitive to ozone
table(data$OzoneSensitiveStatus)

#Create new data frame called data_parks
#Filter does to the three national parks from before
#Group by Order (the species' order) and Park Name
#Find counts for each Order/Park Name combination
data_parks <- data %>%
  filter(ParkName %in% c("Grand Canyon National Park", "Olympic National Park", "Cuyahoga Valley National Park")) %>%
  group_by(Order, ParkName) %>%
  summarize(total = n())

#Create new data frame called data_cat_name_2
#Filter does to the three national parks from before
#Group by CategoryName (the species' category) and Park Name
#Find counts for each Category Name/Park Name combination
data_cat_name_2 <- data %>%
  filter(ParkName %in% c("Grand Canyon National Park", "Olympic National Park", "Cuyahoga Valley National Park")) %>%
  group_by(CategoryName, ParkName) %>%
  summarize(total = n())

#Create new box plot called data_for_boxplot
#Group by CategoryName (the species' category) and Park Name
#Find counts for each Category Name/Park Name combination
#Create box plot of the counts
data_for_boxplot <- data %>%
  group_by(CategoryName, ParkName) %>%
  summarize(total = n()) %>%
  ggplot(., aes(x = CategoryName, y = total)) + geom_boxplot()

#Look at the box plot
data_for_boxplot

#Look at the data frame `data`
#Group by CategoryName and Park Name
#Find counts for each Category Name/Park Name combination
#Arrange the counts of each combination in descending order
data %>%
  group_by(CategoryName, ParkName) %>%
  summarize(total = n()) %>%
  arrange(desc(total))
  