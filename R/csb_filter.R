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
#' @export
csb_filter <- function(.data, var, newVar, category = c("admin","animal","construction","debris","degrade","disturbance","event","health","landscape","law","maintenance","nature","road","sewer","traffic","vacant","waste")){

  # FUNCTION DOES NOT CURRENTLY WORK. IN PROGRESS

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
  ### NSE SETUP
  paramList <- as.list(match.call())

  if (!is.character(paramList$var)) {
    varN <- rlang::enquo(var)
  }
  else if (is.character(paramList$var)) {
    varN <- rlang::quo(!! rlang::sym(var))
  }

  newVarN <- rlang::quo_name(rlang::enquo(newVar))

  # be able to filter for multiple categories
  # load the categories used for comparison

  load("data/definitions.rda")
  load("data/vacant.rda")


  if((length(category)) > 1){
    categoryVector <- c()
    for(i in category){categoryVector <- append(categoryVector, i)
    }
    print(categoryVector)
  }

.data %>%
  filter(!!varN %in% categoryVector) -> .data

if ("vacant" %in% categoryVector){message("specifying vacant will supersede ")}
#if(length(category) >1){ USE METHODS FOR ITERATIION
## error checking for length > 1 for var, and newVar NULL
# if(length(!!varN)>1&&newVar == ""){message("You specified multiple categories but did not create a new variable, these data will be ambiguous")}


#if(newVarN != ""){
 # .data %>%     ### It is going to be super innefficient to label and then filter

    ## Run csb_categorize
    ## run mutate for vacacnt (superseding categories as is)



## Example input
# csb_filter(data, c("Degrade", "Waste")) BE Able to use for multiple codes..
# ## Note, all lower case category names!?
# Mutate AND filter
# need to return a data frame for category names
#
#
# Need a Data output for the defined categories. Vacancy included.
#
## NewVar is false, but if true creates an appropriate category label
#

}
