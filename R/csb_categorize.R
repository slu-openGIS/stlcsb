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
#' @importFrom rlang .data
#'
#' @export
csb_categorize <- function(.data, var, newVar){

  # then save parameters to list
  paramList <- as.list(match.call())

  # and quote input variables
  if (!is.character(paramList$var)) {
    varN <- rlang::enquo(var)
  }
  else if (is.character(paramList$var)) {
    varN <- rlang::quo(!! rlang::sym(var))
  }

  newVarN <- rlang::quo_name(rlang::enquo(newVar))

  # Error checking for newVar
  if(newVarN == ""){stop("Please supply an argument for newVar")}

  # First we have to import the category defintions located in the package directory "data"

  load("data/definitions.rda")

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
