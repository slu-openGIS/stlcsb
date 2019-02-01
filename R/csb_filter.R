#' Subset Based on Call Categories
#'
#' @description \code{csb_filter} retuns observations that match any combination of the predefined
#'     categories that are created
#'
#' @usage csb_filter(.data, var, category)
#'
#' @param .data A tbl
#' @param var name of the column containg original problem code data
#' @param category a vector with the unquoted name(s) of the category(s) for the function to return.
#'     You can also explicitly state quoted PROBLEMCODE(s). Valid categories are: admin, animal,
#'     construction, debris, degrade, disturbance, event, health, landscape, law, maintenance, nature,
#'     road, sewer, traffic, vacant, and waste.
#'
#' @return \code{csb_filter} returns data with an additional variable for an intelligible category for CSB requests.
#'
#' @importFrom dplyr %>%
#' @importFrom dplyr filter
#' @importFrom rlang :=
#' @importFrom rlang enquo
#' @importFrom rlang quo
#' @importFrom rlang sym
#'
#' @examples
#' csb_filter(january_2018, var = PROBLEMCODE, category = c(cat_waste, cat_debris))
#' csb_filter(january_2018, var = PROBLEMCODE, category = cat_vacant)
#'
#' @export
csb_filter <- function(.data, var, category){

  # check for missing parameters
  if (missing(.data)){
    stop('Please provide an argument for .data')
  }

  if (missing(var)){
    stop('Please provide an argument for var')
  }

  if (missing(category)){
    stop('Please provide an argument for category')
  }

  # save parameters to list
  paramList <- as.list(match.call())

  # quote input variables
  if (!is.character(paramList$var)) {
    varN <- rlang::enquo(var)
  }
  else if (is.character(paramList$var)) {
    varN <- rlang::quo(!! rlang::sym(var))
  }

  # create a list of valid category arguments
  validCategory = c(
    stlcsb::cat_admin,
    stlcsb::cat_animal,
    stlcsb::cat_construction,
    stlcsb::cat_debris,
    stlcsb::cat_degrade,
    stlcsb::cat_disturbance,
    stlcsb::cat_event,
    stlcsb::cat_health,
    stlcsb::cat_landscape,
    stlcsb::cat_law,
    stlcsb::cat_maintenance,
    stlcsb::cat_nature,
    stlcsb::cat_road,
    stlcsb::cat_sewer,
    stlcsb::cat_traffic,
    stlcsb::cat_vacant,
    stlcsb::cat_waste
  )

  # check if category input is valid
  if(!all(category %in% validCategory)){
    stop("Category contains an invalid argument, please see `?csb_filter` for help")
  }

  # filter function
  .data %>%
    filter(!!varN %in% category) -> .data

  # return the final data
  return(.data)

}
