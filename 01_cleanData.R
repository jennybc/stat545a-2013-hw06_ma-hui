#byYear <- read.csv("Bycontinent.csv",head=TRUE)
#ByContinent<-read.csv("Byyear.csv", head=TRUE)
#http://docs.ggplot2.org/current/


library(plyr)
library(xtable)
library(ggplot2)

NaturalDisaster <- read.csv("disaster.csv") 
##Supercheck whether data has imported correctly
str(NaturalDisaster)

## Learn from Jennie, to define a function for
## converting and printing to HTML table
htmlPrint <- function(x, ...,
                      digits = 0, include.rownames = FALSE) {
  print(xtable(x, digits = digits, ...), type = 'html',
        include.rownames = include.rownames, ...)
}



## try to count the number of natural disaster over time on different continents
numCountByYear <- daply(NaturalDisaster,~Year + 
                          Continent, summarize, 
                        TotalCount = sum(NumDisaster))
numCountByYear <- as.data.frame(numCountByYear)
htmlPrint(numCountByYear)

## seems 2013 does not have a lot of observations, Let's drop 2013.
NDisaster <- droplevels(subset(NaturalDisaster,Year != "2013"))
table(NDisaster$Year) #Check whether 2013 has dropped


## try to count the number of countries in each continents
numCountries <- ddply(NDisaster, ~Continent, summarize, numCoutries = length(unique(Country)))
htmlPrint(numCountries)

## Based on the graph, it is found that "Oceania" does not have a lot of data, drop it!
NDisaster <- droplevels(subset(NaturalDisaster,Continent != "Oceania"))
table(NDisaster$Continent) #Check whether "Oceania" has dropped


## Also, I found there are some missing data for Number of affected. Let's drop these data!
NDisaster <- droplevels(subset(NDisaster,NumAffected != "0"))
str(NDisaster)


## Let's try to find the relationship between affected population and death across continents
ggplot(NDisaster, aes(x = NumAffected, y = NumKilled, color = Continent)) +
  geom_point() + scale_x_log10() +
  ggtitle("How is Number of People Killed related to Number of People Affected on Diffferent Continents")   


## It can be found that there are some natural disasters caused a lot of people lost lives, now let's pay 
## more attention on 90% points.
ggplot(NDisaster, aes(x = NumAffected, y = NumKilled, color = Continent)) + 
  scale_y_continuous(limits = c(0, 1000))  + geom_point() + scale_x_log10()
  ggtitle("How is Number of People Killed related to Number of People Affected on Diffferent Continents") 

## connect the dots scatterplot of number of natural disaster over year for one country
ggplot(subset(NDisaster, Country == "China P Rep"), aes(x = Year, y = NumKilled)) + 
  geom_line() + xlab("Year") + ylab("Number killed") +
  ggtitle("How is Number of People Killed over time in People's Repubic of China") +
  scale_x_continuous(name = "Year", breaks = seq(min(NDisaster$Year), max(NDisaster$Year), by = 2)) 

## The graph shows that more than 80,000 were killed by natural disaster in the year of 2008 in China. 
## That was Sichuan Earthquake. At that time, I was also in Sichuan and experienced this 
## catastrophe. I feel sorry for those people who lost their lives during this disaster.

## ReDisaster <- within(NDisaster, Continent <- reorder(Continent, NumDisaster))

## Since there also a lot of missing data for Total damage, let's drop these values.
Disaster <- droplevels(subset(NDisaster,TotalDamUSD != "0"))
str(Disaster)

## Since I want to fit linear regression model in the second script, it is necessary to make sure
## all countries should have multiple observations. I will delete the countries with only 2 or less
## observations.

NumObsCountry <- ddply(Disaster, ~Country, summarize, numobs = length(Year))
NumObsCountry

CountryDrop <- droplevels(subset(NumObsCountry,!(numobs > 2)))


Disaster <- droplevels(subset(Disaster,
                              !(Country %in% CountryDrop$Country)))

## write data to file
write.table(Disaster, "Disaster_clean.tsv", quote = FALSE,
            sep = "\t", row.names = FALSE)
