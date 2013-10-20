library(arm)
library(ggplot2)
library(plyr)
library(xtable)
library(reshape2)

Disaster <- read.delim("Disaster_clean.tsv")


## Learn from JB's code
## infer order of Race and Film factors from order in file
Disaster <-
  within(Disaster, {
    Continent <- factor(as.character(Continent), 
                        levels = unique(Disaster$Continent))
  })
## Yes! It is still follow the order!!!!!

## try to get the spread of death within the continents
spreaddeath <- ddply(Disaster, ~ Continent, summarize,
                     sdNumKilled = sd(NumKilled), 
                     iqrNumKilled = IQR(NumKilled))
write.table (spreaddeath,"spreaddeath.tsv", quote = FALSE,
             sep = "\t", row.names = FALSE)

newspread <- melt(spreaddeath, id="Continent")
ggplot(newspread, aes(x = Continent, y = value, colour = variable)) + 
  geom_point() + geom_line(aes(x=as.numeric(Continent)))+ ylab("spread") +
  ggtitle("Measure of Spread")
ggsave("line_MeasureofSpread.png")

## try to produce the maximum and minimum statistics 
## for different variables in all continents
## for all continents
maxmean<- ddply(Disaster, ~ Continent, summarize, 
                meanDamage = mean(TotalDamUSD),
                maxDamage= max(TotalDamUSD),
                meanAffPop = mean(NumAffected),
                maxAffPop = max(NumAffected),
                meanInjured = mean(NumInjured),
                maxInjured = max(NumInjured),
                meanDeath = mean(NumKilled),
                maxDeath = max(NumKilled),
                meanHomeless = mean(NumHomeless),
                maxHomeless = max(NumHomeless)
)
write.table (maxmean,"maxmean.tsv", quote = FALSE,
             sep = "\t", row.names = FALSE)

## We have summarized some detailed information about different 
## variables in the dataset. Now, let's discouver more details.
## First,let's identify which varibales play an important role to predict 
## the damaged amount from natural disasters.

## First, Let us to fit the full model.
FullModel <- lm(TotalDamUSD ~ NumDisaster + NumKilled + NumInjured +
                  NumAffected +NumHomeless, data = Disaster)
summary(FullModel)

## Based on the summmary, it can be shown that number of disasters 
## played a significant role to determine the damaged amount. 
## Therefore, I will pay more attention on whether the
## number of disasters also play an essential role in country level.

mFun <- function(x) {
  model <- lm(TotalDamUSD ~ NumDisaster, x)
  estCoefs <- c(coef(model))
  estSE <- c(se.coef(model))
  ## 2 means 2nd row (we do not want to test intercept), 
  ## 4 means the 4th column, which corresponding to p-value
  p_value <- summary(model)$coefficients[2, 4]  
  names(estCoefs) <- c("intercept", "NumDisaster")
  names(estSE) <- c("SE(intercept)", "SE(NumDisaster)")
  names(p_value) <- "p-value (NumDisaster)"
  return (c(estCoefs,estSE,p_value))
}

mCoefs <- ddply(Disaster, ~Country, mFun)
write.table (mCoefs,"regression.tsv", quote = FALSE,
             sep = "\t", row.names = FALSE)

## I tried my best, but I am not sure whether this is the correct way.
## Based on above table, we found that even though the number 
## of disasters play an critical role in the world level, 
## it does not significant in country level for most countries. 
## It might because the individual country has limited sample size. 
## Thus, the standard error is huge.

## The next topic that I would like to focus on is how the number of 
## disasters changing over time on different continents.

## To begin with, let us plot the number of disasters in different continents.

ggplot(Disaster,aes(x=NumDisaster, fill= Continent)) + facet_wrap(~Continent)+
  geom_bar(binwidth = 2, color = "black") +
  ggtitle("Number of Disasters in Diffferent Continents")
ggsave("barchart_DisasterbyContinent.png")

## After having some basic ideas about the frequency of the number of disasters in 
## different continents,I will look at the number of disasters changing over time 
## on diffferent continents

ggplot(Disaster, aes(x = Year, y = NumDisaster, color = Year))+ 
  geom_jitter() + facet_wrap(~ Continent) + 
  geom_line(stat = "summary", fun.y = "mean", col = "red", lwd = 1) +
  ggtitle("How is Number of Disasters Changing over Time on Diffferent Continents") + 
  scale_x_continuous(name = "Year", breaks = seq(min(Disaster$Year), 
                                                 max(Disaster$Year), by = 2))  + 
  xlab("Year") + ylab("Number of Disasters")
ggsave("stripplot_NumofDisTimeContinent.png")

## Based on the plot, there is no significan relationship beween the number of disasters 
## and time. However, it can be found that there is some difference for the number of 
## disasters across continents.

## Next, try boxplot for the year 2000, 2005 and 2010
ggplot(subset(Disaster, Year %in% c(2000,2005,2010)), aes(x = factor(Year), 
                                                          y = NumDisaster, 
                                                          fill = Continent), 
       groups = Continent) + geom_boxplot(alpha = 0.2, outlier.colour= "red") 
ggsave("boxplot_DisasterbyYear.png")

## Obviously, Asia has more variation for the number of disasters.

## Finally, let us try another plot about the number of disasters changing over 
## time on diffferent continents
low_number= 10
ggplot(Disaster, aes(x = Year, y = NumDisaster, 
                     colour = NumDisaster <= low_number)) + 
  geom_jitter(position = position_jitter(width = .2)) + 
  facet_wrap(~ Continent) + 
  ggtitle(paste("NumDisaster <= ", low_number)) + 
  theme(plot.title = element_text(face="bold")) + 
  ggtitle("Show Number of Disasters by Year across Continents") + 
  scale_colour_discrete(name="",breaks=c("FALSE", "TRUE"),
                        labels=c("Death > 5", "Death <= 5")) +
  scale_x_continuous(name = "Year", breaks = seq(min(Disaster$Year), 
                                                 max(Disaster$Year), by = 2)) 
ggsave("stripplot_DisasterbyYC.png")


## By looking at above graph, we can see Americas and Asia have more natural 
## disasters than other continents.


## Now, Let us look at a special plot: dots scatterplot of number of natural 
## disaster over year for China. Why??

ggplot(subset(Disaster, Country == "China P Rep"), aes(x = Year, y = NumKilled)) + 
  geom_line(lwd=1) + xlab("Year") + ylab("Number killed") +
  ggtitle("How is Number of People Killed over time in People's Repubic of China") +
  scale_x_continuous(name = "Year", breaks = seq(min(Disaster$Year), 
                                                 max(Disaster$Year), by = 2)) 
ggsave("line_NumKilledChina.png")


## The graph shows that more than 80,000 were killed by natural disaster 
## in the year of 2008 in China. That was Sichuan Earthquake. At that time, 
## I was also in Sichuan and experienced this catastrophe. I feel sorry for 
## those people who lost their lives during this disaster.Since I experienced 
## this natural disaster, I would think this is an important plot for me!!


## Next, I would like to evaluate whether there is a relationship between affected 
## population and death across continents.The question is that whether more people got 
## affected will lead more people be killed? Since some natural disasters caused a lot of 
## people lost lives, I used log transformation (**Question** Log transformation may not make sense?)

ggplot(NDisaster, aes(x = NumAffected, y = NumKilled, color = Continent)) + 
  geom_point() + scale_x_log10() + scale_y_log10()+
  ggtitle("How NumKilled related to NumAffected across Continents") 
ggsave("points_NumKilledwithAffected.png")

## Based on the graph, it can be seen that with the increase of number of people got affected,
## there is a slightly increasing trend for the number of people got killed.



