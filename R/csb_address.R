#' Clean CSB addresses
#'
#' @description \code{csb_address} parses addresses in a manner better suited for geocoding.
#'
#' @usage csb_address(.data, var, newVar)
#'
#' @param .data A tibble with raw CSB data
#' @param var The variable in the data that contains
#' @param newVar Name of output variable with a more tidy version of address.
#'
#' @return \code{csb_address} returns data with an additional variable for a more tidy address.
#'
#' @import dplyr
#' @importFrom here here
#' @importFrom rlang :=
#' @importFrom rlang quo
#' @importFrom rlang enquo
#' @importFrom rlang sym
#'
#' @export
csb_address <- function(.data, var, newVar){

}
