#' Categorize Raw CSB Data
#'
#' @description \code{csb_categorize} provides inteligible categories for the CSB data based on problem code.
#'
#' @usage csb_categorize(.data, code)
#'
#' @param .data A tbl
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

  if (is.null(code)){code = "PROBLEMCODE"}

  #in order for mutate to function, we must have our data in vectors

  Admin <- unlist(Admin)
  Animal <- unlist(Animal)
  Construction <- unlist(Construction)
  Debris <- unlist(Debris)
  Degrade <- unlist(Degrade)
  Disturbance <- unlist(Disturbance)
  Event <- unlist(Event)
  Health <- unlist(Health)
  Landscape <- unlist(Landscape)
  Law <- unlist(Law)
  Maintinence <- unlist(Maintenance)
  Nature <- unlist(Nature)
  Road <- unlist(Road)
  Sewer <- unlist(Sewer)
  Traffic <- unlist(Traffic)
  Waste <- unlist(Waste)

  # Then we use a mutate function to assign categories

  mutate(.data,
         Category = case_when(
           code %in% Admin ~ "Admin",
           code %in% Animal ~ "Animal",
           code %in% Construction ~ "Construction",
           code %in% Debris ~ "Debris",
           code %in% Degrade ~ "Degrade",
           code %in% Disturbance ~ "Disturbance",
           code %in% Event ~ "Event",
           code %in% Health ~ "Health",
           code %in% Landscape ~ "Landscape",
           code %in% Law ~ "Law",
           code %in% Maintenance ~ "Maintenance",
           code %in% Nature ~ "Nature",
           code %in% Road ~ "Road",
           code %in% Sewer ~ "Sewer",
           code %in% Traffic ~ "Traffic",
           code %in% Waste ~ "Waste")) -> pm

  # remove definitons from the Data frame

  rm(Admin, Animal, Construction, Debris, Degrade, Disturbance, Event, Health, Landscape, Law, Maintenance, Nature, Road, Sewer, Traffic, Waste)

  # return the data again with categories

  return(pm)

}
