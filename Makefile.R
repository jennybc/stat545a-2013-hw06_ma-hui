## one script to rule them all

## clean out any previous work
outputs <-
  c(file.path("data", "Disaster_clean.tsv"),
    file.path("output",
              c("maxmean.tsv",            
                "numCountriesno13.tsv",
                "regression.tsv",
                "spreaddeath.tsv")),
    list.files("output", pattern = "*.png$", full.names = TRUE))
file.remove(outputs)

## run my scripts
source(file.path("code", "01_cleanData.R"))
source(file.path("code", "02_aggregatePlot.R"))

## generate the report
knit2html("Report.Rmd", "Report.html")


