### Introduction
These code are part of assignment in R Programming course 

## Data Exploration in pollution monitoring data

### Pollution monitoring Dataset : specdata.zip
The zip file contains 332 comma-separated-value (CSV) files containing pollution monitoring data for fine particulate matter (PM) air pollution at 332 locations in the United States. Each file contains data from a single monitor and the ID number for each monitor is contained in the file name. For example, data for monitor 200 is contained in the file "200.csv". Each file contains three variables:

1. Date: the date of the observation in YYYY-MM-DD format (year-month-day)
2. sulfate: the level of sulfate PM in the air on that date (measured in micrograms per cubic meter)
3. nitrate: the level of nitrate PM in the air on that date (measured in micrograms per cubic meter)

### pollutantmean.R
Calculates the mean of a pollutant (sulfate or nitrate) across a specified list of monitors. The function 'pollutantmean' takes three arguments: 'directory', 'pollutant', and 'id'. Given a vector monitor ID numbers, 'pollutantmean' reads that monitors' particulate matter data from the directory specified in the 'directory' argument and returns the mean of the pollutant across all of the monitors, ignoring any missing values coded as NA. Example output is below


<!-- -->
        source("pollutantmean.R")
        pollutantmean("specdata", "sulfate", 1:10)
        ## [1] 4.064
        pollutantmean("specdata", "nitrate", 70:72)
        ## [1] 1.706
        pollutantmean("specdata", "nitrate", 23)
        ## [1] 1.281

### complete.R
Reads a directory full of files and reports the number of completely observed cases in each data file. The function return a data frame where the first column is the name of the file and the second column is the number of complete cases. Example output is below

<!-- -->
        source("complete.R")
        complete("specdata", 1)
        ##   id nobs
        ## 1  1  117
        complete("specdata", c(2, 4, 8, 10, 12))
        ##   id nobs
        ## 1  2 1041
        ## 2  4  474
        ## 3  8  192
        ## 4 10  148
        ## 5 12   96
        complete("specdata", 30:25)
        ##   id nobs
        ## 1 30  932
        ## 2 29  711
        ## 3 28  475
        ## 4 27  338
        ## 5 26  586
        ## 6 25  463
        complete("specdata", 3)
        ##   id nobs
        ## 1  3  243
        
### corr.R
Takes a directory of data files and a threshold for complete cases and calculates the correlation between sulfate and nitrate for monitor locations where the number of completely observed cases (on all variables) is greater than the threshold. The function should return a vector of correlations for the monitors that meet the threshold requirement. If no monitors meet the threshold requirement, then the function should return a numeric vector of length 0. Example output is below

<!-- -->
        source("corr.R")
        source("complete.R")
        cr <- corr("specdata", 150)
        head(cr)
        ## [1] -0.01896 -0.14051 -0.04390 -0.06816 -0.12351 -0.07589
        summary(cr)
        ##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
        ## -0.2110 -0.0500  0.0946  0.1250  0.2680  0.7630
        cr <- corr("specdata", 400)
        head(cr)
        ## [1] -0.01896 -0.04390 -0.06816 -0.07589  0.76313 -0.15783
        summary(cr)
        ##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
        ## -0.1760 -0.0311  0.1000  0.1400  0.2680  0.7630
        cr <- corr("specdata", 5000)
        summary(cr)
        ##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
        ## 
        length(cr)
        ## [1] 0
        cr <- corr("specdata")
        summary(cr)
        ##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
        ## -1.0000 -0.0528  0.1070  0.1370  0.2780  1.0000
        length(cr)
        ## [1] 323
        
  ## Data Exploration in pollution monitoring data
