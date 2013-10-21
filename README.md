Huiting Ma
=========================

**Deonstration data:** This homework is to analyze the **Natural Disasters** around the world from the year 2000 to 2013. The natural disasters include earthquake, volcano and mass movement. My main focus is to identify which continents or countries have more natural disasters and whether the number of death, injuries, homeless and the population affected are correlated with the damaged amount. The dataset I am going to use is from EM-DAT, which is the International Disaster Database [here](http://www.emdat.be/database).

The definition of all variables can be found in the above website, which are:

- `NumDisaster` A unique disaster number for each event 
- `Country` Country (ies) in which the disaster has occurred
- `Year` When the disaster occurred. 
- `NumKilled` Persons confirmed as dead and persons missing and presumed dead (official figures when available)
- `NumInjured` People suffering from physical injuries, trauma or an illness requiring medical treatment as a direct result of a disaster
- `NumHomeless` People needing immediate assistance for shelter
- `NumAffected` People requiring immediate assistance during a period of emergency; it can also include displaced or evacuated people
- `TotalDamUSD` Several institutions have developed methodologies to quantify these losses in their specific domain. However, there is no standard procedure to determine a global figure for economic impact. Estimated damages are given (000') US$

**The Purpose of This Analysis**
* Clean a dataset from online and extract useful information
* Fit linear regression model and identify which variables have significant influence on the total damaged amount(USD)
* Discover the relationship beween the number of disasters in each continent with the changing of time
* Identify the relationship between the number of killed people with the number of affected population

**Important: I have reported all my results and analyses [here](http://rpubs.com/Huiting/stat545a-2013-hw06_ma-hui)**
* I also included my R-markdown file in Report folder [Report.RMD](https://github.com/horsehuiting/stat545a-2013-hw06_ma-hui/blob/master/Report/Report.Rmd)
* You could download for future use

**How to replicate my analysis**
* Download all files from **input folder** into an empty directory:
    - **Input data:** [`Disaster.csv`](https://github.com/horsehuiting/stat545a-2013-hw06_ma-hui/blob/master/Input/Disaster.csv)
    - **Scripts:** [`01_cleanData.R`](https://github.com/horsehuiting/stat545a-2013-hw06_ma-hui/blob/master/Input/01_cleanData.R)(Clean the raw dataset) and [`02_aggregatePlot.R`](https://github.com/horsehuiting/stat545a-2013-hw06_ma-hui/blob/master/Input/02_aggregatePlot.R)(Data aggregation and visualization)
    - **Makefile-like script:** [`Makefile.R`](https://github.com/horsehuiting/stat545a-2013-hw06_ma-hui/blob/master/Input/Makefile.R)
  * Start a fresh RStudio session, make sure the above directory is the working directory, open `Makefile.R`, and click on "Source".
  * Alternatively, in a shell: `Rscript Makefile.R`.
  * When you run the pipeline the first time, you will get warnings about `file.remove()` trying to remove files that don't exist. That's OK. They will exist and will be removed and remade on subsequent runs.
  * New files you should see after running the pipeline (all in **output folder**):
    - [`Disaster_clean.tsv`](https://github.com/horsehuiting/stat545a-2013-hw06_ma-hui/blob/master/Output/Disaster_clean.tsv)
    - [`barchart_DisasterbyContinent.png`](https://github.com/horsehuiting/stat545a-2013-hw06_ma-hui/blob/master/Output/barchart_DisasterbyContinent.png)
    - [`boxplot_DisasterbyYear.png`](https://github.com/horsehuiting/stat545a-2013-hw06_ma-hui/blob/master/Output/boxplot_DisasterbyYear.png)
    - [`line_MeasureofSpread.png`](https://github.com/horsehuiting/stat545a-2013-hw06_ma-hui/blob/master/Output/line_MeasureofSpread.png)
    - [`points_NumKilledwithAffected.png`](https://github.com/horsehuiting/stat545a-2013-hw06_ma-hui/blob/master/Output/points_NumKilledwithAffected.png)
    - [`stripplot_DisasterbyYC.png`](https://github.com/horsehuiting/stat545a-2013-hw06_ma-hui/blob/master/Output/stripplot_DisasterbyYC.png)
    - [`stripplot_DisastersbyTime.png`](https://github.com/horsehuiting/stat545a-2013-hw06_ma-hui/blob/master/Output/stripplot_DisastersbyTime.png)
    - [`stripplot_NumofDisTimeContinent.png`](https://github.com/horsehuiting/stat545a-2013-hw06_ma-hui/blob/master/Output/stripplot_NumofDisTimeContinent.png)
    - [`line_NumKilledChina.png`](https://github.com/horsehuiting/stat545a-2013-hw06_ma-hui/blob/master/Output/line_NumKilledChina.png)
    - [`scatterplot_NumDisasterByYear_Brazil.png`](https://github.com/horsehuiting/stat545a-2013-hw06_ma-hui/blob/master/Output/scatterplot_NumDisasterByYear_Brazil.png)
    - [`scatterplot_NumDisasterByYear_China_P_Rep.png`](https://github.com/horsehuiting/stat545a-2013-hw06_ma-hui/blob/master/Output/scatterplot_NumDisasterByYear_China_P_Rep.png)
    - [`scatterplot_NumDisasterByYear_India.png`](https://github.com/horsehuiting/stat545a-2013-hw06_ma-hui/blob/master/Output/scatterplot_NumDisasterByYear_India.png)
    - [`scatterplot_NumDisasterByYear_Indonesia.png`](https://github.com/horsehuiting/stat545a-2013-hw06_ma-hui/blob/master/Output/scatterplot_NumDisasterByYear_Indonesia.png)
    - [`scatterplot_NumDisasterByYear_Japan.png`](https://github.com/horsehuiting/stat545a-2013-hw06_ma-hui/blob/master/Output/scatterplot_NumDisasterByYear_Japan.png) 
    - [`scatterplot_NumDisasterByYear_Mexico.png`](https://github.com/horsehuiting/stat545a-2013-hw06_ma-hui/blob/master/Output/scatterplot_NumDisasterByYear_Mexico.png)
    - [`scatterplot_NumDisasterByYear_Philippines.png`](https://github.com/horsehuiting/stat545a-2013-hw06_ma-hui/blob/master/Output/scatterplot_NumDisasterByYear_Philippines.png)
    - [`scatterplot_NumDisasterByYear_Russia.png`](https://github.com/horsehuiting/stat545a-2013-hw06_ma-hui/blob/master/Output/scatterplot_NumDisasterByYear_Russia.png)
    - [`scatterplot_NumDisasterByYear_Tajikistan.png`](https://github.com/horsehuiting/stat545a-2013-hw06_ma-hui/blob/master/Output/scatterplot_NumDisasterByYear_Tajikistan.png)
    - [`scatterplot_NumDisasterByYear_Thailand.png`](https://github.com/horsehuiting/stat545a-2013-hw06_ma-hui/blob/master/Output/scatterplot_NumDisasterByYear_Thailand.png)
    - [`scatterplot_NumDisasterByYear_United_States.png`](https://github.com/horsehuiting/stat545a-2013-hw06_ma-hui/blob/master/Output/scatterplot_NumDisasterByYear_United_States.png)
    - [`scatterplot_NumDisasterByYear_Viet_Nam.png`](https://github.com/horsehuiting/stat545a-2013-hw06_ma-hui/blob/master/Output/scatterplot_NumDisasterByYear_Viet_Nam.png)
    - [`maxmean.tsv `](https://github.com/horsehuiting/stat545a-2013-hw06_ma-hui/blob/master/Output/maxmean.tsv)
    - [`numCountriesno13.tsv`](https://github.com/horsehuiting/stat545a-2013-hw06_ma-hui/blob/master/Output/numCountriesno13.tsv)
    - [`regression.tsv.tsv`](https://github.com/horsehuiting/stat545a-2013-hw06_ma-hui/blob/master/Output/regression.tsv)
    - [`spreaddeath.tsv`](https://github.com/horsehuiting/stat545a-2013-hw06_ma-hui/blob/master/Output/spreaddeath.tsv)

