#' CSB intersections
#'
#' @description \code{csb_intersection}returns a logical vector indicating `TRUE`` for addresses that are intersections. This function is also able to isolate or remove these data.
#'
#' @usage csb_intersection(.data, var, newVar, filter = FALSE, remove = FALSE)
#'
#' @param .data A tibble with raw CSB data
#' @param var name of column containing address
#' @param newVar Name of output variable to be created with logical
#' @param filter If true, returns a filtered version of the input with only observations occuring at ntersections
#' @param remove If true, retrurns a version of the input without observations occuring at intersections
#'
#' @return \code{csb_intersection}returns a logical vector for addresses that are intersections, or it filters intersections
#'
#' @importFrom dplyr mutate filter select_
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
    message('No argument specified for newVar, no logical will be appended')
  }
  #invalid arguments
  if(isTRUE(filter)&&isTRUE(remove)){
    stop('Use filter to select only intersections, use remove to remove intersections from the data')
  }

  if(missing(newVar)&&isFALSE(filter)&&isFALSE(remove)){
    stop('Please specify at least one argument for newVar, filter or remove')
  }

  #NSE setup
  paramList <- as.list(match.call())

  if (!is.character(paramList$var)) {
    varN <- rlang::enquo(var)
  }
  else if (is.character(paramList$var)) {
    varN <- rlang::quo(!! rlang::sym(var))
  }

  if(!missing(newVar)){newVarN <- rlang::quo_name(rlang::enquo(newVar))}

  #Detect intersection based on @ and & characters, this is our best methodoloy now, may update with [:blank:]at[:blank:]

  dplyr::select_(.data, rlang::quo_name(varN)) -> matchV # select column explicitly
  unlist(matchV) -> matchV # coerce to vector

  # we can remove the select dependency with this syntax, same as geo function --> .data[,quo_name(varN)]

  #append logical
  if(!missing(newVar)){dplyr::mutate(.data, !!newVarN :=
    stringr::str_detect(matchV, "@|&" )) -> .data
  }

  #filter for only intersections
  if(isTRUE(filter)){
    before <- nrow(.data) # counting
    .data %>% filter(stringr::str_detect(matchV, "@|&" )) -> .data
    after <- nrow(.data) # counting
    message(paste0(before-after, " observations were filtered out"))
  }
  #filter out intersections
  if(isTRUE(remove)){
    before <- nrow(.data) # counting
    .data %>% filter(!stringr::str_detect(matchV, "@|&" )) -> .data
    after <- nrow(.data) # counting
    message(paste0(before-after, " observations were removed"))
  }
  #Return the data
  return(.data)
}
