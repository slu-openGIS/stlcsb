#' Missing CSB data
#'
#' @description \code{csb_missing} returns a logical vector indicating `TRUE` if an observation is missing SRX or SRY data.
#'
#' @usage csb_missing(.data, varX, varY, newVar, filter = FALSE)
#'
#' @param .data A tibble with raw CSB data
#' @param varX name of column containing SRX data
#' @param varY name of column containing SRY data
#' @param newVar if named, produces a new column with a logical indicator of incomplete spatial data
#' @param filter if true, returns a filtered version of the data with only observations with complete spatial data
#'
#' @return \code{csb_missing} returns a logical vector indicating `TRUE` if an observation has incomplete spatial data, or a filtered version of the input data
#'
#'
#' @importFrom dplyr mutate filter
#' @importFrom rlang quo enquo sym :=
#'
#' @export
csb_missing <- function(.data, varX, varY, newVar, filter = FALSE){
  ### Check input and Non-Standard evaluation
  ## check for missing parameters
  if (missing(.data)) {
    stop('Please provide an argument for .data')
  }
  if (missing(varX)) {
    stop('Please provide an argument for varX')
  }
  if (missing(varY)) {
    stop('Please provide an argument for varY')
  }

  ## NSE Setup
  # save parameters to list
  paramList <- as.list(match.call())

  # quote input variables
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

  options(scipen = 8) #this changes print behavior so that X00000 remains X00000 rather than Xe+05

  #Error checking for arguments
  if(newVarN == ""&&isFALSE(filter)){stop("Please supply an argument for newVar OR filter")}
  if(newVarN != ""&&isTRUE(filter)){warning("A logical is not appended if filter is TRUE")}

  ## if newVar is named
  # mutate function
  if(newVarN != ""){.data %>%
      dplyr::mutate(!!newVarN := case_when(
        is.na(!!varXN)|is.na(!!varYN) ~ TRUE,
        nchar(!!varXN) < 6 | nchar(!!varYN) < 6 ~ TRUE,
        nchar(!!varXN) >= 6 | nchar(!!varYN) >= 6 ~ FALSE
      )) -> out

  }

  # The filter function
  if (isTRUE(filter)){.data %>%
  dplyr::filter(nchar(!!varXN) >=6) %>%
  dplyr::filter(nchar(!!varYN) >=6) -> filtered
  }

  ## return based on filter argument
  if(isTRUE(filter)){n <- (nrow(.data) - nrow(filtered))
    message(paste0(n," observations were filtered out"))
    return(filtered)
    }
  else if(isFALSE(filter)){return(out)}

}

