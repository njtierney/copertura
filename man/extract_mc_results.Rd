% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/extract_mc_result.R
\name{extract_mc_results}
\alias{extract_mc_results}
\title{(Internal) Summarise maxcovr model using facility and user information}
\usage{
extract_mc_results(x)
}
\arguments{
\item{x}{the fitted model from \code{max_coverage}.}
}
\value{
a list containing multiple dataframes summarising the model
}
\description{
\code{extract_mc_results} takes a fitted \code{max_coverage} object and
returns useful summary information from the model. It exists so that the
manipulation functions for the outcomes from the solver have another
home - this makes it easier to maintain this package, and heeds to this
idea of having functions that are specialised. The name of this function
is likely to change in the near future.
}
