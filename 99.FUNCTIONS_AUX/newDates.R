# Metadata ----------------------------------------------------------------
# w.b: Ferran Garcia, @pompolompo
# w.o: 2024-07-28
# purpose: function to recalculate date intervals for searchID
# description: given a pair of start and end dates returns 
#              2 pairs covering the interval with half lenght each

newDates <- function(startDate, endDate, int = 2){
  startDate <- as.Date(startDate)
  endDate <- as.Date(endDate)
  
  if(startDate >= endDate) stop("endDate should be greater than startDate")
  
  intLength <- (endDate - startDate) / int
  newDates <- list()
  
  for(i in 1:int){
    newDates[[length(newDates) + 1]] <- c(
      format(startDate + intLength * (i-1), "%Y-%m-%d"),
      format(startDate + intLength * i, "%Y-%m-%d")
    )
  }
  
  return(newDates)
}
