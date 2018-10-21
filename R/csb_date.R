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

  ## Check that at least one argument is specified (This may [WILL] break NSE!!)
  if(is.null(day)&&is.null(month)&&is.null(year)){
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
