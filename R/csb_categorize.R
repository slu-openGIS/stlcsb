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
             !!varN %in% admin ~ "Admin",
             !!varN %in% animal ~ "Animal",
             !!varN %in% construction ~ "Construction",
             !!varN %in% debris ~ "Debris",
             !!varN %in% degrade ~ "Degrade",
             !!varN %in% disturbance ~ "Disturbance",
             !!varN %in% event ~ "Event",
             !!varN %in% health ~ "Health",
             !!varN %in% landscape ~ "Landscape",
             !!varN %in% law ~ "Law",
             !!varN %in% maintenance ~ "Maintenance",
             !!varN %in% nature ~ "Nature",
             !!varN %in% road ~ "Road",
             !!varN %in% sewer ~ "Sewer",
             !!varN %in% traffic ~ "Traffic",
             !!varN %in% waste ~ "Waste")) -> pm

  # return the data again with categories
  return(pm)

}
