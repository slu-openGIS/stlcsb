#' Categorize Raw CSB Data
#'
#' @description \code{csb_categorize} provides intelligible categories for the CSB data based on problem code.
#'
#' @usage csb_categorize(.data, var, newVar)
#'
#' @param .data A tibble with raw CSB data
#' @param var Name of orginial variable containing problem code
#' @param newVar Name of output variable to be created with category name
#'
#'
#' @return \code{csb_categorize} returns data with an additional variable for an intelligible category for CSB requests.
#'
#' @importFrom dplyr %>%
#' @importFrom dplyr case_when
#' @importFrom dplyr mutate
#' @importFrom here here
#' @importFrom rlang :=
#' @importFrom rlang quo
#' @importFrom rlang enquo
#' @importFrom rlang sym
#'
#' @export
csb_categorize <- function(.data, var, newVar){

  # then save parameters to list
  paramList <- as.list(match.call())

  # and quote input variables
  if (!is.character(paramList$var)) {
    varX <- rlang::enquo(var)
  }
  else if (is.character(paramList$var)) {
    varX <- rlang::quo(!! rlang::sym(var))
  }

  newVarN <- rlang::quo_name(rlang::enquo(newVar))

  # First we have to import the category defintions located in the package directory "data"

  load("data/definitions.RData")

  # Then we use a mutate function to assign categories
  .data %>%
    dplyr::mutate(!!newVarN := dplyr::case_when(
             !!varX %in% Admin ~ "Admin",
             !!varX %in% Animal ~ "Animal",
             !!varX %in% Construction ~ "Construction",
             !!varX %in% Debris ~ "Debris",
             !!varX %in% Degrade ~ "Degrade",
             !!varX %in% Disturbance ~ "Disturbance",
             !!varX %in% Event ~ "Event",
             !!varX %in% Health ~ "Health",
             !!varX %in% Landscape ~ "Landscape",
             !!varX %in% Law ~ "Law",
             !!varX %in% Maintenance ~ "Maintenance",
             !!varX %in% Nature ~ "Nature",
             !!varX %in% Road ~ "Road",
             !!varX %in% Sewer ~ "Sewer",
             !!varX %in% Traffic ~ "Traffic",
             !!varX %in% Waste ~ "Waste")) -> pm

  # return the data again with categories

  return(pm)

}
