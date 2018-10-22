#' Filter CSB date
#'
#' @description \code{csb_date_filter}Filters dates to return only the specified date elements
#'
#' @usage csb_date_filter(.data, var, day, month, year, delete = FALSE)
#'
#' @param .data A tibble with raw CSB data
#' @param var name of column containing date data
#' @param day numeric representation of day(s) to include (leading zero or not will be accepted)
#' @param month numeric representation of month(s) to include (leading zero or not will be accepted)
#' @param year numeric representation of years(s) to include (4 digit or 2 digit accepted)
#' @param delete if true, deletes the original column containing dates
#'
#' @return \code{csb_date} can either return new columns with parsed date or return a filtered dataset
#'
#' @importFrom dplyr mutate
#' @importFrom lubridate day
#' @importFrom lubridate month
#' @importFrom lubridate year
#' @importFrom dplyr %>%
#' @importFrom rlang :=
#' @importFrom rlang quo
#' @importFrom rlang enquo
#' @importFrom rlang sym
#' @importFrom rlang .data
#'
#' @export
csb_date_filter <- function(.data, var, day, month, year, filter = TRUE, delete = FALSE){

  ### NSE Setup
  # save parameters to list
  paramList <- as.list(match.call())

  # and quote input variables
  ## if not quoted character input, we need to return a quosure
  if (!is.character(paramList$var)) {
    varN <- rlang::enquo(var)
  }
  ## if it is character input, we need it as
  else if (is.character(paramList$var)) {
    varN <- rlang::quo(!! rlang::sym(var))
  }

  newVarN <- rlang::quo_name(rlang::enquo(newVar))

  ## Check that at least one argument is specified (This may [WILL] break NSE!!)
  if(!is.numeric(day)&&!is.numeric(month)&&!is.numeric(year)){
    stop("At least one argument must be specified for day, month or year.")
  }

  ## Parsing Function
  if(filter == FALSE){

    ### test for NULL or Charcater??
    ## !!var

    ## Mutate for day
    if(!is.null(day)){.data %>%
        mutate(day = lubridate::day(var))} -> .data
    ## Mutate for month
    if(!is.null(month)){.data %>%
        mutate(month = lubridate::month(var))} -> .data
    ## Mutate for year
    if(is.character(year)){.data %>%
        mutate(year = lubridate::year(var))} -> .data
  }
  ## Filter Function
  ### Will need the same if structure as above, can't test for NULL ==
  else if(filter == TRUE){
    .data %>%
      filter(year == lubridate::year(var)) %>%
      filter(month == lubridate::month(var)) %>%
      filter(day == lubridate::day(var)) -> f_out

    ## Filter based on specified arguments

  }
  ## Delete the original var
  if (delete == TRUE){
    select(.data, -var) -> d_out
  }

}
