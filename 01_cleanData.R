library(plyr)
library(xtable)
library(ggplot2)

NaturalDisaster <- read.csv("disaster.csv") 
## Supercheck whether data has imported correctly
str(NaturalDisaster)

## try to count the number of natural disaster over time on different continents
numCountByYear <- daply(NaturalDisaster,~Year + 
                          Continent, summarize, 
                        TotalCount = sum(NumDisaster))
#numCountByYear <- as.data.frame(numCountByYear)
write.table (numCountByYear,"numCountByYear.tsv", quote = FALSE,
             sep = "\t", row.names = FALSE)

## seems 2013 does not have a lot of observations, Let's drop 2013.
NDisaster <- droplevels(subset(NaturalDisaster,Year != "2013"))
table(NDisaster$Year) #Check whether 2013 has dropped

## try to count the number of countries in each continents
numCountries <- ddply(NDisaster, ~Continent, summarize, numCoutries = length(unique(Country)))
write.table (numCountries,"numCountriesno13.tsv", quote = FALSE,
             sep = "\t", row.names = FALSE)

## Now, let us try to plot a graph and visualize the results
ggplot(NaturalDisaster, aes(x = Year, y = NumDisaster, color = Year)) + geom_jitter() + facet_wrap(~ Continent) +
  ggtitle("How is Number Disasters Changing over Time on Diffferent Continents")
ggsave("stripplot_DisastersbyTime.png")

## Based the above table and graph, it can be found that "Oceania" does not have a lot of data, drop it!
NDisaster <- droplevels(subset(NaturalDisaster,Continent != "Oceania"))
table(NDisaster$Continent) #Check whether "Oceania" has dropped

## Also, I found there are some missing data for Number of people got affected. Let's drop these data!
NDisaster <- droplevels(subset(NDisaster,NumAffected != "0"))
str(NDisaster)

## Since there also a lot of missing data for total damage, let's drop these values.
Disaster <- droplevels(subset(NDisaster,TotalDamUSD != "0"))
str(Disaster)

## Since I want to fit linear regression model in the second script, it is necessary to make sure
## all countries having multiple observations. I will delete the countries with only 2 or less
## observations.

NumObsCountry <- ddply(Disaster, ~Country, summarize, numobs = length(Year))
NumObsCountry

CountryDrop <- droplevels(subset(NumObsCountry,!(numobs > 2)))

Disaster <- droplevels(subset(Disaster,
                              !(Country %in% CountryDrop$Country)))

## Finally, reorder continents based on the total nunmber of disasters happened.
Disaster <- within(Disaster, Continent <- reorder(Continent, NumDisaster, sum))
Disaster <- arrange(Disaster,Continent)

## Here we are, we have a cleaned dataset. Let us save it.
## write data to file
write.table(Disaster, "Disaster_clean.tsv", quote = FALSE,
            sep = "\t", row.names = FALSE)
