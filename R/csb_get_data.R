#' Download CSB Data from the City of St. Louis
#'
#' @description \code{csb_get_data} provides direct access to a compiled version
#'     of the CSB's data release via the City of St. Louis website. These data are
#'     provided with no warranty from either the City of St. Louis or the package
#'     developers.
#'
#' @usage csb_get_data(tidy = TRUE, years, ...)
#'
#' @param tidy A logical scalar; if \code{TRUE}, variable names will be converted to
#'     lower case and reordered. Two variables with incomplete data - problem city
#'     (\code{PROBCITY}) and problem zip code (\code{PROBZIP}) - are dropped to limit
#'     use of memory. This mirrors the functionality of \link{csb_load_variables}.
#' @param years Optional; if included, data not in the specified years will be excluded
#'     from the returned object.
#' @param ... Additional testing options; not for production use
#'
#' @return Returns a tibble with all CSB calls for service.
#'
#' @importFrom dplyr %>%
#' @importFrom dplyr arrange
#' @importFrom dplyr bind_rows
#' @importFrom dplyr select
#' @importFrom purrr map
#' @importFrom readr cols
#' @importFrom readr col_character
#' @importFrom readr col_double
#' @importFrom readr col_integer
#' @importFrom readr read_csv
#' @importFrom stringr str_c
#'
#' @examples
#' \dontrun{
#' csb <- csb_get_data()
#' csb <- csb_get_data(tidy = FALSE)
#' csb <- csb_get_data(years = 2009:2018)
#' csb <- csb_get_data(years = 2018)
#' }
#'
#' @export
csb_get_data <- function(tidy = TRUE, years, ...){

  # set gobal variables
  DATETIMEINIT = callertype = datecancelled = dateinvtdone = datetimeclosed =
    datetimeinit = description = neighborhood = prjcompletedate = probaddress =
    probaddtype = probcity = problemcode = probzip = requestid = status = submitto =
    ward = srx = sry = NULL

  # check inputs
  if (is.logical(tidy) == FALSE){
    stop("Input for the 'tidy' argument is invalid - it must be either 'TRUE' or 'FALSE'.")
  }

  if (missing(years) == FALSE){
    if (is.numeric(years) == FALSE){
      stop("Input for the 'years' argument is invalid - it must be a numeric scalar or vector.")
    }
  }

  # set source variable
  url <- "https://www.stlouis-mo.gov/data/upload/data-files/csb.zip"

  # create temporary directory, download and unzip data
  tmpdir <- tempdir()
  utils::download.file(url, paste0(tmpdir,"csb.zip"), mode="wb")
  utils::unzip(paste0(tmpdir,"csb.zip"), exdir = tmpdir)

  # create list of all files at path that are csv
  files <- dir(path = tmpdir, pattern = "*.csv")

  # optionally create list of years to import
  if (missing(years) == FALSE){

    # create vector of year files
    years <- stringr::str_c(as.character(years), ".csv")

    # logic test
    if (all(years %in% files) == FALSE){
      stop("One or more of the years specified are not currently included in CSB data releases.")
    }

    # replace file list with year list
    files <- years

  }

  # read in files
  files %>%
    purrr::map(~ suppressWarnings(readr::read_csv(file = file.path(tmpdir, .),
                                                  col_types = readr::cols(
                                                    PROBZIP = col_integer(),
                                                    DATETIMEINIT = col_character(),
                                                    DATETIMECLOSED = col_character(),
                                                    SRX = col_double(),
                                                    SRY = col_double(),
                                                    PRJCOMPLETEDATE = col_character(),
                                                    DATECANCELLED = col_character(),
                                                    DATEINVTDONE = col_character(),
                                                    NEIGHBORHOOD = col_integer(),
                                                    WARD = col_integer())
                                                  ))) %>%
    dplyr::bind_rows() %>%
    dplyr::arrange(DATETIMEINIT) -> out

  # remove temp directory
  unlink(tmpdir)

  # optionally tidy variable names
  if (tidy == TRUE){

    names(out) <- tolower(names(out))

    out %>%
      dplyr::select(-c(probcity, probzip)) %>%
      dplyr::select(requestid, datetimeinit, probaddress, probaddtype, callertype, neighborhood, ward,
                    problemcode, description, submitto, status, dateinvtdone, datetimeclosed,
                    prjcompletedate, datecancelled, srx, sry) -> out

  }

  # return output
  return(out)

}
