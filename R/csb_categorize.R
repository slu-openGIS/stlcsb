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
#' @importFrom ralng .data
#'
#' @export
csb_categorize <- function(.data, var, newVar){

  ## NOTES FOR FUTURE WORK
  # Add error checking, remember that NULL checking broke NSE the first time, try other methods.

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

  ## Might be able to add error checking at this point...

  # First we have to import the category defintions located in the package directory "data"

  load("data/definitions.rda")

  # Then we use a mutate function to assign categories
  .data %>%
    dplyr::mutate(!!newVarN := dplyr::case_when(
             !!varX %in% admin ~ "Admin",
             !!varX %in% animal ~ "Animal",
             !!varX %in% construction ~ "Construction",
             !!varX %in% debris ~ "Debris",
             !!varX %in% degrade ~ "Degrade",
             !!varX %in% disturbance ~ "Disturbance",
             !!varX %in% event ~ "Event",
             !!varX %in% health ~ "Health",
             !!varX %in% landscape ~ "Landscape",
             !!varX %in% law ~ "Law",
             !!varX %in% maintenance ~ "Maintenance",
             !!varX %in% nature ~ "Nature",
             !!varX %in% road ~ "Road",
             !!varX %in% sewer ~ "Sewer",
             !!varX %in% traffic ~ "Traffic",
             !!varX %in% waste ~ "Waste")) -> pm

  # return the data again with categories

  return(pm)

}
