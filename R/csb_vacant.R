#' CSB vacant codes
#'
#' @description \code{csb_vacant}appends a logical vector indicating `TRUE`` for vacancy related problem codes.
#'
#' @usage csb_vacant(.data, var, newVar, filter = FALSE)
#'
#' @param .data A tibble with raw CSB data
#' @param var name of column containing problem codes
#' @param newVar name of output variable to be created with vacant logical
#' @param filter If true, returns a filtered version of the input with only vacancy related problem codes
#'
#' @return \code{csb_vacant}returns a logical vector with TRUE for vacancy related problem codes, or a filtered version of the input data
#'
#' @importFrom dplyr mutate filter
#' @importFrom rlang quo quo_name enquo sym .data
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
  paramList <- as.list(match.call())

  # and quote input variables
  if (!is.character(paramList$var)) {
    varN <- rlang::enquo(var)
  }
  else if (is.character(paramList$var)) {
    varN <- rlang::quo(!! rlang::sym(var))
  }
  newVarN <- rlang::quo_name(rlang::enquo(newVar))


  #Append logical for vacant codes
  .data %>% dplyr::mutate(!!newVarN := ifelse(!!varN %in% stlcsb::vacant, TRUE, FALSE)) -> .data

  #Filter if neccessary
  if(isTRUE(filter)){
    .data %>% dplyr::filter(!!varN %in% stlcsb::vacant) -> .data
  }

  #Return the data
  return(.data)
}
