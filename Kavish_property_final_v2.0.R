# This code will do the following tasks - 
# 1. Filter the rows with auction price or no specific price.
# 2. Clean the 'price' column and convert it to numerical data type.
# 3. Remove white spaces from 'structure' column.
# 4. Create relevant plots.


library(tidyverse)
library(lubridate)
library(dplyr)

#New data frame created ----------------------------------------------------------------
(dfdb <- daftdb) %>%
  as_tibble()

#remove houses on auction or price not available ---------------------------------------
#removing them and NOT putting 0's as this would skew the data -------------------------
dfdb <- dfdb %>%
  filter(str_detect(price, "Reserve") == "FALSE") %>%
  filter(str_detect(price, "AMV") == "FALSE") %>%
  filter(str_detect(price, "Price") == "FALSE") %>% 
  print()

#trimmed the house structure string --------------------------------------------------
dfdb$structure <- str_trim(dfdb$structure)
dfdb

#replaced any string or commas --------------------------------------------------------
dfdb$price <- str_replace_all(dfdb$price, "[a-z,A-Z]","")
dfdb

#euro sign removed-------------------------------------------------------------------
dfdb$price <- str_sub(dfdb$price,2)
dfdb


#conversion time-------------------------------------------------------------------
dfdb$price=as.double(dfdb$price)
class(dfdb$price) #successful
dfdb
summary(dfdb$price)

#separating areas and adding "Co. Dublin" in place of NAs --------------------------
dfdb$dublin_code <- str_extract(dfdb$address, "Dublin [0-9]+")
dfdb$dublin_code <- fct_explicit_na(dfdb$dublin_code, na_level = "Co. Dublin")
dfdb

# Find mean in groups and storing in a table and making bar graph -----------
avgbar <- dfdb %>%
  group_by(dublin_code) %>%
  summarise_at(vars(price), mean)

avgbar %>%
  group_by(dublin_code) %>%
  summarise(avgprice = mean(price)) %>%
  arrange(desc(dublin_code)) %>%
  ggplot(aes(reorder(dublin_code, - avgprice), avgprice/100000,fill = avgprice))+
  geom_bar(stat = "identity", width = 0.6) + #fill = 'steelblue'
  scale_fill_continuous(type = "viridis")+
  geom_text(aes(label=round((avgprice/100000),2)), vjust=1.6, color="white", size=3.5)+
  labs(x = "Dublin areas",
       y = "Mean Price (in 100 thousands)",
       title = "Area based Prices(Mean)",
       subtitle = "Year 2020")
# Plotting date vs weekly mean of prices --------------------------------

dfdb[order(as.Date(dfdb$date, format = "%d/%m/%y")),]
dfdb

dfdb %>%
  group_by(week = week(date)) %>%
  summarise(price_wk_avg = mean(price)) %>%
  ggplot(aes((week), price_wk_avg/100000)) +
  geom_line(color = 'blue')+
  labs(x = "Time period (weekly)",
       y = "Price (in 100 thousands)",
       title = "Weekly Mean Prices variation from 9th Feb until 2nd June",
       subtitle = "Year 2020")

#Plotting based on different regions ------------------------------------------
dfdb %>%
  filter(dublin_code == "Dublin 1") %>%
  group_by(week = week(date)) %>%
  summarise(price_wk_avg = mean(price)) %>%
  ggplot(aes((week), price_wk_avg/100000)) +
  geom_line(color = 'magenta')+
  labs(x = "Time period (weekly)",
       y = "Price (in 100 thousands)",
       title = "Weekly Mean Prices variation from 9th Feb until 2nd June",
       subtitle = "Area: Dublin 1")


dfdb %>%
  filter(dublin_code == "Dublin 3") %>%
  group_by(week = week(date)) %>%
  summarise(price_wk_avg = mean(price)) %>%
  ggplot(aes((week), price_wk_avg/100000)) +
  geom_line(color = 'purple')+
  labs(x = "Time period (weekly)",
       y = "Price (in 100 thousands)",
       title = "Weekly Mean Prices variation from 9th Feb until 2nd June",
       subtitle = "Area: Dublin 3")


