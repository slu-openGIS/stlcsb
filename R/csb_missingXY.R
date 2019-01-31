#' Missing spatial CSB data
#'
#' @description \code{csb_missingXY} returns a logical vector indicating if an
#'     observation is missing in either of the coordinate columns that come
#'     with the CSB data.
#'
#' @usage csb_missingXY(.data, varX, varY, newVar)
#'
#' @param .data A tbl
#' @param varX name of column containing SRX data
#' @param varY name of column containing SRY data
#' @param newVar name of new column that is \code{TRUE} if coordinate data are
#'     missing and \code{FALSE} otherwise.
#'
#' @return \code{csb_missingXY} A tbl with a logical vector appended to it.
#'
#' @importFrom dplyr filter
#' @importFrom dplyr mutate
#' @importFrom magrittr %>%
#' @importFrom rlang :=
#' @importFrom rlang enquo
#' @importFrom rlang quo
#' @importFrom rlang sym
#'
#' @examples
#' csb_missingXY(january_2018, SRX, SRY, newVar = "missingXY")
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
    stop('Please provide an argument for varY with the variable name for the column with x coordinate data.')
  }

  if (missing(varY)) {
    stop('Please provide an argument for varY with the variable name for the column with y coordinate data.')
  }

  if (missing(newVar)) {
    stop('Please provide an argument for newVar with a new variable name.')
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
      !!varXN == 0 | !!varYN == 0 ~ TRUE,
      !!varXN == 1 | !!varYN == 1 ~ TRUE
    )) %>%
    dplyr::mutate(...missingXY := ifelse(is.na(...missingXY) == TRUE, FALSE, ...missingXY)) %>%
    dplyr::rename(!!newVarNQ := ...missingXY) -> out

  ## return output
  return(out)

}
