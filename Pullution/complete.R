complete <- function(directory, id = 1:332){
  round <- 1
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
    readData <- read.csv(path)
    
    # Remove NA value
    clearNA <- complete.cases(readData)
    readData <- readData[clearNA,]
    sumNob <- length(readData[,1])
    
    if(round==1){
      listNob <- sumNob
      listID <- index
    }
    else{
      listNob <- c(listNob,sumNob)
      listID <- c(listID,index)
    }
    round <- round + 1
  }

 
  nobDataframe <- data.frame(id =listID,nob = listNob)
  nobDataframe
}