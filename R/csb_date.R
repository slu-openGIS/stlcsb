#' Clean CSB date
#'
#' @description \code{csb_date} retuns a new column with date in the POSIX format
#'
#' @usage csb_date(.data, var, newVar)
#'
#' @param .data A tibble with raw CSB data
#' @param var name of column containing date data
#' @param newVar name of column to be returned with tidy dates
#' @param overwrite if true, the current column will be overwritten rather than a new column created
#'
#' @return \code{csb_date} returns a new column with date in the POSIX format.
#'
#' @import dplyr
#' @importFrom here here
#' @importFrom rlang :=
#' @importFrom rlang quo
#' @importFrom rlang enquo
#' @importFrom rlang sym
#'
#' @export
csb_date <- function(.data, var, newVar, overwrite = FALSE){

  if (overwrite == TRUE){newVar <- var}

  mutate(.data, newVar =
           as.POSIXct(var))
}

# What should this function do?
# Month, year filtering?
