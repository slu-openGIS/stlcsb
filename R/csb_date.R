#' Clean CSB date
#'
#' @description \code{csb_date} returns parsed dates in specified columns
#'
#' @usage csb_date(.data, var, day = NULL, month = NULL, year = NULL, delete = FALSE)
#'
#' @param .data A tibble with raw CSB data
#' @param var name of column containing date data
#' @param day if specified, returns a named column with parsed day
#' @param month if specified, returns a named column with parsed month
#' @param year if specified, returns a named column with parsed year
#' @param filter if true, the function will filter data based on specified values rather than parse it
#' @param delete if true, deletes the original column with unparsed data
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
#'
#' @export
csb_date <- function(.data, var, day = NULL, month = NULL, year = NULL, filter = FALSE, delete = FALSE){

  ## Check that at least one argument is specified (This may break NSE!!)
  if(is.null(day)&&is.null(month)&&is.null(year)){
    stop("At least one argument must be specified for day, month or year.")
    }

## Parsing Function
  if(filter == FALSE){

  ## Mutate for day
    if(!is.null(day)){.data %>%
        mutate(day = day(!!var))}
  ## Mutate for month
    if(!is.null(month)){.data %>%
        mutate(month = month(var))}
  ## Mutate for year
    if(!is.null(year)){.data %>%
        mutate(year = year(var))}
  }
## Filter Function
  else if(filter == TRUE){
    .data %>%
      filter(year == year(var)) %>%
      filter(month == month(var)) %>%
      filter(day == day(var)) -> f_out

  ## Filter based on specified arguments

  }
## Delete the original var
  if (delete == TRUE){
      select(.data, -var) -> d_out
  }

}
