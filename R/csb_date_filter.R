#' Filter Calls Based on Date of Call
#'
#' @description \code{csb_date_filter} filters dates to return only the specified date elements.
#'     For example, data can be returned for specific months, years, or portions of months
#'
#'     The month argument can be one of several types. Types cannot be mixed. A numeric argument specifying month is acceptable. Character entry can be one of either 3 letter abbreviations or full month name. Capitalization does not matter.
#'
#' @usage csb_date_filter(.data, var, day, month, year)
#'
#' @param .data A tibble or data frame
#' @param var A name of column containing date data
#' @param day A numeric vector of day(s) to include.
#' @param month A numeric/character vector of month(s) to include. See description for more information on alternate entry formats.
#' @param year A numeric vector of years(s) to include (2 or 4 digit)
#'
#' @return Returns a filtered version of the input data based on specified date arguments.
#'
#' @importFrom dplyr filter
#' @importFrom dplyr mutate
#' @importFrom lubridate day
#' @importFrom lubridate month
#' @importFrom lubridate year
#' @importFrom rlang :=
#' @importFrom rlang enquo
#' @importFrom rlang quo
#' @importFrom rlang sym
#' @importFrom tools toTitleCase
#'
#' @examples
#' csb_date_filter(january_2018, datetimeinit, day = 1)
#' csb_date_filter(january_2018, datetimeinit, day = 1:15, month = 1)
#' csb_date_filter(january_2018, datetimeinit, month = "January", year = 09)
#' csb_date_filter(january_2018, datetimeinit, month = c("jan", "feb", "Mar", "Apr"), year = 2009)
#' csb_date_filter(january_2018, datetimeinit, day = 1:15, month = 1:6, year = 08:13)
#'
#' @export
csb_date_filter <- function(.data, var, day = NULL, month = NULL, year = NULL){

  # check for missing parameters
  if (missing(.data)) {
    stop('Please provide an argument for .data')
  }

  if (missing(var)) {
    stop("Please provide the name of the variable containing the date you want to filter from for 'var'.")
  }

  if (missing(day) & missing(month) & missing(year)){
    stop('Please provide at least one argument for day, month or year.')
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

# Correction and checking for year
  # correct too short of a year entry
  if(is.numeric(year) && all(nchar(year) < 4)){
    year <- 2000 + year
  }

  #check that year entry is valid for csb data, warn for entry of 2008.
  if(!missing(year)){

    if(!all(year %in% 2008:2019)){
      stop("The year given is not valid for these data.")
    }

    if(2008 %in% year){
      message("2008 only contains traffic requests")
    }

  }

  # Correction and checking for month
  if(!missing(month)){
    if(is.character(month)){

      month <- tools::toTitleCase(month)

      # explicitly change may, it's a forbidden word in toTitleCase
      if("may" %in% month){
        month[which(month == "may")] <- "May"
        }

      # month abbreviations
      if(all(nchar(month) < 4)){
        monthN <- which(month %in% month.abb)
      }

      # month names
      else{
        monthN <- which(month %in% month.name)
      }
      # check valid month argument
      if(!all(month %in% c(month.abb, month.name))){
        stop("An invalid argument for 'month' has been specified.")
      }
    }
    else if(is.numeric(month)){
      monthN <- month

      # check valid month argument
      if(!all(monthN %in% 1:12)){
        stop("An invalid argument for 'month' has been specified.")
      }
    }
  }

# filter for year
  if(!missing(year)){
    .data <- dplyr::filter(.data, lubridate::year(!!varN) %in% year)
  }

  # filter for month
  if(!missing(month)){
    .data <- dplyr::filter(.data, lubridate::month(!!varN) %in% monthN)
  }

  # filter for day
  if(!missing(day)){
    .data <- dplyr::filter(.data, lubridate::day(!!varN) %in% day)
  }

  # check class of output
  if ("tbl_df" %in% class(.data) == FALSE){
    .data <- dplyr::as_tibble(.data)
  }

  # return processed data
  return(.data)

}
