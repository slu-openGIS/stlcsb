#' Categorize Raw CSB Data
#'
#' @description \code{csb_categorize} provides intelligible categories for the CSB data based on problem code.
#'
#' @usage csb_categorize(.data, var, newVar)
#'
#' @param .data A tibble with raw CSB data
#' @param var Name of orginal variable containing problem code
#' @param newVar Name of output variable to be created with category name
#'
#' @return \code{csb_categorize} returns data with an additional variable for an intelligible category for CSB requests.
#'
#' @importFrom dplyr case_when mutate
#' @importFrom rlang quo enquo sym .data
#' @importFrom magrittr %>%
#'
#' @export
csb_categorize <- function(.data, var, newVar){
#MISSING AND NSE SETUP
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

  # and quote input variables
  if (!is.character(paramList$var)) {
    varN <- rlang::enquo(var)
  }
  else if (is.character(paramList$var)) {
    varN <- rlang::quo(!! rlang::sym(var))
  }

  newVarN <- rlang::quo_name(rlang::enquo(newVar))
#ASSIGN CATEGORIES
  # Then we use a mutate function to assign categories
  .data %>%
    dplyr::mutate(!!newVarN := dplyr::case_when(
             !!varN %in% cat_admin ~ "Admin",
             !!varN %in% cat_animal ~ "Animal",
             !!varN %in% cat_construction ~ "Construction",
             !!varN %in% cat_debris ~ "Debris",
             !!varN %in% cat_degrade ~ "Degrade",
             !!varN %in% cat_disturbance ~ "Disturbance",
             !!varN %in% cat_event ~ "Event",
             !!varN %in% cat_health ~ "Health",
             !!varN %in% cat_landscape ~ "Landscape",
             !!varN %in% cat_law ~ "Law",
             !!varN %in% cat_maintenance ~ "Maintenance",
             !!varN %in% cat_nature ~ "Nature",
             !!varN %in% cat_road ~ "Road",
             !!varN %in% cat_sewer ~ "Sewer",
             !!varN %in% cat_traffic ~ "Traffic",
             !!varN %in% cat_waste ~ "Waste")) -> pm

  # return the data again with categories
  return(pm)

}
