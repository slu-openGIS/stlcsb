#' Parse CSB date
#'
#' @description \code{csb_date_parse} is used to parse out dates into more intellgible formats
#'
#' @usage csb_date_parse(.data, var, day, month, year, delete = FALSE)
#'
#' @param .data A tibble with raw CSB data
#' @param var name of column containing date data
#' @param day if specified, returns a named column with parsed day
#' @param month if specified, returns a named column with parsed month
#' @param year if specified, returns a named column with parsed year
#' @param delete if true, deletes the original column with unparsed data
#'
#' @return \code{csb_date_parse}returns new columns with specified names containing parsed date information
#'
#' @importFrom dplyr mutate %>%
#' @importFrom lubridate day month year
#' @importFrom rlang quo enquo sym .data
#'
#' @export
csb_date_parse <- function(.data, var, day, month, year, delete = FALSE){


  ### WHY DOES THIS NOT RETURN AN ERROR FOR UNAMED ARGUMENTS?
  # Had to set nulls in the date_filter...

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
  # quote names
  dayN <- rlang::quo_name(rlang::enquo(day))

  monthN <- rlang::quo_name(rlang::enquo(month))

  yearN <- rlang::quo_name(rlang::enquo(year))

## Parsing Function

  ## Mutate for day
    if(dayN != ""){.data %>%
        dplyr::mutate(!!dayN := lubridate::day(!!varN))} -> .data
  ## Mutate for month
    if(monthN != ""){.data %>%
        dplyr::mutate(!!monthN := lubridate::month(!!varN))} -> .data
  ## Mutate for year
    if(yearN != ""){.data %>%
        dplyr::mutate(!!yearN := lubridate::year(!!varN))} -> .data


## Delete the original var
   if (delete == TRUE){
      dplyr::select(.data, -!!varN) -> .data
  }

  return(.data)
}
