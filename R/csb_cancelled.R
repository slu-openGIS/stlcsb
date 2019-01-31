#' Remove Cancelled Calls for Service
#'
#' @description Subsets data to remove any call with a date and time cancelled.
#'
#' @usage csb_cancelled(.data, var, drop = TRUE)
#'
#' @param .data A tbl
#' @param var Name of the column containing cancellation timestamps; by default
#'     this should be \code{DATECANCELLED}
#' @param drop Optionally remove the now empty column that had contained cancellation
#'     date and time if \code{TRUE}
#'
#' @return Returns a tibble with the rows containing dates and times for the
#'     given variable removed.
#'
#' @importFrom dplyr filter
#' @importFrom dplyr rename
#' @importFrom dplyr select
#'
#' @examples
#' csb_cancelled(january_2018, var = "DATECANCELLED")
#' csb_cancelled(january_2018, var = "DATECANCELLED", drop = FALSE)
#'
#' @export
csb_cancelled <- function(.data, var, drop = TRUE){

  # global variables
  ...cancelled = NULL

  # check for missing parameters
  if (missing(.data)) {
    stop('Please provide an argument for .data')
  }

  if (missing(var)) {
    stop('Please provide the name of the variable containing the cancellation timestamps.')
  }

  # save parameters to list for quoting
  paramList <- as.list(match.call())

  # quote input variables
  varNQ <- rlang::quo_name(rlang::enquo(var))

  # filter
  .data %>%
    dplyr::rename(...cancelled = !!varNQ) %>%
    dplyr::filter(is.na(...cancelled) == TRUE) %>%
    dplyr::rename(!!varNQ := ...cancelled) -> out

  # optionally remove the now empty column
  if (drop == TRUE){
    out <- dplyr::select(out, -!!varNQ)
  }

  # return output
  return(out)

}
