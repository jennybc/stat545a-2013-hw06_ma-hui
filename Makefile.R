## one script to rule them all

## clean out any previous work
outputs <- c("Disaster.csv",            # 01_cleanData.R
             "Disaster_clean.tsv",  # 02_aggregatePlot.R
             list.files(pattern = "*.png$"))
file.remove(outputs)

## run my scripts
source("01_cleanData.R")
source("02_aggregatePlot.R")
