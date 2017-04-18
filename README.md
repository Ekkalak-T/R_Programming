### Introduction
These code are part of assignment in R Programming course 

## 1. Data Exploration in pollution monitoring data

### 1.1. Pollution monitoring Dataset : specdata.zip
The zip file contains 332 comma-separated-value (CSV) files containing pollution monitoring data for fine particulate matter (PM) air pollution at 332 locations in the United States. Each file contains data from a single monitor and the ID number for each monitor is contained in the file name. For example, data for monitor 200 is contained in the file "200.csv". Each file contains three variables:

1. Date: the date of the observation in YYYY-MM-DD format (year-month-day)
2. sulfate: the level of sulfate PM in the air on that date (measured in micrograms per cubic meter)
3. nitrate: the level of nitrate PM in the air on that date (measured in micrograms per cubic meter)

### 1.2. pollutantmean.R
Calculates the mean of a pollutant (sulfate or nitrate) across a specified list of monitors. The function 'pollutantmean' takes three arguments: 'directory', 'pollutant', and 'id'. Given a vector monitor ID numbers, 'pollutantmean' reads that monitors' particulate matter data from the directory specified in the 'directory' argument and returns the mean of the pollutant across all of the monitors, ignoring any missing values coded as NA. Example output is below


<!-- -->
        source("pollutantmean.R")
        pollutantmean("specdata", "sulfate", 1:10)
        ## [1] 4.064
        pollutantmean("specdata", "nitrate", 70:72)
        ## [1] 1.706
        pollutantmean("specdata", "nitrate", 23)
        ## [1] 1.281

### 1.3. complete.R
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
        
### 1.4. corr.R
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
        
## 2. Data Exploration in Hospital Compare web site 


### 2.1. Hospital Compare web site dataset (http://hospitalcompare.hhs.gov)
The purpose of the web site is to provide data and information about the quality of care at over 4,000 Medicare-certified hospitals in the U.S. This dataset essentially covers all major U.S. hospitals. This dataset is used for a variety of purposes, including determining
whether hospitals should be fined for not providing high quality care to patients


### 2.2. Finding the best hospital in a state (best.R)
Function takes two arguments: the 2-character abbreviated name of a state and anoutcome name. The function reads the outcome-of-care-measures.csv file and returns a character vector with the name of the hospital that has the best (i.e. lowest) 30-day mortality for the specified outcome in that state. The hospital name is the name provided in the Hospital.Name variable. The outcomes can be one of “heart attack”, “heart failure”, or “pneumonia”. Hospitals that do not have data on a particular outcome should be excluded from the set of hospitals when deciding the rankings. 

Handling ties. If there is a tie for the best hospital for a given outcome, then the hospital names should be sorted in alphabetical order and the first hospital in that set should be chosen (i.e. if hospitals “b”, “c”, and “f” are tied for best, then hospital “b” should be returned).

Example output is below

<!-- -->
        > source("best.R")
        > best("TX", "heart attack")
        [1] "CYPRESS FAIRBANKS MEDICAL CENTER"
        > best("TX", "heart failure")
        [1] "FORT DUNCAN MEDICAL CENTER"
        > best("MD", "heart attack")
        [1] "JOHNS HOPKINS HOSPITAL, THE"
        > best("MD", "pneumonia")
        [1] "GREATER BALTIMORE MEDICAL CENTER"
        > best("BB", "heart attack")
        Error in best("BB", "heart attack") : invalid state
        > best("NY", "hert attack")
        Error in best("NY", "hert attack") : invalid outcome
        >

### 2.3.Ranking hospitals by outcome in a state (rankhospital.R)

Function called rankhospital that takes three arguments: the 2-character abbreviated name of a state (state), an outcome (outcome), and the ranking of a hospital in that state for that outcome (num).

The function reads the outcome-of-care-measures.csv file and returns a character vector with the name of the hospital that has the ranking specified by the num argument. For example, the call rankhospital("MD", "heart failure", 5) would return a character vector containing the name of the hospital with the 5th lowest 30-day death rate for heart failure. The num argument can take values “best”, “worst”, or an integer indicating the ranking (smaller numbers are better). If the number given by num is larger than the number of hospitals in that state, then the function should return NA. Hospitals that do not have data on a particular outcome shouldbe excluded from the set of hospitals when deciding the rankings.

Handling ties. It may occur that multiple hospitals have the same 30-day mortality rate for a given cause
of death. In those cases ties should be broken by using the hospital name. 

Example output is below
<!-- -->
        > source("rankhospital.R")
        > rankhospital("TX", "heart failure", 4)
        [1] "DETAR HOSPITAL NAVARRO"
        > rankhospital("MD", "heart attack", "worst")
        [1] "HARFORD MEMORIAL HOSPITAL"
        > rankhospital("MN", "heart attack", 5000)
        [1] NA
        
### 2.4.Ranking hospitals in all states (rankall.R)

Function called rankall that takes two arguments: an outcome name (outcome) and a hospital ranking(num). The function reads the outcome-of-care-measures.csv file and returns a 2-column data frame containing the hospital in each state that has the ranking specified in num. For example the function call rankall("heart attack", "best") would return a data frame containing the names of the hospitals that
are the best in their respective states for 30-day heart attack death rates. The function should return a value for every state (some may be NA). The first column in the data frame is named hospital, which contains the hospital name, and the second column is named state, which contains the 2-character abbreviation for the state name. Hospitals that do not have data on a particular outcome should be excluded from the set of hospitals when deciding the rankings.

Handling ties. The rankall function should handle ties in the 30-day mortality rates in the same way
that the rankhospital function handles ties.

Example output is below

<!-- -->
        > source("rankall.R")
        > head(rankall("heart attack", 20), 10)
        hospital state
        AK <NA> AK
        AL D W MCMILLAN MEMORIAL HOSPITAL AL
        AR ARKANSAS METHODIST MEDICAL CENTER AR
        AZ JOHN C LINCOLN DEER VALLEY HOSPITAL AZ
        CA SHERMAN OAKS HOSPITAL CA
        CO SKY RIDGE MEDICAL CENTER CO
        CT MIDSTATE MEDICAL CENTER CT
        DC <NA> DC
        DE <NA> DE
        FL SOUTH FLORIDA BAPTIST HOSPITAL FL
        > tail(rankall("pneumonia", "worst"), 3)
        hospital state
        WI MAYO CLINIC HEALTH SYSTEM - NORTHLAND, INC WI
        WV PLATEAU MEDICAL CENTER WV
        WY NORTH BIG HORN HOSPITAL DISTRICT WY
        > tail(rankall("heart failure"), 10)
        hospital state
        TN WELLMONT HAWKINS COUNTY MEMORIAL HOSPITAL TN
        TX FORT DUNCAN MEDICAL CENTER TX
        UT VA SALT LAKE CITY HEALTHCARE - GEORGE E. WAHLEN VA MEDICAL CENTER UT
        VA SENTARA POTOMAC HOSPITAL VA
        VI GOV JUAN F LUIS HOSPITAL & MEDICAL CTR VI
        VT SPRINGFIELD HOSPITAL VT
        WA HARBORVIEW MEDICAL CENTER WA
        WI AURORA ST LUKES MEDICAL CENTER WI
        WV FAIRMONT GENERAL HOSPITAL WV
        WY CHEYENNE VA MEDICAL CENTER WY


