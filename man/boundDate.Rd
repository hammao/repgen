% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/utils-time.R
\name{boundDate}
\alias{boundDate}
\title{Bound Date}
\usage{
boundDate(date, dateRange, padDays = 1)
}
\arguments{
\item{date}{The date to bound}

\item{dateRange}{The date range to bound the date with}

\item{padDays}{[DEFAULT: 1] The number of days to pad the date with}
}
\description{
Applied bounds to the provided date using a number of padding days.
For example, if the date is less than the start of the provided date range then
the date will be set to be the start of the date range - padding days.
}
