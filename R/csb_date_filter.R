#' Filter CSB date
#'
#' @description \code{csb_date_filter}Filters dates to return only the specified date elements
#'
#' @usage csb_date_filter(.data, var, day, month, year, delete = FALSE)
#'
#' @param .data A tibble with raw CSB data
#' @param var name of column containing date data
#' @param day numeric representation of day(s) to include (leading zero or not will be accepted)
#' @param month numeric/character representation of month(s) to include
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
  # need to add function for entries of greater than length 1
  # for now we will return an error

  if(length(paramList$year) > 1){stop("This function does not yet support arguments greater than length 1")}
  if(length(paramList$month) > 1){stop("This function does not yet support arguments greater than length 1")}
  if(length(paramList$day) > 1){stop("This function does not yet support arguments greater than length 1")}

  ## Correction and checking for year
  # correct too short of a year entry
  if(is.numeric(paramList$year)&&nchar(paramList$year) < 4){year <- 2000 + year}

  # will need a loop for multiple year arguments.
  #if(length(year) >1: for(i in year) year <- append(year, 2000 + year)

  #check that year entry is valid for csb data, warn for entry of 2008.
  if(!is.null(year)&&!(year %in% c(2008, 2009, 2010, 2011, 2012, 2013, 2014, 2015, 2016, 2017, 2018))){stop("The year variable is an invalid argument")}
  if(!is.null(year)&&year == 2008){message("2008 only contains traffic requests")} #this only works if 2008 is the first number in the vector, which I assume it will always be


  ## correction and checking for month
  # vectors for alternative month entry formats
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


  if(!is.null(month)&&month %in% jan){month = 1}
  else if(!is.null(month)&&month %in% feb){month = 2}
  else if(!is.null(month)&&month %in% mar){month = 3}
  else if(!is.null(month)&&month %in% apr){month = 4}
  else if(!is.null(month)&&month %in% may){month = 5}
  else if(!is.null(month)&&month %in% jun){month = 6}
  else if(!is.null(month)&&month %in% jul){month = 7}
  else if(!is.null(month)&&month %in% aug){month = 8}
  else if(!is.null(month)&&month %in% sep){month = 9}
  else if(!is.null(month)&&month %in% oct){month = 10}
  else if(!is.null(month)&&month %in% nov){month = 11}
  else if(!is.null(month)&&month %in% dec){month = 12}

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