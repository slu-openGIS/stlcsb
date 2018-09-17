#' Clean CSB geo to latitude and longitude
#'
#' @description \code{csb_geo} converts SRX and SRY data into latitude and longitude coordinates.
#'
#' @usage csb_geo(.data, varX, varY)
#'
#' @param .data A tibble with raw CSB data
#' @param varX name of column containing SRX data
#' @param varY name of column containing SRY data
#'
#' @return \code{csb_geo} returns a `latitude` and `longitude` column with properly formatted spatial data in an SF format
#'
#' @import dplyr
#' @import sf
#' @importFrom here here
#' @importFrom rlang :=
#' @importFrom rlang quo
#' @importFrom rlang enquo
#' @importFrom rlang sym
#'
#' @export
csb_geo <- function(.data, varX, varY){

}
