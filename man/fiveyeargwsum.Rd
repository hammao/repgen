% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/sig-fiveyeargwsum.R
\docType{methods}
\name{fiveyeargwsum}
\alias{fiveyeargwsum}
\alias{fiveyeargwsum,list-method}
\title{Five Year Groundwater Summary Report}
\usage{
fiveyeargwsum(data, ...)

\S4method{fiveyeargwsum}{list}(data, ...)
}
\arguments{
\item{data}{Local data (as list), or URL.}

\item{...}{Additional params passed to GET}
}
\description{
Five Year Groundwater Summary Report
}
\examples{
library(gsplot)
library(jsonlite)
library(lubridate)

data <-
 fromJSON(
   system.file(
     'extdata', 'testsnippets', 'test-fiveyeargwsum.json', package = 'repgen'
   )
 )
fiveyeargwsum(data[['fiveYrNoMinMax']], 'Author Name')
}
