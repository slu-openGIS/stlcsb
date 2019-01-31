#' Categorize Raw CSB Data
#'
#' @description \code{csb_categorize} provides general categories for the CSB data based on problem code.
#'
#' @usage csb_categorize(.data, var, newVar)
#'
#' @param .data A tibble with raw CSB data
#' @param var Name of orginal variable containing problem code
#' @param newVar Name of output variable to be created with category name
#'
#' @return \code{csb_categorize} returns data with an additional variable for an intelligible category for CSB requests.
#'
#' @importFrom dplyr case_when
#' @importFrom dplyr mutate
#' @importFrom magrittr %>%
#' @importFrom rlang :=
#' @importFrom rlang enquo
#' @importFrom rlang quo
#' @importFrom rlang sym
#'
#' @examples
#' csb_categorize(january_2018, PROBLEMCODE, Category)
#'
#' @export
csb_categorize <- function(.data, var, newVar){

  # check for missing parameters
  if (missing(.data)) {
    stop('Please provide an argument for .data')
  }
  if (missing(var)) {
    stop('Please provide an argument for var')
  }
  if (missing(newVar)) {
    stop('Please provide an argument for newVar')
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
  .data %>%
    dplyr::mutate(!!newVarN := dplyr::case_when(
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
             !!varN %in% stlcsb::cat_waste ~ "Waste")) -> out

  # return output
  return(out)

}
