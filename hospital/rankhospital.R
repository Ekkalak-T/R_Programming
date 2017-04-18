rankhospital  <- function(inputState, inputOutcome, num="best") {
  ## Read outcome data
  
  outcomeData <- read.csv("outcome-of-care-measures.csv",na.strings = "Not Available",stringsAsFactors = FALSE)
  
  ## Check that state and outcome are valid
  
  listState <- unique(outcomeData$State)
  checkState <- inputState %in% listState
  
  if(!checkState){
    print("Invalid State!!")
    stop()
  }
  
  listOutcome <- c("heart attack", "heart failure", "pneumonia")
  checkOutcome <- inputOutcome %in% listOutcome
  
  if(!checkOutcome){
    print(
      "Invalid Outcome!!")
    stop()
  }
  
  
  
  ## Return hospital name in that state with the given rank
  ## 30-day death rate
  
  dataByState <- split(outcomeData,outcomeData$State)
  dataByState <- dataByState[[inputState]]
  
  if(inputOutcome == "heart attack"){
    orderedData <- dataByState[,c(2,7,11)]
  }
  else if(inputOutcome == "heart failure"){
    orderedData <- dataByState[,c(2,7,17)]
    print("heart failure")
  }
  else if(inputOutcome == "pneumonia"){
    orderedData <- dataByState[,c(2,7,23)]
    print("pneumonia")
  }
  else{
    print("No Match!!")
    stop()
  }
  clean <- complete.cases(orderedData)
  orderedData <- orderedData[clean,]
  orderedData <- orderedData[order(orderedData[3], orderedData[1]),]
  
  
  if(num=="best"){
    rankHospital <- as.character(orderedData$Hospital.Name[1])
    
  }
  else if(num=="worst"){
    totalHospital <- length(orderedData$Hospital.Name)
    
    rankHospital <- as.character(orderedData$Hospital.Name[totalHospital])
  }
  else{
    rankHospital <- as.character(orderedData$Hospital.Name[num])
    
  }
  rankHospital
}








