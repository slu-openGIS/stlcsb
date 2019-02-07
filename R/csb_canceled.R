#' Remove Canceled Calls for Service
#'
#' @description Subsets data to remove any call with a date and time canceled.
#'
#' @usage csb_canceled(.data, var, drop = TRUE)
#'
#' @param .data A tibble or data frame
#' @param var Name of the column containing cancellation timestamps
#' @param drop A logical scalar; if \code{TRUE}, removes the now empty column
#'     that had contained cancellation date and time, otherwise if \code{FALSE}
#'     the empty column is retained.
#'
#' @return Returns a tibble with the rows containing dates and times for the
#'     given variable removed.
#'
#' @importFrom dplyr %>%
#' @importFrom dplyr as_tibble
#' @importFrom dplyr filter
#' @importFrom dplyr rename
#' @importFrom dplyr select
#'
#' @examples
#' csb_canceled(january_2018, var = "datecancelled")
#' csb_canceled(january_2018, var = "datecancelled", drop = FALSE)
#'
#' @export
csb_canceled <- function(.data, var, drop = TRUE){

  # global variables
  ...cancelled = NULL

  # check for missing parameters
  if (missing(.data)) {
    stop('Please provide an argument for .data')
  }

  if (missing(var)) {
    stop('Please provide the name of the variable containing the cancellation timestamps.')
  }

  # check inputs
  if (is.logical(drop) == FALSE){
    stop("Input for the 'drop' argument is invalid - it must be either 'TRUE' or 'FALSE'.")
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

  # check class of output
  if ("tbl_df" %in% class(out) == FALSE){
    out <- dplyr::as_tibble(out)
  }

  # return output
  return(out)

}
