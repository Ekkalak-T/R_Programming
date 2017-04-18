corr <- function(directory, threshold = 0){
  listCor = integer()
  path <- list.files((directory), full.names=TRUE)
  
  for (index in path){
    # Read Data and filter only interested pollutant (Sulfate or Nitrate)
    readData <- read.csv(index)
    
    # Remove NA value
    clearNA <- complete.cases(readData)
    readData <- readData[clearNA,]
    sumNob <- length(readData[,1])
    
    if(sumNob >= threshold & sumNob > 0){

      currentCor = cor(readData[["sulfate"]], readData[["nitrate"]])
      listCor = c(listCor, currentCor)
    }
    
    
  }
  listCor
}