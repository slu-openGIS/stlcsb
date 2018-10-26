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
#' @return \code{csb_missing} returns a logical vector indicating `TRUE` if an observation has incomplete spatial data, or a filtered version of the input data
#'
#' @importFrom dplyr mutate
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
  else if (is.character(paramList$varX)) {
    varXN <- rlang::quo(!! rlang::sym(varX))
  }
  if (!is.character(paramList$varY)) {
    varYN <- rlang::enquo(varY)
  }
  else if (is.character(paramList$varY)) {
    varYN <- rlang::quo(!! rlang::sym(varY))
  }

  newVarN <- rlang::quo_name(rlang::enquo(newVar))

  ### METHODS: Is it fair to assume that nchar() < 6 is invalid???
  ## Found some edge cases that need to be accounted for... for example srx = -10050058.4

  ## if newVar is named
  # mutate function
  if(newVarN != ""){.data %>%
      dplyr::mutate(!!newVarN := dplyr::if_else((nchar(!!varXN) >= 6), FALSE, TRUE)) -> out #this is the test, if SRX and SRY are not both >=6, return TRUE for 'missing'
    # need addition to check for SRY, but not to ever replace a TRUE with FALSE...
  #&&(nchar(!!varYN) >= 6)

    # edge case, showing false 900000,
    # need to quote before checking length '900000' is 6 char
    #cause of the issue is that more than 4 zeros produces sci notation

  }
  #if (nchar(as.numeric(!!varXN)) < 6){mutate(.data, newVar = TRUE)}
  #if (nchar(as.numeric(!!varYN)) < 6){return(TRUE)}

  ## if filter is true
  # The filter function
  if (isTRUE(filter)){.data %>%
  dplyr::filter(nchar(!!varXN) >=6) %>%
  dplyr::filter(nchar(!!varYN) >=6) -> filtered
  }

  ## return based on filter argument
  if(isTRUE(filter)){return(filtered)}
  else if(isFALSE(filter)&&newVarN != ""){return(out)} ##is.charcater may not work because of NSE here

  ## would like to return a message with the count of observations removed.
}

