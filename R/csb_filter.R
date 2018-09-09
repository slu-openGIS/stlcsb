#' Filter CSB Data
#'
#' @description \code{csb_filter} retuns observations that match one of 16 predefined categories.
#'
#' @usage csb_filter(.data, ...)
#'
#' @param .data A tibble with raw CSB data
#' @param ... values of the categories for the function to return
#'
#' @return \code{csb_filter} returns data with an additional variable for an intelligible category for CSB requests.
#'
#' @import dplyr
#' @importFrom here here
#' @importFrom rlang :=
#' @importFrom rlang quo
#' @importFrom rlang enquo
#' @importFrom rlang sym
#'
#' @export
csb_filter <- function(.data, code, ...){
}
