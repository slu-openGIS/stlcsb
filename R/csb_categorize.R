#' Categorize Raw CSB Data
#'
#' @description \code{csb_categorize} provides inteligible categories for the CSB data based on problem code.
#'
#' @usage csb_categorize(.data, code)
#'
#' @param .data A tibble with raw CSB data
#' @param code Name of variable used to define categories
#'
#' @return \code{csb_categorize} returns data with an additional variable for an inteligible category for CSB requests.
#'
#' @importFrom here here
#' @importFrom dplyr mutate
#' @importFrom dplyr case_when
#'
#' @export
csb_categorize <- function(.data, code = NULL){

  # First we have to import the category defintions.

  load(here("data/definitions.RData"))

  # Then we determine if the problemcode was changed from default.

  if (is.null(code)){
    code <- "PROBLEMCODE"
    message("`code` defaulted to PROBLEMCODE")}

  # Then we use a mutate function to assign categories

  mutate(.data,
         Category = case_when(
           paste0( "$", code) %in% Admin ~ "Admin",
           paste0(.data, "$", code) %in% Animal ~ "Animal",
           paste0(.data, "$", code) %in% Construction ~ "Construction",
           paste0(.data, "$", code) %in% Debris ~ "Debris",
           paste0(.data, "$", code) %in% Degrade ~ "Degrade",
           paste0(.data, "$", code) %in% Disturbance ~ "Disturbance",
           paste0(.data, "$", code) %in% Event ~ "Event",
           paste0(.data, "$", code) %in% Health ~ "Health",
           paste0(.data, "$", code) %in% Landscape ~ "Landscape",
           paste0(.data, "$", code) %in% Law ~ "Law",
           paste0(.data, "$", code) %in% Maintenance ~ "Maintenance",
           paste0(.data, "$", code) %in% Nature ~ "Nature",
           paste0(.data, "$", code) %in% Road ~ "Road",
           paste0(.data, "$", code) %in% Sewer ~ "Sewer",
           paste0(.data, "$", code) %in% Traffic ~ "Traffic",
           paste0(.data, "$", code) %in% Waste ~ "Waste")) -> pm

  # return the data again with categories

  return(pm)

}
