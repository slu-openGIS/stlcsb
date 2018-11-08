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
#' @return \code{csb_geo} returns a sf object of the input data, specifying a new crs will reproject the data.
#'
#' @importFrom sf st_as_sf st_transform
#' @importFrom rlang quo enquo sym :=
#'
#' @export
csb_geo <- function(.data, varX, varY, crs = NULL){

  ### Check input and Non-Standard evaluation
  ## check for missing parameters of required arguments
  if (missing(.data)) {
    stop('Please provide an argument for .data')
  }
  if (missing(varX)) {
    stop('Please provide an argument for varX')
  }
  if (missing(varY)) {
    stop('Please provide an argument for varY')
  }


  # I have determined that NSE likely is not supported by the SF package. So I will return an error
  # message for unquoted input (At least for now)
  # save parameters to list
  paramList <- as.list(match.call())

  if(!is.character(paramList$varX)){stop("Please provide a quoted argument for varX")}
  if(!is.character(paramList$varY)){stop("Please provide a quoted argument for varY")}

  print(.data[[varX]])
# based on testing, I believe the CSB data to include US Survey feets coordinates by default
# Which is EPSG = 102696

  if(is.na(.data[[varX]])){stop('Please use the csb_missing with filter = TRUE to remove invalid spatial data before using this function.')}
  st_as_sf(.data, coords = c(x = varX, y = varY), crs = 102696) -> sfobj

# Reproject

 if(!is.null(crs)){st_transform(sfobj, crs = crs) -> sfobj}

 # if (is.true(replace)){mutate(varX =)
 # mutate

  return(sfobj)
}
