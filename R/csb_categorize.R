#' Categorize Raw CSB Data
#'
#' \code{csb_categorize} provides inteligible categories for the CSB data based on problem code.
#'
#' @usage csb_categorize()
#'
#' @return \code{csb_categorize} returns data with an additional variable for an inteligible category for CSB requests.Depending on the second argument, the function will return only categories specified Default is all.
#'
#'
#'
#' @export
csb_categorize <- function(.data, ...){

  # First we have to import the category defintions.

  load("Definitions.RData")

  # Then we decide what categories we are interested in, and give our second argument. By default, this argument is all.

  z <- c(...)

  if (Admin %in% z) {pm <- dplyr::mutate(.data, Category = Admin) }
  if (Animal %in% z) {pm <- dplyr::mutate(.data, Category = Animal) }
  if (Construction %in% z) {pm <- dplyr::mutate(.data, Category = Construction) }
  if (Debris %in% z) {pm <- dplyr::mutate(.data, Category = Debris) }
  if (Degrade %in% z) {pm <- dplyr::mutate(.data, Category = Degrade) }
  if (Disturbance %in% z) {pm <- dplyr::mutate(.data, Category = Disturbance) }
  if (Event %in% z) {pm <- dplyr::mutate(.data, Category = Event) }
  if (Health %in% z) {pm <- dplyr::mutate(.data, Category = Health) }
  if (Landscape %in% z) {pm <- dplyr::mutate(.data, Category = Landscape) }
  if (Law %in% z) {pm <- dplyr::mutate(.data, Category = Law) }
  if (Maintinence %in% z) {pm <- dplyr::mutate(.data, Category = Maintinence) }
  if (Nature %in% z) {pm <- dplyr::mutate(.data, Category = Nature) }
  if (Road %in% z) {pm <- dplyr::mutate(.data, Category = Road) }
  if (Sewer %in% z) {pm <- dplyr::mutate(.data, Category = Sewer) }
  if (Traffic %in% z) {pm <- dplyr::mutate(.data, Category = Traffic) }
  if (Waste %in% z) {pm <- dplyr::mutate(.data, Category = Waste) }

  # Then we use a mutate function to assign categories

  else if (is.null(z)) {pm <-
    dplyr::mutate(.data,
         Category = case_when(
           PROBLEMCODE %in% Admin ~ "Admin",
           PROBLEMCODE %in% Animal ~ "Animal",
           PROBLEMCODE %in% Construction ~ "Construction",
           PROBLEMCODE %in% Debris ~ "Debris",
           PROBLEMCODE %in% Degrade ~ "Degrade",
           PROBLEMCODE %in% Disturbance ~ "Disturbance",
           PROBLEMCODE %in% Event ~ "Event",
           PROBLEMCODE %in% Health ~ "Health",
           PROBLEMCODE %in% Landscape ~ "Landscape",
           PROBLEMCODE %in% Law ~ "Law",
           PROBLEMCODE %in% Maintinence ~ "Maintinence",
           PROBLEMCODE %in% Nature ~ "Nature",
           PROBLEMCODE %in% Road ~ "Road",
           PROBLEMCODE %in% Sewer ~ "Sewer",
           PROBLEMCODE %in% Traffic ~ "Traffic",
           PROBLEMCODE %in% Waste ~ "Waste")) }



  # return the data again with categories


  return(pm)

}
