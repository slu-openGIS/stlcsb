#' Clean CSB geo to SF object
#'
#' @description \code{csb_geo} converts SRX and SRY data into a simple features object.
#'
#' @usage csb_geo(.data, varX, varY, replace, crs)
#'
#' @param .data A tibble with raw CSB data
#' @param varX name of column containing SRX data
#' @param varY name of column containing SRY data
#' @param replace If true, the original spatial data columns will be dropped
#' @param crs coordinate reference system for the data to be projected into
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
csb_geo <- function(.data, varX, varY, replace = TRUE, crs = NULL){

  st_as_sf(.data, coords = (x = varX, y = varY))

  st_transform()

  if (is.true(replace)){dplyr::select(-varX, - varY)}
}
