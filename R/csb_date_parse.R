#' Parse CSB Date and Time Variables
#'
#' @description \code{csb_date_parse} is used to parse out dates into more intellgible formats
#'
#' @usage csb_date_parse(.data, var, day, month, year, delete = FALSE)
#'
#' @param .data A tbl
#' @param var name of column containing date data
#' @param day if specified, returns a named column with parsed day
#' @param month if specified, returns a named column with parsed month
#' @param year if specified, returns a named column with parsed year
#' @param delete if true, deletes the original column with unparsed data
#'
#' @return \code{csb_date_parse} returns new columns with specified names containing parsed date information
#'
#' @importFrom dplyr mutate
#' @importFrom lubridate day
#' @importFrom lubridate month
#' @importFrom lubridate year
#' @importFrom rlang :=
#' @importFrom rlang enquo
#' @importFrom rlang quo
#' @importFrom rlang sym
#'
#' @examples
#' csb_date_parse(january_2018, DATETIMEINIT, dayInit)
#' csb_date_parse(january_2018, DATETIMEINIT, dayInit, monthInit)
#' csb_date_parse(january_2018, DATETIMEINIT, month = monthInit)
#' csb_date_parse(january_2018, DATETIMEINIT, month = monthInit, year = yearInit)
#' csb_date_parse(january_2018, DATETIMEINIT, dayInit, monthInit, yearInit, delete = TRUE)
#'
#' @export
csb_date_parse <- function(.data, var, day, month, year, delete = FALSE){

  # check for missing parameters
  if (missing(.data)) {
    stop('Please provide an argument for .data')
  }
  if (missing(var)) {
    stop('Please provide an argument for var')
  }
  if(missing(day)&&missing(month)&&missing(year)){
    stop('Please provide at least one argument for day, month or year')
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

  dayN <- rlang::quo_name(rlang::enquo(day))

  monthN <- rlang::quo_name(rlang::enquo(month))

  yearN <- rlang::quo_name(rlang::enquo(year))

  # parse data
  # day
  if(dayN != ""){
    .data <- dplyr::mutate(.data, !!dayN := lubridate::day(!!varN))
  }

  # month
  if(monthN != ""){
    .data <- dplyr::mutate(.data, !!monthN := lubridate::month(!!varN))
  }

  # year
  if(yearN != ""){
    .data <- dplyr::mutate(.data, !!yearN := lubridate::year(!!varN))
  }

  # remove original variable
  if (delete == TRUE){
    .data <- dplyr::select(.data, -!!varN)
  }

  # return output
  return(.data)

}
