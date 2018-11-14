#' CSB vacant codes
#'
#' @description \code{csb_vacant}returns a logical vector with TRUE for vacancy related problem codes.
#'
#' @usage csb_vacant(.data, var, newVar, filter = FALSE)
#'
#' @param .data A tibble with raw CSB data
#' @param var name of column containing problem codes
#' @param newVar
#' @param filter If true, returns a filtered version of the input with only vacancy related problemcodes
#'
#' @return \code{csb_vacant}returns a logical vector with TRUE for vacancy related problem codes, or a filtered version of the input data
#'
#' @importFrom dplyr mutate filter
#' @importFrom rlang quo enquo sym .data
#' @importFrom magrittr %>%
#'
#' @export
csb_vacant <- function(.data, var, newVar, filter = FALSE){
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
  #NSE Setup

  #Append logical for vacant codes
  .data %>% dplyr::mutate(!!newVar := ifelse(!!varN %in% vacant, TRUE, FALSE)) -> .data

  #Return the data
  return(.data)
}
