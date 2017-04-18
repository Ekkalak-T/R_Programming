rankall <- function(inputOutcome, num="best") {
  ## Read outcome data
  
  outcomeData <- read.csv("outcome-of-care-measures.csv",na.strings = "Not Available",stringsAsFactors = FALSE)
  
  ## Check that state and outcome are valid


  listOutcome <- c("heart attack", "heart failure", "pneumonia")
  checkOutcome <- inputOutcome %in% listOutcome
  
  if(!checkOutcome){
    print(
      "Invalid Outcome!!")
    stop()
  }
  
  
  
  ## Return a data frame with the hospital names and the
  ## (abbreviated) state name
  
  
  if(inputOutcome == "heart attack"){
    orderedData <- outcomeData[,c(2,7,11)]
  }
  else if(inputOutcome == "heart failure"){
    orderedData <- outcomeData[,c(2,7,17)]
    print("heart failure")
  }
  else if(inputOutcome == "pneumonia"){
    orderedData <- outcomeData[,c(2,7,23)]
    print("pneumonia")
  }
  else{
    print("No Match!!")
    stop()
  }
  clean <- complete.cases(orderedData[,3])
  orderedData <- orderedData[clean,]
  orderedData <- orderedData[order(orderedData[2], orderedData[3],orderedData[1]),]
  
  
  if(num=="best"){
    totalHospital <- tapply(orderedData$Hospital.Name, orderedData$State, function(z) z[1])
    
  }
  else if(num=="worst"){
    totalHospital <- tapply(orderedData$Hospital.Name, orderedData$State, function(z) z[length(z)])
  }
  else{
    totalHospital <- tapply(orderedData$Hospital.Name, orderedData$State, function(z) z[num])
    
  }
  
 
  totalHospital <- as.data.frame.table(totalHospital) 
  names(totalHospital) <- c("State","Hospital Name")
  totalHospital
}








