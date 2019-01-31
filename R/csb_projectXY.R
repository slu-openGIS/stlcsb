#' Clean CSB geo to SF object
#'
#' @description \code{csb_projectXY} converts SRX and SRY data into a simple features object.
#'     You can write a shapefile directly from the output of this function using \code{sf::st_write}.
#'
#' @usage csb_projectXY(.data, varX, varY, crs)
#'
#' @param .data A tibble with raw CSB data
#' @param varX Name of column containing SRX data
#' @param varY Name of column containing SRY data
#' @param crs Optional; coordinate reference system for the data to be projected into
#'
#' @return \code{csb_projectXY} returns a sf object of the input data, specifying a new crs will
#'     reproject the data.
#'
#' @importFrom sf st_as_sf st_transform
#' @importFrom rlang quo enquo sym :=
#'
#' @examples
#' #You MUST remove observations with missing coordinates before using this function
#' csb <- csb_missingXY(january_2018, SRX, SRX, filter = TRUE)
#' csb_projectXY(csb, SRX, SRY)
#' csb_projectXY(csb, SRX, SRY, crs = 4269)
#'
#' @export
csb_projectXY <- function(.data, varX, varY, crs){

  # check for missing parameters
  if (missing(.data)) {
    stop('Please provide an argument for .data')
  }

  if (missing(varX)) {
    stop('Please provide an argument for varX')
  }

  if (missing(varY)) {
    stop('Please provide an argument for varY')
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
