pollutantmean <- function(directory, pollutant, id = 1:332){
  round = 1
  setwd(directory)
  for (index in id){
    # Append 0 or 00 to file path
    if (index <= 9){
      path <- paste("00",index,".csv",sep = "")
    }
    else if(index <= 99){
      path <- paste("0",index,".csv",sep = "")
      
    }
    else{
      path <- paste(index,".csv",sep = "")
    }
    
    
    # Read Data and filter only interested pollutant (Sulfate or Nitrate)
    readData = read.csv(path)
    filterData = readData[[pollutant]]
    
    # Remove NA value
    clearNA = complete.cases(filterData)
    filterData = filterData[clearNA]
    
    #concenate value of each monitor list
    if(round == 1){
      listAllPollutant <- filterData
    }
    else{
      listAllPollutant <- c(listAllPollutant,filterData)
    }
    round = round+1
  }
  print(mean(listAllPollutant))
}