best <- function(inputState, inputOutcome) {
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
  
  
  ## Return hospital name in that state with lowest 30-day death
  ## rate
  
  dataByState <- split(outcomeData,outcomeData$State)
  dataByState <- dataByState[[inputState]]
  
  if(inputOutcome == "heart attack"){

    orderedData <- dataByState[order(dataByState$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack, dataByState$Hospital.Name),]
    print("heart attack")
    
  }
  else if(inputOutcome == "heart failure"){
    
    orderedData <- dataByState[order(dataByState$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure, dataByState$Hospital.Name),]
    print("heart failure")
    }
  else if(inputOutcome == "pneumonia"){
    orderedData <- dataByState[order(dataByState$Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia,dataByState$Hospital.Name),]
    
    
    
    print("pneumonia")
  }
  else{
    print("No Match!!")
    stop()
  }

  
  bestHospital <- as.character(orderedData$Hospital.Name[1])
  print(bestHospital)

}








