#' CSB intersections
#'
#' @description \code{csb_intersection}returns a logical vector with TRUE for addresses that are intersections
#'
#' @usage csb_intersection(.data, var, newVar, filter = FALSE, remove = FALSE)
#'
#' @param .data A tibble with raw CSB data
#' @param var name of column containing address
#' @param newVar Name of output variable to be created with logical
#' @param filter If true, returns a filtered version of the input with only intersections
#' @param remove If true, removes intersections from the input data frame
#'
#' @return \code{csb_intersection}returns a logical vector for addresses that are intersections, or it filters intersections
#'
#' @importFrom dplyr mutate filter
#' @importFrom rlang quo enquo sym .data
#' @importFrom magrittr %>%
#' @importFrom stringr str_detect
#'
#' @export
csb_intersection <- function(.data, var, newVar, filter = FALSE, remove = FALSE){
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
  #invalid arguments
  if(isTRUE(filter)&&isTRUE(remove)){
    stop('Use filter to select only intersections, use remove to remove intersections from the data')
  }

  #NSE setup
  paramList <- as.list(match.call())

  if (!is.character(paramList$var)) {
    varN <- rlang::enquo(var)
  }
  else if (is.character(paramList$var)) {
    varN <- rlang::quo(!! rlang::sym(var))
  }
  newVarN <- rlang::quo_name(rlang::enquo(newVar))

  #Detect intersection based on @ character
  #
  csb %>% filter(str_detect(csb[["PROBADDRESS"]], "&")|str_detect(csb[["PROBADDRESS"]], "@")|str_detect(csb[["PROBADDRESS"]], "[:blank:]at[:blank:]")) -> at
  #
  mutate(.data, !!newVarN :=
    stringr::str_detect(.data[[varN]], "@" )) -> .data

  #filter for only intersections
  if(isTRUE(filter)){
    .data %>% filter(stringr::str_detect(.data[[varN]], "@" )) -> .data
  }
  #filter out intersections
  if(isTRUE(remove)){
    .data %>% filter(!stringr::str_detect(.data[[varN]], "@" )) -> .data
  }
  #Return the data
  return(.data)
}
