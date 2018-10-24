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

  #if(is.numeric(paramList$day)&&length()){}
  #if(!is.numeric(paramList$month)&&!is.character(paramList$month)){
 #   dayN <- rlang::enquo(month)
 # }


  if(nchar(paramList$year == 2)){year <- 2000 + year}
  else if(nchar(paramList$year == 1)){year <- 2010 + year}
  # vectors for alternative entry formats
  jan <- c('January', 'january', 'Jan', 'jan')
  feb <- c('February', 'february', 'Feb', 'feb')
  mar <- c('March', 'march', 'Mar', 'mar')
  apr <- c('April', 'april', 'Apr', 'apr')
  may <- c('May', 'may')
  jun <- c('June', 'june', 'Jun', 'jun')
  jul <- c('July', 'july', 'Jul', 'jul')
  aug <- c('August', 'august', 'Aug', 'aug')
  sep <- c('September', 'september', 'Sep', 'sep')
  oct <- c('October', 'october', 'Oct', 'oct')
  nov <- c('November', 'november', 'Nov', 'nov')
  dec <- c('December', 'december', 'Dec', 'dec')


  if(month %in% jan){month = 1}
  else if(month %in% feb){month = 2}
  else if(month %in% mar){month = 3}
  else if(month %in% apr){month = 4}
  else if(month %in% may){month = 5}
  else if(month %in% jun){month = 6}
  else if(month %in% jul){month = 7}
  else if(month %in% aug){month = 8}
  else if(month %in% sep){month = 9}
  else if(month %in% oct){month = 10}
  else if(month %in% nov){month = 11}
  else if(month %in% dec){month = 12}
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
      filter(lubridate::month(!!varN) == month) -> .data
  }
  # filter for day
  if(is.numeric(day)){.data %>%
      filter(lubridate::day(!!varN) == day) -> .data
  }

  ## Delete the original var
  if (delete == TRUE){
    select(.data, -!!varN) -> .data
  }

  return(.data)
}
