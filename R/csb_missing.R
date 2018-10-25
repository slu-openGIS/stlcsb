#' Missing CSB data
#'
#' @description \code{csb_missing} retuns a logical vector indicating `TRUE` if an observation is missing SRX or SRY data.
#'
#' @usage csb_missing(.data, varX, varY, newVar, filter = FALSE)
#'
#' @param .data A tibble with raw CSB data
#' @param varX name of column containing SRX data
#' @param varY name of column containing  SRY data
#' @param newVar if named, produces a new column with a logical indicator of incomplete spatial data (For x OR y)
#' @param filter if true, returns a filtered version of the data with only observations with complete spatial data
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

  ### NSE Setup
  # save parameters to list
  paramList <- as.list(match.call())

  # and quote input variables
  if (!is.character(paramList$varX)) {
    varXN <- rlang::enquo(varX)
  }
  else if (is.character(paramList$var)) {
    varXN <- rlang::quo(!! rlang::sym(varX))
  }
  if (!is.character(paramList$varX)) {
    varYN <- rlang::enquo(varY)
  }
  else if (is.character(paramList$var)) {
    varYN <- rlang::quo(!! rlang::sym(varY))
  }
  newVarN <- rlang::quo_name(rlang::enquo(newVar))



  # mutate function

  if (nchar(as.numeric(varX)) < 6){mutate(.data, newVar = TRUE)}
  if (nchar(as.numeric(varY)) < 6){return(TRUE)}


  # The filter function
  if (isTRUE(filter)){.data %>%
  dplyr::filter(as.numeric(varX) >=6) %>%
  dplyr::filter(as.numeric(varY) >=6) -> filtered
  return(filtered)
  }

  ## return based on filter argument
  if(isTRUE(filter)){return(filtered)}
  else if(isFALSE(filter)&&is.character(newVarN)) return(out)) ##is.charcater may not work because of NSE here
}
