{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)

# Todays date
# 30/11 2020

#Thoughst and intentions
For this assignment I have choosen to do the Visualize Global Development. I need to answer the following 7 questions

## The packages
#First, start with installing the relevant packages 'tidyverse', 'gganimate', and 'gapminder'.
{r library, echo = FALSE}
library(tidyverse)
library(gganimate)
library(gapminder)



## Look at the data

# Q1: Why does it make sense to have a log10 scale on x axis?

# Answer 1: I think it is in order to densify the points so that it makes them comparable by eye



# Q2: What country is the richest in 1952 (far right on x axis)? 

# The dataset contains information on each country in the sampled year, its continent, life expectancy, population, and GDP per capita. I wrote the following to see the graph of 1952 on the right with the x axis telling me the GDP per capita and the y axis telling me the life expectancy: 

gapminder %>% 
  filter(year == 1952) %>% 
  select(gdpPercap, country) %>%
  count(desc(gdpPercap), country)


# Aswer 2: the richest country in 1952 was Kuwait



# Q3: Can you differentiate the continents by color and fix the axis labels?

# To differentiate the continents by color:
ggplot(subset(gapminder, year == 1952), aes(gdpPercap, lifeExp, size = pop)) +
  geom_point(aes(color = continent)) +
  scale_x_log10()

# Fixing the axis labels
ggplot(subset(gapminder, year == 1952), aes(gdpPercap, lifeExp, size = pop)) +
  geom_point(aes(color = continent)) +
  scale_x_log10() +
  labs(title = "Continents GDP per capita and Life Expectancy in 1952", x = "GDP per Capita", y = "Life Expectancy")



# Q4: What are the five richest countries in the world in 2007? 
gapminder %>% 
  filter(year == 2007) %>% 
  select(gdpPercap, country) %>%
  count(desc(gdpPercap), country)

# Answer 4: the 5 richest countries in 2007 was: Norway, Kuwait, Singapore, United States and Ireland




## Make it move!!
# Since the animation in option 1 was jerky I used the animation in option 2:
anim2 <- ggplot(gapminder, aes(gdpPercap, lifeExp, size = pop)) +
  geom_point() +
  scale_x_log10() +
  transition_time(year)
anim2

# Q5: Can you add a title to one or both of the animations above that will change in sync with the animation?

# I had some problems with this since my Macbook saved a bunch of .PNG-files. By looking online I found out I first needed to download the following packages and the restart RStudio:
install.packages('gifski')
install.packages('png')

# Then I wrote the following:
ggplot(gapminder, aes(gdpPercap, lifeExp, size = pop, color = continent)) +
  geom_point() +
  scale_x_log10() +
  labs(title = 'Year: {frame_time}', x = 'GDP per capita', y = 'life expectancy') +
  transition_time(year) 




# Q6 Can you make the axes' labels and units more readable? Consider expanding the abreviated lables as well as the scientific notation in the legend and x axis to whole numbers.[hint:search disabling scientific notation]

anim2 + labs(title = "Year: {frame_time}", x = "GDP per capita", y = "Life Expectancy")+
  aes(gdpPercap, lifeExp, size = pop, color = continent) +
  scale_x_continuous(labels = scales::comma) 



# Q7: Come up with a question you want to answer using the gapminder data and write it down. Then, create a data visualisation that answers the question and explain how your visualization answers the question. (Example: you wish to see what was mean life expectancy across the continents in the year you were born versus your parents' birth years). [hint: if you wish to have more data than is in the filtered gapminder, you can load either the `gapminder_unfiltered` dataset and download more at https://www.gapminder.org/data/ ]

# Question: The top 5 countries that had the highest life expectancy in all the continents in the year 1952 and 2007, since it would be interesting to see the development through the years

# Top 5 countries with the highest life expectancy in 1952
gapminder %>%
  filter(year == 1952) %>% 
  select(lifeExp, country) %>%
  count(desc(lifeExp), country)

#Answer: The top 5 countries that had the highest life expectancy in 1952 was: Norway (72.7 years, Iceland (72,5 years), Netherlands (72,1 years), Sweden (71,9 years),Denmark (70,8 years)


# Top 5 countries with the highest life expectancy in 2007
gapminder %>%
  filter(year == 2007) %>% 
  select(lifeExp, country) %>%
  count(desc(lifeExp), country)

#Answer: The top 5 countries that had the highest life expectancy in 2007: Japan (82,6 years), Hong Kong (82,2 years), Iceland (81,8 years), Switzerland (81,7 years), Australia (81,2 years)

# I was actually surprised that in 1952 Denmark had one of the highest life expectancies. Denmark wasn’t even in the top 10 in the year 2007, so I wanted to also see the life expectancy in Denmark in 2007. To do so I wrote the following:

gapminder %>%
  filter(country == "Denmark", year == 2007) %>%
  select(lifeExp, country) %>% 
  count(desc(lifeExp), country)

# Answer: The life expectancy in Denmark in 2007 was 78,3 years old




# Final Thoughts
# This week was a lot harder than the last since at first the program on my Macbook wouldn’t give me an animation. I had to look for a long time on the internet, but I finally managed to get an answer and then proceed which was fantastic. I’m sure I can use the information I learned in these exercises in the future.






  