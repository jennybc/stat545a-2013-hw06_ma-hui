library(arm)
library(ggplot2)
library(plyr)

Disaster <- read.delim("Disaster_clean.tsv")

## try to get the maximum and minimum of total affected population
## for all continents
maxmeanaffected <- ddply(Disaster, ~ Continent, summarize, 
                        meanAffPop = mean(AffectedPop),
                        maxAffPop = max(AffectedPop))
htmlPrint(arrange(maxmeanaffected,meanAffPop))

## try to get the spread of death within the continents
spreaddeath <- ddply(Disaster, ~ Continent, summarize,
                     sdNumKilled = sd(NumKilled), 
                     madNumKilled = mad(NumKilled),
                     iqrNumKilled = IQR(NumKilled))
htmlPrint(arrange(spreaddeath, sdNumKilled))

mFun <- function(x) {
  model <- lm(TotalDamUSD ~ NumDisaster, x)
  estCoefs <- c(coef(model))
  estSE <- c(se.coef(model))
  names(estCoefs) <- c("intercept", "NumDisaster")
  names(estSE) <- c("SE(intercept)", "SE(NumDisaster)")
  return (c(estCoefs,estSE))
}

mCoefs <- ddply(Disaster, ~Country, mFun)

## make some plots
p <- ggplot(Disaster, aes(x = Year, y = NumDisaster, color = Year))+ 
  geom_jitter() + facet_wrap(~ Continent) + geom_line(stat = "summary", fun.y = "mean", col = "red", lwd = 1) +
  ggtitle("How is Number of Disasters Changing over Time on Diffferent Continents") + 
  scale_x_continuous(name = "Year", breaks = seq(min(Disaster$Year), max(Disaster$Year), by = 2))  + 
  xlab("Year") + ylab("Number of Disasters") 
print(p)

## By looking at above graph, we can see American and Asia has more natural disasters than other continents. 
## Let's have a close look at these two continents.

AsiaAmerica <- subset(Disaster,Continent == c("Asia", "Americas"))
