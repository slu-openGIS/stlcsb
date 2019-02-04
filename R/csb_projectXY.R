#' Project Calls for Service Data Using Coordinates
#'
#' @description \code{csb_projectXY} converts srx and sry data into a simple features object.
#'     You can write a shapefile directly from the output of this function using \code{sf::st_write}.
#'
#' @usage csb_projectXY(.data, varX, varY, crs)
#'
#' @param .data A tibble or data frame
#' @param varX Name of column containing x coordinate data
#' @param varY Name of column containing y coordinate data
#' @param crs Optional; coordinate reference system for the data to be projected into
#'
#' @return Returns a sf object of the input data projected as point data.
#'
#' @importFrom sf st_as_sf
#' @importFrom sf st_transform
#' @importFrom rlang :=
#' @importFrom rlang enquo
#' @importFrom rlang quo
#' @importFrom rlang sym
#'
#' @examples
#' # remove missing coordinates prior to projecting
#' csb <- csb_missingXY(january_2018, srx, sry, newVar = missing)
#' csb <- dplyr::filter(csb, missing == FALSE)
#'
#' # project data
#' csb_projectXY(csb, srx, sry)
#'
#' # project with a custom crs
#' csb_projectXY(csb, srx, sry, crs = 4269)
#'
#' @export
csb_projectXY <- function(.data, varX, varY, crs){

  # check for missing parameters
  if (missing(.data)) {
    stop('Please provide an argument for .data')
  }

  if (missing(varX)) {
    stop('Please provide an argument for varX with the variable name for the column with x coordinate data.')
  }

  if (missing(varY)) {
    stop('Please provide an argument for varY with the variable name for the column with y coordinate data.')
  }

  # quote inputs
  varXN <- rlang::quo_name(rlang::enquo(varX))
  varYN <- rlang::quo_name(rlang::enquo(varY))

  # check for invalid spatial data, which will error in the sf function
  if(anyNA(.data[,varXN]) == TRUE){

    stop('Please use the csb_missing with filter = TRUE to remove invalid spatial data before using this function.')

  }

  # project
  out <- sf::st_as_sf(.data, coords = c(x = varXN, y = varYN),
                      crs = "+proj=tmerc +lat_0=35.83333333333334 +lon_0=-90.5 +k=0.9999333333333333 +x_0=250000 +y_0=0 +datum=NAD83 +units=us-ft +no_defs ")

  # optionally reproject
  if(!missing(crs)){

    out <- sf::st_transform(out, crs = crs)

  }

  # return the sf object

  return(out)

}
