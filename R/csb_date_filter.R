#' Filter CSB date
#'
#' @description \code{csb_date_filter}Filters dates to return only the specified date elements
#'
#' @usage csb_date_filter(.data, var, day, month, year, delete = FALSE)
#'
#' @param .data A tibble with raw CSB data
#' @param var name of column containing date data
#' @param day numeric vector of day(s) to include.
#' @param month numeric/character vector of month(s) to include
#' @param year numeric vector of years(s) to include (2 or 4 digit)
#' @param delete if true, deletes the original column containing dates
#'
#' @return \code{csb_date_filter}returns a filtered version of the input data based on specified arguments
#'
#' @importFrom dplyr mutate filter
#' @importFrom lubridate day month year
#' @importFrom rlang quo enquo sym .data
#' @importFrom magrittr %>%
#'
#' @example
#' csb_date_filter(january_2018, DATETIMEINIT, day = 1:2)
#'
#' @export
csb_date_filter <- function(.data, var, day = NULL, month = NULL, year = NULL, delete = FALSE){
#MISSING AND NSE SETUP
  if (missing(.data)) {
    stop('Please provide an argument for .data')
  }
  if (missing(var)) {
    stop('Please provide an argument for var')
  }
  if (missing(day)&&missing(month)&&missing(year)){
    stop('Please provide at least one argument for day, month or year')
  }

  # save parameters to list
  paramList <- as.list(match.call())

  # and quote input variables
  if (!is.character(paramList$var)) {
    varN <- rlang::enquo(var)
  }
  else if (is.character(paramList$var)) {
    varN <- rlang::quo(!! rlang::sym(var))
  }

  if (!is.character(paramList$month)) {
    monthN <- rlang::enquo(month)
  }
  else if (is.character(paramList$month)) {
    monthN <- rlang::quo(!! rlang::sym(month))
  }

# Correction and checking for year
  # correct too short of a year entry
  if(is.numeric(year)&&nchar(year) < 4){year <- 2000 + year}

  #check that year entry is valid for csb data, warn for entry of 2008.
  if(!missing(year)&&!(year %in% c(2008, 2009, 2010, 2011, 2012, 2013, 2014, 2015, 2016, 2017, 2018))){stop("The year variable is an invalid argument")}
  if(!missing(year)&&(2008 %in% year)){message("2008 only contains traffic requests")} #this only works if 2008 is the first number in the vector, which I assume it will always be

# Correction and checking for month
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

if(is.character(month)){
  monthF <- c()
  for(i in month){
    if(i %in% jan){monthF <- append(monthF, 1)}
    else if(i %in% feb){monthF <- append(monthF, 2)}
    else if(i %in% mar){monthF <- append(monthF, 3)}
    else if(i %in% apr){monthF <- append(monthF, 4)}
    else if(i %in% may){monthF <- append(monthF, 5)}
    else if(i %in% jun){monthF <- append(monthF, 6)}
    else if(i %in% jul){monthF <- append(monthF, 7)}
    else if(i %in% aug){monthF <- append(monthF, 8)}
    else if(i %in% sep){monthF <- append(monthF, 9)}
    else if(i %in% oct){monthF <- append(monthF, 10)}
    else if(i %in% nov){monthF <- append(monthF, 11)}
    else if(i %in% dec){monthF <- append(monthF, 12)}
  }
}

#-----------------------------------------------------------------------------------------------------------------------------
  ##Filter is conducted in the most efficient order for large data
  # filter for year
  if(!missing(year)){.data %>%
      dplyr::filter(lubridate::year(!!varN) %in% year) -> .data
  }
  # filter for month
  if(!missing(month)){.data %>%
      dplyr::filter(lubridate::month(!!varN) %in% monthF) -> .data
  }
  # filter for day
  if(!missing(day)){.data %>%
      dplyr::filter(lubridate::day(!!varN) %in% day) -> .data
  }

  ## Delete the original var
  if (delete == TRUE){
    dplyr::select(.data, -!!varN) -> .data
  }

  # return processed data
  return(.data)
}
