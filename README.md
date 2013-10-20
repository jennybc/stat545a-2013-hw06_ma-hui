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

**How to replicate my analysis**
* Download into an empty directory:
    - Input data: [`Disaster.csv`](https://github.com/horsehuiting/stat545a-2013-hw06_ma-hui/blob/master/Disaster.csv)
    - Scripts: [`01_cleanData.R`](https://github.com/horsehuiting/stat545a-2013-hw06_ma-hui/blob/master/01_cleanData.R) and [`02_aggregatePlot.R`](https://github.com/horsehuiting/stat545a-2013-hw06_ma-hui/blob/master/02_aggregatePlot.R)
    - Makefile-like script: [`Makefile.R`](https://github.com/horsehuiting/stat545a-2013-hw06_ma-hui/blob/master/Makefile.R)
  * Start a fresh RStudio session, make sure the above directory is the working directory, open `Makefile.R`, and click on "Source".
  * Alternatively, in a shell: `Rscript Makefile.R`.
  * When you run the pipeline the first time, you will get warnings about `file.remove()` trying to remove files that don't exist. That's OK. They will exist and will be removed and remade on subsequent runs.
  * New files you should see after running the pipeline:
    - [`barchart_totalWords.png`](https://raw.github.com/jennybc/STAT545A/master/hw06_scaffolds/01_justR/barchart_totalWords.png)
    - [`barchart_totalWordsFilmDodge.png`](https://raw.github.com/jennybc/STAT545A/master/hw06_scaffolds/01_justR/barchart_totalWordsFilmDodge.png)
    - [`lotr_clean.tsv`](https://github.com/jennybc/STAT545A/blob/master/hw06_scaffolds/01_justR/lotr_clean.tsv)
    - `stripplot_wordsByRace_FILM.png`, where FILM is one of the 3 movies. Example: [`stripplot_wordsByRace_The_Fellowship_Of_The_Ring.png`](https://raw.github.com/jennybc/STAT545A/master/hw06_scaffolds/01_justR/stripplot_wordsByRace_The_Fellowship_Of_The_Ring.png)
    - [`totalWordsByFilmRace.tsv`](https://github.com/jennybc/STAT545A/blob/master/hw06_scaffolds/01_justR/totalWordsByFilmRace.tsv)
