#' Identifying Calls Missing Coordinate Data
#'
#' @description \code{csb_missingXY} returns a logical vector indicating if an
#'     observation is missing in either of the coordinate columns that come
#'     with the CSB data.
#'
#' @usage csb_missingXY(.data, varX, varY, newVar)
#'
#' @param .data A tibble or data frame
#' @param varX Name of column containing x coordinate data
#' @param varY Name of column containing y coordinate data
#' @param newVar Name of new column that is \code{TRUE} if coordinate data are
#'     missing and \code{FALSE} otherwise.
#'
#' @return A tbl with a logical vector appended to it.
#'
#' @importFrom dplyr %>%
#' @importFrom dplyr filter
#' @importFrom dplyr mutate
#' @importFrom rlang :=
#' @importFrom rlang enquo
#' @importFrom rlang quo
#' @importFrom rlang sym
#'
#' @examples
#' csb_missingXY(january_2018, srx, sry, newVar = "missingXY")
#'
#' @export
csb_missingXY <- function(.data, varX, varY, newVar){

  # global variables
  ...missingXY = NULL

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

  if (missing(newVar)) {
    stop("Please provide an argument for 'newVar' with a new variable name.")
  }

  # save parameters to list
  paramList <- as.list(match.call())

  # quote input variables
  if (!is.character(paramList$varX)) {
    varXN <- rlang::enquo(varX)
  } else if (is.character(paramList$varX)) {
    varXN <- rlang::quo(!! rlang::sym(varX))
  }

  if (!is.character(paramList$varY)) {
    varYN <- rlang::enquo(varY)
  } else if (is.character(paramList$varY)) {
    varYN <- rlang::quo(!! rlang::sym(varY))
  }

  newVarNQ <- rlang::quo_name(rlang::enquo(newVar))

  # create column
  .data %>%
    dplyr::mutate(...missingXY := case_when(
      is.na(!!varXN) | is.na(!!varYN) ~ TRUE,
      !!varXN < 800000 | !!varYN < 980000 ~ TRUE
    )) %>%
    dplyr::mutate(...missingXY := ifelse(is.na(...missingXY) == TRUE, FALSE, ...missingXY)) %>%
    dplyr::rename(!!newVarNQ := ...missingXY) -> out

  # check class of output
  if ("tbl_df" %in% class(out) == FALSE){
    out <- dplyr::as_tibble(out)
  }

  ## return output
  return(out)

}
