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
#' @importFrom dplyr mutate
#' @importFrom sf st_as_sf
#' @importFrom sf st_transform
#' @importFrom rlang :=
#' @importFrom rlang quo
#' @importFrom rlang enquo
#' @importFrom rlang sym
#'
#' @export
csb_geo <- function(.data, varX, varY, replace = TRUE, crs = NULL){

  ## Still need to write bit for replace function. CRS reprojects based on specified crs
  # Clean dependencies

  # I have determined that NSE likely is not supported by the SF package. So I will return an error
  # message for unquoted input (At least for now)
  # save parameters to list
  paramList <- as.list(match.call())

  if(!is.character(paramList$varX)){stop("Please provide a quoted argument for varX")}
  if(!is.character(paramList$varY)){stop("Please provide a quoted argument for varY")}


# based on testing, I believe the CSB data to include US Survey feets coordinates by default
# Which is EPSG = 102696

  st_as_sf(.data, coords = c(x = varX, y = varY), crs = 102696) -> sfobj

# Reproject

 if(!is.null(crs)){st_transform(sfobj, crs = crs) -> sfobj}

 # if (is.true(replace)){mutate(varX =)
 # mutate

  return(sfobj)
}
