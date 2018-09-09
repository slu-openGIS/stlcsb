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
           var %in% as.vector(Admin) ~ "Admin",
           var %in% as.vector(Animal) ~ "Animal",
           var %in% as.vector(Construction) ~ "Construction",
           var %in% as.vector(Debris) ~ "Debris",
           var %in% as.vector(Degrade) ~ "Degrade",
           var %in% as.vector(Disturbance) ~ "Disturbance",
           var %in% as.vector(Event) ~ "Event",
           var %in% as.vector(Health) ~ "Health",
           var %in% as.vector(Landscape) ~ "Landscape",
           var %in% as.vector(Law) ~ "Law",
           var %in% as.vector(Maintenance) ~ "Maintenance",
           var %in% as.vector(Nature) ~ "Nature",
           var %in% as.vector(Road) ~ "Road",
           var %in% as.vector(Sewer) ~ "Sewer",
           var %in% as.vector(Traffic) ~ "Traffic",
           var %in% as.vector(Waste) ~ "Waste")) -> pm

  # return the data again with categories

  return(pm)

}
