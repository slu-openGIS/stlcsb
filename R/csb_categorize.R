#' Categorize Raw CSB Data
#'
#' @description \code{csb_categorize} provides intelligible categories for the CSB data based on problem code.
#'
#' @usage csb_categorize(.data, code)
#'
#' @param .data A tibble with raw CSB data
#' @param code Name of variable used to define categories
#'
#' @return \code{csb_categorize} returns data with an additional variable for an intelligible category for CSB requests.
#'
#' @importFrom here here
#' @importFrom dplyr mutate
#' @importFrom dplyr case_when
#' @importFrom rlang :=
#' @importFrom rlang quo
#' @importFrom rlang enquo
#' @importFrom rlang sym
#'
#' @export
csb_categorize <- function(.data, code = NULL){

  # save parameters to list
  paramList <- as.list(match.call())

  #quote input variables (NOT DEBUGGED!)
  ## dont run if (!is.character(paramList$code)) {
  ##  code <- rlang::enquo(code)
 ## } else if (is.character(paramList$code)) {
  ##   code <- rlang::quo(!! rlang::sym(code))
  ## }

 ## code <- rlang::quo_name(rlang::enquo(code))

  # First we have to import the category defintions located in the package directory "data"

  load(here("data/definitions.RData"))

  # Then we determine if the problemcode was changed from default.

  if (is.null(code)){
    code <- "PROBLEMCODE"
    message("`code` defaulted to PROBLEMCODE")}

  # Then we use a mutate function to assign categories

  mutate(.data,
         Category = case_when(
           .data[[code]] %in% Admin ~ "Admin",
           .data[[code]] %in% Animal ~ "Animal",
           .data[[code]] %in% Construction ~ "Construction",
           .data[[code]] %in% Debris ~ "Debris",
           .data[[code]] %in% Degrade ~ "Degrade",
           .data[[code]] %in% Disturbance ~ "Disturbance",
           .data[[code]] %in% Event ~ "Event",
           .data[[code]] %in% Health ~ "Health",
           .data[[code]] %in% Landscape ~ "Landscape",
           .data[[code]] %in% Law ~ "Law",
           .data[[code]] %in% Maintenance ~ "Maintenance",
           .data[[code]] %in% Nature ~ "Nature",
           .data[[code]] %in% Road ~ "Road",
           .data[[code]] %in% Sewer ~ "Sewer",
           .data[[code]] %in% Traffic ~ "Traffic",
           .data[[code]] %in% Waste ~ "Waste")) -> pm

  # return the data again with categories

  return(pm)

}
