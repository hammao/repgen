#' Parse Field Measurement Data
#' @description Takes in a V diagram report and returns the field visit measurement data
#' @param reportObject An R object with the raw data required for a V Diagram
#' @return A list containing the field visit measurement data
#'
parseFieldMeasurementData <- function(reportObject){
  maxShift <- fetchMeasurementsField(reportObject, "errorMaxShiftInFeet")
  validParam(maxShift, "errorMaxShiftInFeet")
  
  minShift <- fetchMeasurementsField(reportObject, "errorMinShiftInFeet")
  validParam(minShift, "errorMinShiftInFeet")
  
  obsShift <- fetchMeasurementsField(reportObject, "shiftInFeet")
  validParam(obsShift, "shiftInFeet")
  
  #if we have a measurement$shiftNumber value, use it, otherwise, set it to 0 and other logic will determine its value.
  obsIDs <- fetchMeasurementsField(reportObject, "shiftNumber")
  obsIDs[is.na(obsIDs)] <- 0
  validParam(obsIDs, "shiftNumber")
  
  obsGage <- fetchMeasurementsField(reportObject, "meanGageHeight")
  validParam(obsGage, "meanGageHeight")

  ### Is this correct to validate this param?
  measurementNumber <- fetchMeasurementsField(reportObject, "measurementNumber")
  validParam(measurementNumber, "measurementNumber")
  
  histFlag <- defaultHistFlags(fetchMeasurementsField(reportObject,"historic"))
  publish <- fetchMeasurementsField(reportObject,"publish")
  
  return(list(
    maxShift=maxShift, 
    minShift=minShift, 
    obsShift=obsShift, 
    obsIDs=obsIDs, 
    obsGage=obsGage, 
    measurementNumber=measurementNumber, 
    histFlag=histFlag,
    publish=publish))
}

#' History Measurements Label
#' @description A function that checks to see if there are any historic measurements and, if so, creates a label
#' that describes how long the historic data goes back.
#' @param reportObject The V Diagram report
historyMeasurementsLabel <- function(reportObject) {
  label <- ""
  if(!is.null(reportObject[['reportMetadata']][['requestParameters']][['priorYearsHistoric']]) && reportObject[['reportMetadata']][['requestParameters']][['priorYearsHistoric']] > "0") {
    label <- paste("Unlabeled blue points are historical measurements from the last",
      reportObject[['reportMetadata']][['requestParameters']][['priorYearsHistoric']], "year(s).\n")
  }
}

#' Set default historic flags
#' @description Sets the historic flag to false if " " is passed in.
#' @param histFlag The historic flag field from a V Diagram.
#' @return FALSE if " " is passed in or if the field is empty, otherwise it returns what was passed in. 
defaultHistFlags <- function(histFlag){
  
  if (isEmptyOrBlank(histFlag) || (length(histFlag)==1 && histFlag == " ")){
    histFlag <- FALSE
  }
  
  return(histFlag);
}

#' Create Control Condition String
#' 
#' @description Creates a comma-separated string of the control conditions
#' @param controlConditions The vector of control conditions to create the string from
createControlConditionsString <- function(controlConditions){
  returnString <- ""
  
  if(!isEmptyOrBlank(controlConditions)){
    displayValues <- controlConditions
    displayValues <- trimws(gsub('([[:upper:]])', ' \\1', displayValues), which="left")
    returnString <- paste(displayValues, collapse = ", ")
  }
  
  return(returnString)
}