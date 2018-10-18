#' Filter CSB Data
#'
#' @description \code{csb_filter} retuns observations that match one of 16 predefined categories.
#'
#' @usage csb_filter(.data, ...)
#'
#' @param .data A tibble with raw CSB data
#' @param var values of the categories for the function to return. A list of these categories can be
#' @param newVar name of column containing categories. NULL by default, but if specified will produce a new column.

#' @return \code{csb_filter} returns data with an additional variable for an intelligible category for CSB requests.
#'
#' @importFrom dplyr filter
#' @importFrom here here
#' @importFrom rlang :=
#' @importFrom rlang quo
#' @importFrom rlang enquo
#' @importFrom rlang sym
#'
#' @export
csb_filter <- function(.data, var, newVar = NULL){

  # load the categories used for comparison

  load(("data/definitions.RData"))


if (is.null(newVar)){message("No argument set for `newVar` If you would like to append a category variable, please set an argument for `newVar`")
.data %>%
  filter()


}
else {
  .data %>%
  mutate()
  }

}

## Example input
# csb_filter(data, c("Degrade", "Waste"))
# ## Note, all lower case category names!?
# Mutate AND filter
# need to return a data frame for category names
#
#
#
#
#
