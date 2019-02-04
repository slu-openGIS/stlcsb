#' Categorize CSB Call Types
#'
#' @description \code{csb_categorize} provides general categories for the
#'     CSB data based on problem code. These were created based on a review
#'     of the call data in mid-2018.
#'
#' @usage csb_categorize(.data, var, newVar)
#'
#' @param .data A tibble or data frame
#' @param var Name of existing column containing problem codes
#' @param newVar Name of output variable to be created with category string
#'
#' @return Returns a tibble with the string vector added as a new variable.
#'
#' @importFrom dplyr as_tibble
#' @importFrom dplyr case_when
#' @importFrom dplyr mutate
#' @importFrom rlang :=
#' @importFrom rlang enquo
#' @importFrom rlang quo
#' @importFrom rlang sym
#'
#' @examples
#' csb_categorize(january_2018, var = problemcode, newVar = Category)
#'
#' @export
csb_categorize <- function(.data, var, newVar){

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

  # save parameters to list for quoting
  paramList <- as.list(match.call())

  # quote input variables
  if (!is.character(paramList$var)) {
    varN <- rlang::enquo(var)
  } else if (is.character(paramList$var)) {
    varN <- rlang::quo(!! rlang::sym(var))
  }

  newVarN <- rlang::quo_name(rlang::enquo(newVar))

  # assign categories
  out <- dplyr::mutate(.data, !!newVarN := dplyr::case_when(
    !!varN %in% stlcsb::cat_admin ~ "Admin",
    !!varN %in% stlcsb::cat_animal ~ "Animal",
    !!varN %in% stlcsb::cat_construction ~ "Construction",
    !!varN %in% stlcsb::cat_debris ~ "Debris",
    !!varN %in% stlcsb::cat_degrade ~ "Degrade",
    !!varN %in% stlcsb::cat_disturbance ~ "Disturbance",
    !!varN %in% stlcsb::cat_event ~ "Event",
    !!varN %in% stlcsb::cat_health ~ "Health",
    !!varN %in% stlcsb::cat_landscape ~ "Landscape",
    !!varN %in% stlcsb::cat_law ~ "Law",
    !!varN %in% stlcsb::cat_maintenance ~ "Maintenance",
    !!varN %in% stlcsb::cat_nature ~ "Nature",
    !!varN %in% stlcsb::cat_road ~ "Road",
    !!varN %in% stlcsb::cat_sewer ~ "Sewer",
    !!varN %in% stlcsb::cat_traffic ~ "Traffic",
    !!varN %in% stlcsb::cat_waste ~ "Waste"))

  # check class of output
  if ("tbl_df" %in% class(out) == FALSE){
    out <- dplyr::as_tibble(out)
  }

  # return output
  return(out)

}