dfdb %>%
  filter(dublin_code == "Dublin 5") %>%
  group_by(week = week(date)) %>%
  summarise(price_wk_avg = mean(price)) %>%
  ggplot(aes((week), price_wk_avg/100000)) +
  geom_line(color = 'red')+
  labs(x = "Time period (weekly)",
       y = "Price (in 100 thousands)",
       title = "Weekly Mean Prices variation from 9th Feb until 2nd June",
       subtitle = "Area: Dublin 5")


dfdb %>%
  filter(dublin_code == "Dublin 7") %>%
  group_by(week = week(date)) %>%
  summarise(price_wk_avg = mean(price)) %>%
  ggplot(aes((week), price_wk_avg/100000)) +
  geom_line(color = 'IndianRed')+
  labs(x = "Time period (weekly)",
       y = "Price (in 100 thousands)",
       title = "Weekly Mean Prices variation from 9th Feb until 2nd June",
       subtitle = "Area: Dublin 7")


dfdb %>%
  filter(dublin_code == "Dublin 9") %>%
  group_by(week = week(date)) %>%
  summarise(price_wk_avg = mean(price)) %>%
  ggplot(aes((week), price_wk_avg/100000)) +
  geom_line(color = 'DarkOrange')+
  labs(x = "Time period (weekly)",
       y = "Price (in 100 thousands)",
       title = "Weekly Mean Prices variation from 9th Feb until 2nd June",
       subtitle = "Area: Dublin 9")

dfdb %>%
  filter(dublin_code == "Dublin 11") %>%
  group_by(week = week(date)) %>%
  summarise(price_wk_avg = mean(price)) %>%
  ggplot(aes((week), price_wk_avg/100000)) +
  geom_line(color = 'seagreen')+
  labs(x = "Time period (weekly)",
       y = "Price (in 100 thousands)",
       title = "Weekly Mean Prices variation from 9th Feb until 2nd June",
       subtitle = "Area: Dublin 11")

dfdb %>%
  filter(dublin_code == "Dublin 13") %>%
  group_by(week = week(date)) %>%
  summarise(price_wk_avg = mean(price)) %>%
  ggplot(aes((week), price_wk_avg/100000)) +
  geom_line(color = 'LightSeaGreen')+
  labs(x = "Time period (weekly)",
       y = "Price (in 100 thousands)",
       title = "Weekly Mean Prices variation from 9th Feb until 2nd June",
       subtitle = "Area: Dublin 13")

dfdb %>%
  filter(dublin_code == "Dublin 15") %>%
  group_by(week = week(date)) %>%
  summarise(price_wk_avg = mean(price)) %>%
  ggplot(aes((week), price_wk_avg/100000)) +
  geom_line(color = 'DarkTurquoise')+
  labs(x = "Time period (weekly)",
       y = "Price (in 100 thousands)",
       title = "Weekly Mean Prices variation from 9th Feb until 2nd June",
       subtitle = "Area: Dublin 15")

dfdb %>%
  filter(dublin_code == "Dublin 17") %>%
  group_by(week = week(date)) %>%
  summarise(price_wk_avg = mean(price)) %>%
  ggplot(aes((week), price_wk_avg/100000)) +
  geom_line(color = 'DeepSkyBlue')+
  labs(x = "Time period (weekly)",
       y = "Price (in 100 thousands)",
       title = "Weekly Mean Prices variation from 9th Feb until 2nd June",
       subtitle = "Area: Dublin 17")

dfdb %>%
  filter(dublin_code == "Co. Dublin") %>%
  group_by(week = week(date)) %>%
  summarise(price_wk_avg = mean(price)) %>%
  ggplot(aes((week), price_wk_avg/100000)) +
  geom_line(color = 'Maroon')+
  labs(x = "Time period (weekly)",
       y = "Price (in 100 thousands)",
       title = "Weekly Mean Prices variation from 9th Feb until 2nd June",
       subtitle = "Area: Co. Dublin")


# Calculating the rolling average  --------------------------------------------
dfdb <- dfdb %>%
  mutate(price_03da = rollmean(price, k = 3, fill = NA)) %>%
  print()