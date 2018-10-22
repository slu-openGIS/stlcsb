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
#' @return \code{csb_date_filter}returns a filtered version of the input data based on specified arguments
#'
#' @importFrom dplyr mutate
#' @importFrom dplyr filter
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
csb_date_filter <- function(.data, var, day = NULL, month = NULL, year = NULL, delete = FALSE){

  ### NSE Setup
  # save parameters to list
  paramList <- as.list(match.call())

  # and quote input variables
  if (!is.character(paramList$var)) {
    varN <- rlang::enquo(var)
  }
  else if (is.character(paramList$var)) {
    varN <- rlang::quo(!! rlang::sym(var))
  }


  ## Somewhere Here will be the conversion function from character to numeric arugments. and from numeric
  ## arguments to lubridate accepted arguments

  ## Check that at least one argument is specified (This may need to be changed/removed later)
  if(!is.numeric(day)&&!is.numeric(month)&&!is.numeric(year)){
    stop("At least one argument must be specified for day, month or year.")
  }

  ##Filter is conducted in the most efficient order for large data
  # filter for year
  if(is.numeric(year)){.data %>%
      filter(lubridate::year(!!varN) == year) -> .data
  }
  # filter for month
  if(is.numeric(month)){.data %>%
      filter(lubridate::month(!!varN) == year) -> .data
  }
  # filter for day
  if(is.numeric(day)){.data %>%
      filter(lubridate::day(!!varN) == year) -> .data
  }

  ## Delete the original var
  if (delete == TRUE){
    select(.data, -var) -> .data
  }

  return(.data)
}
