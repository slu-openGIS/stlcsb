#' Missing CSB data
#'
#' @description \code{csb_missing} retuns a logical vector indicating `TRUE` if an observation is missing SRX or SRY data.
#'
#' @usage csb_missing(.data, varX, varY)
#'
#' @param .data A tibble with raw CSB data
#' @param varX name of column containing SRX data
#' @param varY name of column containing  SRY data
#'
#' @return \code{csb_missing} returns a logical vector indicating `TRUE` if an observation has incomplete spatial data.
#'
#' @importFrom dplyr filter
#' @importFrom rlang :=
#' @importFrom rlang quo
#' @importFrom rlang enquo
#' @importFrom rlang sym
#'
#' @export
csb_missing <- function(.data, varX, varY, newVar, filter = FALSE){


  if (nchar(as.numeric(varX)) < 6){mutate(.data, newVar = TRUE)}
  if (nchar(as.numeric(varY)) < 6){return(TRUE)}

  if (isTRUE(filter)){.data %>%
  dplyr::filter(as.numeric(varX) >=6) %>%
  dplyr::filter(as.numeric(varY) >=6) -> filtered
  return(filtered)
  }
}
