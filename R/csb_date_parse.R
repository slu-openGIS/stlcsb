#' Parse CSB Date and Time Variables
#'
#' @description \code{csb_date_parse} is used to parse out dates into
#'     day, month, and year elements.
#'
#' @usage csb_date_parse(.data, var, day, month, year, drop = FALSE)
#'
#' @param .data A tibble or data frame
#' @param var name of column containing date data
#' @param day Optional; returns a named column with parsed day
#' @param month Optional; returns a named column with parsed month
#' @param year Optional; returns a named column with parsed year
#' @param drop A logical scalar; if \code{TRUE}, removes the original column
#'     that had contained date and time data, otherwise if \code{FALSE}
#'     the original column is retained.
#'
#' @return Returns a tibble with new columns containing parsed date information
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
#' csb_date_parse(january_2018, datetimeinit, dayInit)
#' csb_date_parse(january_2018, datetimeinit, dayInit, monthInit)
#' csb_date_parse(january_2018, datetimeinit, month = monthInit)
#' csb_date_parse(january_2018, datetimeinit, month = monthInit, year = yearInit)
#' csb_date_parse(january_2018, datetimeinit, dayInit, monthInit, yearInit, drop = TRUE)
#'
#' @export
csb_date_parse <- function(.data, var, day, month, year, drop = FALSE){

  # check for missing parameters
  if (missing(.data)) {
    stop('Please provide an argument for .data')
  }

  if (missing(var)) {
    stop("Please provide the name of the variable containing the date you want to parse from for 'var'.")
  }

  if(missing(day)&&missing(month)&&missing(year)){
    stop('Please provide at least one argument for day, month or year')
  }

  # check inputs
  if (is.logical(drop) == FALSE){
    stop("Input for the 'drop' argument is invalid - it must be either 'TRUE' or 'FALSE'.")
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
  if (drop == TRUE){
    .data <- dplyr::select(.data, -!!varN)
  }

  # check class of output
  if ("tbl_df" %in% class(.data) == FALSE){
    .data <- dplyr::as_tibble(.data)
  }

  # return output
  return(.data)

}
