#' Filter CSB Data
#'
#' @description \code{csb_filter} retuns observations that match any combination of 17 predefined categories.
#'
#' @usage csb_filter(.data, var, newVar, category)
#'
#' @param .data A tibble with raw CSB data
#' @param var name of the column containg original problem code data
#' @param newVar name of column containing categories. NULL by default, but if specified will produce a new column.
#' @param category a vector with the unquoted name(s) of the category(s) for the function to return. You can also explicitly state quoted PROBLEMCODE(s). Valid categories are: (admin, animal, construction, debris, degrade, disturbance, event, health, landscape, law, maintenance, nature, road, sewer, traffic, vacant, waste)
#'
#' @return \code{csb_filter} returns data with an additional variable for an intelligible category for CSB requests.
#'
#' @importFrom dplyr filter
#' @importFrom rlang quo enquo sym :=
#' @importFrom magrittr %>%
#'
#' @examples
#' csb_filter(january_2018, PROBLEMCODE, Category, category = c(cat_waste, cat_debris))
#' csb_filter(january_2018, PROBLEMCODE, category = cat_vacant)
#'
#' @export
csb_filter <- function(.data, var, newVar, category){

  # check for missing parameters
  if (missing(.data)){
    stop('Please provide an argument for .data')
  }

  if (missing(var)){
    stop('Please provide an argument for var')
  }

  if (missing(newVar)){
    message("No argument set for `newVar` If you would like to append a category variable, please set an argument for `newVar`")
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

  newVarN <- rlang::quo_name(rlang::enquo(newVar))

  # initialize a list of valid category arguments
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

  # to check if category input is valid
  if(!all(category %in% validCategory)){
    stop("Category contains an invalid argument, please see `?csb_filter` for help")
  }

  # Filter function
  .data <- filter(.data, !!varN %in% category)

  # categorize data
  if(!missing(newVar)){

    .data <- csb_categorize(.data, !!varN, !!newVarN)

  }

  if(all(stlcsb::cat_vacant %in% category)){
    message("specifying vacant will supersede the original category")

    .data <- dplyr::mutate(.data, !!newVarN := ifelse(!!varN %in% stlcsb::cat_vacant,"Vacant", .data[[newVarN]]))
  }

  # return the final data
  return(.data)

}
