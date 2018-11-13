#' Filter CSB Data
#'
#' @description \code{csb_filter} retuns observations that match one of 17 predefined categories.
#'
#' @usage csb_filter(.data, ...)
#'
#' @param .data A tibble with raw CSB data
#' @param var where the original problem code is located in the data
#' @param newVar name of column containing categories. NULL by default, but if specified will produce a new column.
#' @param category name(s) of the category(s) for the function to return. A list of these categories can be found in the documentation

#' @return \code{csb_filter} returns data with an additional variable for an intelligible category for CSB requests.
#'
#' @importFrom dplyr filter
#' @importFrom rlang quo enquo sym :=
#' @importFrom magrittr %>%
#'
#'
#' @export
csb_filter <- function(.data, var, newVar, category = c(admin,animal,construction,debris,degrade,disturbance,event,health,landscape,law,maintenance,nature,road,sewer,traffic,vacant,waste)){

  # FUNCTION DOES NOT CURRENTLY WORK. IN PROGRESS
  #-------------------------------------------------------------------------------------------------------------
  ### Check input and Non-Standard evaluation
  ## check for missing parameters
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
  ### NSE SETUP
  paramList <- as.list(match.call())

  if (!is.character(paramList$var)) {
    varN <- rlang::enquo(var)
  }
  else if (is.character(paramList$var)) {
    varN <- rlang::quo(!! rlang::sym(var))
  }

  newVarN <- rlang::quo_name(rlang::enquo(newVar))


  #-------------------------------------------------------------------------------------------------------------

  ## Checking for valid input of category argument
  if(is.character(paramList$category)){}
  print(length(paramList$category))
  print(enquos(category))
  enquos(category) -> testCat
 # print(head(eval(paramList$category))) # i will need this for checking that arguments are unquoted and that the arguments specified are in


  # initialize a list of valid category arguments
  validCategory = c(admin,animal,construction,debris,degrade,disturbance,event,health,landscape,law,maintenance,nature,road,sewer,traffic,vacant,waste)
  if(!all(category %in% validCategory)){stop("Category contains an invalid argument, please see `?csb_filter` for help")}
#  if(all(eval(paramList$category) %in% validCategory))

  #{stop("Category contains an invalid argument, please see `?csb_filter` for help")}

  #user inputs: c("admin","vacant","debris")
  # or c(admin, vacant, debris)
  # or admin
  # or vacant

  # check for length > 1 and if newVar is missing (ambiguous filter)

  # check that all specified categoires are valid (in valid list)

  # check that vacant is specified



  # load the categories used for comparison

  load("data/definitions.rda")
  load("data/vacant.rda")


  if((length(category)) > 1){
    categoryVector <- c()
    for(i in category){categoryVector <- append(categoryVector, i)
    }
    ###print(categoryVector)
  }
  #-------------------------------------------------------------------------------------------------------------
  # Filter function
.data %>%
  filter(!!varN %in% categoryVector) -> .data


# if (vacant %in% categoryVector){}

## error checking for length > 1 for var, and newVar NULL
# if(length(!!varN)>1&&newVar == ""){message("You specified multiple categories but did not create a new variable, these data will be ambiguous")}





## Example input
# csb_filter(data, c("Degrade", "Waste")) BE Able to use for multiple codes..
# ## Note, all lower case category names!?
# Mutate AND filter
# need to return a data frame for category names
#
#
# Need a Data output for the defined categories. Vacancy included.
#
#-------------------------------------------------------------------------------------------------------------
  # categorizing

## categorize data
if(!missing(newVar)){
  csb_categorize(.data, !!varN, !!newVarN) -> .data
}

if(all(vacant %in% category)){message("specifying vacant will supersede the original category")
  .data %>% dplyr::mutate(!!newVarN := ifelse(!!varN %in% vacant,"Vacant", .data[[newVar]])) -> .data
}
  # with current methods, vacant could provide an error, in the case that everything is specified which contains problemcodes for vacant...
  # possible to isolate..

# return the final data
return(.data)
}
