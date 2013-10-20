## one script to rule them all

## clean out any previous work
outputs <- c("maxmean.tsv",            
             "Disaster_clean.tsv",
             "numCountriesno13.tsv",
             "regression.tsv",
             "spreaddeath.tsv",
             list.files(pattern = "*.png$"))
file.remove(outputs)

## run my scripts
source("01_cleanData.R")
source("02_aggregatePlot.R")

