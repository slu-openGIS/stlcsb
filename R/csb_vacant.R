#' Identify Calls for Service Related to Vacancy
#'
#' @description \code{csb_vacant} appends a logical vector indicating \code{TRUE}
#'     for vacancy related problem codes.
#'
#' @usage csb_vacant(.data, var, newVar)
#'
#' @param .data A tibble or data frame
#' @param var Name of existing column containing problem codes
#' @param newVar Name of output variable to be created with vacant logical
#'
#' @return Returns a tibble with the logical vector added as a new variable.
#'
#' @importFrom dplyr as_tibble
#' @importFrom dplyr mutate
#' @importFrom rlang :=
#' @importFrom rlang enquo
#' @importFrom rlang quo
#' @importFrom rlang sym
#'
#' @examples
#' csb_vacant(january_2018, var = problemcode, newVar = vacant)
#'
#' @export
csb_vacant <- function(.data, var, newVar){

  # check for missing parameters
  if (missing(.data)) {
    stop('Please provide an argument for .data.')
  }

  if (missing(var)) {
    stop("Please provide the name of the variable containing the problem codes for 'var'.")
  }

  if (missing(newVar)){
    stop("Please provide a new variable name for 'newVar'.")
  }

  # save parameters to list
  paramList <- as.list(match.call())

  # quote input variables
  if (!is.character(paramList$var)) {
    varN <- rlang::enquo(var)
  } else if (is.character(paramList$var)) {
    varN <- rlang::quo(!! rlang::sym(var))
  }

  newVarN <- rlang::quo_name(rlang::enquo(newVar))

  # append logical for vacant codes
  out <- dplyr::mutate(.data, !!newVarN := ifelse(!!varN %in% stlcsb::cat_vacant, TRUE, FALSE))

  # check class of output
  if ("tbl_df" %in% class(out) == FALSE){
    out <- dplyr::as_tibble(out)
  }

  # return output
  return(out)

}
