#' CSB intersections
#'
#' @description \code{csb_intersection}returns a logical vector with TRUE for addresses that are intersections
#'
#' @usage csb_intersection(.data, var, newVar, filter = FALSE)
#'
#' @param .data A tibble with raw CSB data
#' @param var name of column containing address
#' @param newVar
#' @param filter If true, returns a filtered version of the input with only intersections
#'
#' @return \code{csb_intersection}returns a filtered version of the input data based on specified arguments
#'
#' @importFrom dplyr mutate filter
#' @importFrom rlang quo enquo sym .data
#' @importFrom magrittr %>%
#' @importFrom stringr str_detect
#'
#' @export
csb_intersection <- function(.data, var, newVar, filter = FALSE){
  #Check for missing parameters
  if (missing(.data)) {
    stop('Please provide an argument for .data')
  }
  if (missing(var)) {
    stop('Please provide an argument for var')
  }
  if (missing(newVar)){
    stop('Please provide an argument for newVar')
  }
  #NSE setup

  #Detect intersection based on @ character

  mutate(.data, !!newVar :=
    stringr::str_detect(.data[[var]], "@" )) -> .data
  #Return the data
  return(.data)
}
