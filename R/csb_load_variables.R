#' Load CSB Variable Definitions
#'
#' @description Provides direct access to the CSB's variable definitions, which
#'     are available for download from the City of St. Louis's
#'     \href{https://www.stlouis-mo.gov/data/}{open data} site.
#'
#' @usage csb_load_variables(tidy = TRUE)
#'
#' @param tidy A logical scalar; if \code{TRUE}, variable names will be converted to
#'     lower case and reordered. Two variables with incomplete data - problem city
#'     (\code{PROBCITY}) and problem zip code (\code{PROBZIP}) - are dropped to limit
#'     use of memory. This mirrors the functionality of \link{csb_get_data}.
#'
#' @return A tibble containing variable names and definitions.
#'
#' @seealso \href{https://www.stlouis-mo.gov/data/}{City of St. Louis Open Data},
#'     \href{https://www.stlouis-mo.gov/data/service-requests.cfm}{City of St. Louis CSB Data}
#'
#' @importFrom dplyr %>%
#' @importFrom dplyr filter
#' @importFrom dplyr mutate
#' @importFrom dplyr rename
#' @importFrom dplyr select
#' @importFrom dplyr slice
#' @importFrom readxl read_excel
#'
#' @examples
#' csb_load_variables()
#' csb_load_variables(tidy = FALSE)
#'
#' @export
csb_load_variables <- function(tidy = TRUE){

  # global variables
  `Field/Attribute Name` = `Data Type` = Name = NULL

  # check inputs
  if (is.logical(tidy) == FALSE){
    stop("Input for the 'tidy' argument is invalid - it must be either 'TRUE' or 'FALSE'.")
  }

  # set source variable
  url <- "https://www.stlouis-mo.gov/data/upload/data-files/CSB-Request-Dataset-Field-Definitions.xlsx"
  path <- "/CSB-Request-Dataset-Field-Definitions.xlsx"

  # create temporary directory and download
  tmpdir <- tempdir()
  filepath <- paste0(tmpdir,path)
  utils::download.file(url, filepath, mode="wb")

  # read data
  readxl::read_excel(path = filepath) %>%
    dplyr::rename(Name = `Field/Attribute Name`) %>%
    dplyr::select(-`Data Type`) %>%
    dplyr::filter(Name != "CUSTOMERCALL") -> definitions

  # optionally tidy
  if (tidy == TRUE){

    # rename variables
    definitions <- dplyr::mutate(definitions, Name = tolower(Name))

    # construct output order
    order <- c("requestid", "datetimeinit", "probaddress", "probaddtype", "callertype",
               "neighborhood", "ward", "problemcode", "description", "submitto",
               "status", "dateinvtdone", "datetimeclosed", "prjcompletedate", "datecancelled",
               "srx", "sry")

    # reorder observations
    out <- dplyr::slice(definitions, match(order, Name))

  } else if (tidy == FALSE){

    # construct output order
    order <- c("CALLERTYPE", "DATECANCELLED", "DATEINVTDONE", "DATETIMECLOSED", "DATETIMEINIT",
               "DESCRIPTION", "NEIGHBORHOOD", "PRJCOMPLETEDATE", "PROBADDRESS", "PROBADDTYPE",
               "PROBCITY", "PROBLEMCODE", "PROBZIP", "REQUESTID", "SRX", "SRY", "STATUS", "SUBMITTO",
               "WARD")

    # reorder observations
    out <- dplyr::slice(definitions, match(order, Name))

  }

  # return output
  return(out)

}
