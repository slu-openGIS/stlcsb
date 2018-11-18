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
#' @export
csb_filter <- function(.data, var, newVar, category){
#MISSING AND NSE SETUP
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

  paramList <- as.list(match.call())

  if (!is.character(paramList$var)) {
    varN <- rlang::enquo(var)
  }
  else if (is.character(paramList$var)) {
    varN <- rlang::quo(!! rlang::sym(var))
  }

  newVarN <- rlang::quo_name(rlang::enquo(newVar))

  load("R/sysdata.rda")
  #-------------------------------------------------------------------------------------------------------------

  # initialize a list of valid category arguments
  validCategory = c(admin,animal,construction,debris,degrade,disturbance,event,health,landscape,law,maintenance,nature,road,sewer,traffic,vacant,waste)
  # to check if category input is valid
  if(!all(category %in% validCategory)){stop("Category contains an invalid argument, please see `?csb_filter` for help")}

  #-------------------------------------------------------------------------------------------------------------
  # Filter function
.data %>%
  filter(!!varN %in% category) -> .data

  #-------------------------------------------------------------------------------------------------------------
  # categorizing

## categorize data
if(!missing(newVar)){
  csb_categorize(.data, !!varN, !!newVarN) -> .data

  if(all(vacant %in% category)){message("specifying vacant will supersede the original category")
    .data %>% dplyr::mutate(!!newVarN := ifelse(!!varN %in% vacant,"Vacant", .data[[newVarN]])) -> .data
  }
}

# return the final data
return(.data)
}
