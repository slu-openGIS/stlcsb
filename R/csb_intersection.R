#' CSB intersections
#'
#' @description \code{csb_intersection}returns a logical vector indicating `TRUE` for addresses that are intersections. This function is also able to isolate or remove these data.
#'
#' @usage csb_intersection(.data, var, newVar, filter = FALSE, remove = FALSE)
#'
#' @param .data A tbl
#' @param var name of column containing address
#' @param newVar Name of output variable to be created with logical
#' @param filter If true, returns a filtered version of the input with only observations occurring at intersections
#' @param remove If true, returns a version of the input without observations occuring at intersections
#'
#' @return \code{csb_intersection}returns a logical vector for addresses that are intersections, or it filters intersections
#'
#' @importFrom dplyr filter
#' @importFrom dplyr mutate
#' @importFrom dplyr select
#' @importFrom magrittr %>%
#' @importFrom rlang :=
#' @importFrom rlang enquo
#' @importFrom rlang quo
#' @importFrom rlang sym
#' @importFrom stringr str_detect
#'
#' @examples
#' \dontrun{csb_intersection(january_2018, PROBADDRESS, newVar = Intersection)}
#' csb_intersection(january_2018, PROBADDRESS, filter = TRUE)
#' csb_intersection(january_2018, PROBADDRESS, remove = TRUE)
#'
#' @export
csb_intersection <- function(.data, var, newVar, filter = FALSE, remove = FALSE){

  # check for missing parameters
  if (missing(.data)) {
    stop('Please provide an argument for .data')
  }

  if (missing(var)) {
    stop('Please provide an argument for var')
  }

  if (missing(newVar)){
    message('No argument specified for newVar, no logical will be appended')
  }

  # check for inccorectly specified parameters
  if(filter == TRUE & remove == TRUE){
    stop('Use filter to select only intersections, use remove to remove intersections from the data')
  }

  if(missing(newVar)&filter == FALSE&remove == FALSE){
    stop('Please specify at least one argument for newVar, filter or remove')
  }

  # save parameters to list
  paramList <- as.list(match.call())

  # quote input variables
  if (!is.character(paramList$var)) {
    varN <- rlang::enquo(var)
  }
  else if (is.character(paramList$var)) {
    varN <- rlang::quo(!! rlang::sym(var))
  }

  varNQ <- rlang::quo_name(rlang::enquo(varN))

  if(!missing(newVar)){
    newVarN <- rlang::quo_name(rlang::enquo(newVar))
  }

  #Detect intersection based on @ and & characters
  # this is our best methodoloy now, may update with [:blank:]at[:blank:]
  .data %>%
    select(!!varN) %>%
    unlist() -> matchV

  #append logical
  if(!missing(newVar)){
    .data <- dplyr::mutate(.data, !!newVarN := stringr::str_detect(matchV, "@|&"))
  }

  #filter for only intersections
  if(filter == TRUE){

    before <- nrow(.data) # counting

    .data <- filter(.data, stringr::str_detect(matchV, "@|&" ))

    after <- nrow(.data) # counting

    message(paste0(before-after, " observations were filtered out"))

  }

  #filter out intersections
  if(remove == TRUE){

    before <- nrow(.data) # counting

    .data <- filter(.data, !stringr::str_detect(matchV, "@|&" ))

    after <- nrow(.data) # counting

    message(paste0(before-after, " observations were removed"))

  }

  # return output
  return(.data)

}
