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
#' @import dplyr
#' @importFrom here here
#' @importFrom rlang :=
#' @importFrom rlang quo
#' @importFrom rlang enquo
#' @importFrom rlang sym
#'
#' @export
csb_categorize <- function(.data, var = NULL, newVar = NULL){

  # check for defaults

  if (is.null(var)){
    var <- "PROBLEMCODE"
    message("`var` defaulted to PROBLEMCODE")
  }
  if (is.null(newVar)){
    newVar <- "Category"
    message("`newVar` defaulted to Category")
  }

  # then save parameters to list
  paramList <- as.list(match.call())

  # and quote input variables
  if (!is.character(paramList$var)) {
  var <- rlang::enquo(var)
  }
  else if (is.character(paramList$var)) {
  var <- rlang::quo(!! rlang::sym(var))
  }

  newVarN <- rlang::quo_name(rlang::enquo(newVar))

  # First we have to import the category defintions located in the package directory "data"

  load(here::here("data/definitions.RData"))

  # Then we use a mutate function to assign categories
  .data %>%
  dplyr::mutate(newVarN = dplyr::case_when(
           var %in% Admin ~ "Admin",
           var %in% Animal ~ "Animal",
           var %in% Construction ~ "Construction",
           var %in% Debris ~ "Debris",
           var %in% Degrade ~ "Degrade",
           var %in% Disturbance ~ "Disturbance",
           var %in% Event ~ "Event",
           var %in% Health ~ "Health",
           var %in% Landscape ~ "Landscape",
           var %in% Law ~ "Law",
           var %in% Maintenance ~ "Maintenance",
           var %in% Nature ~ "Nature",
           var %in% Road ~ "Road",
           var %in% Sewer ~ "Sewer",
           var %in% Traffic ~ "Traffic",
           var %in% Waste ~ "Waste")) -> pm

  # return the data again with categories

  return(pm)

}
