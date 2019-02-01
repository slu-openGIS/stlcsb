#' Download CSB Data from the City of St. Louis
#'
#' \code{csb_get_data} provides direct access to a compiled version of the CSB's
#'     data release via the City of St. Louis website. These data are provided with
#'     no warrenty from either the City of St. Louis or the package developers.
#'
#' @usage csb_get_data(tidy = TRUE, years, ...)
#'
#' @param tidy A logical scalar; if \code{TRUE}, variable names will be converted to
#'     lower case and reordered. Two variables with incomplete data - problem city
#'     (\code{PROBCITY}) and problem zip code (\code{PROBZIP}) are dropped to limit
#'     use of memory along with a third, the problem address type (\code{PROBADDTYPE}).
#' @param years Optional; if included, data not in the specified years will be excluded
#'     from the returned object.
#' @param ... Additional testing options; not for production use
#'
#' @return Returns a tibble with all CSB calls for service.
#'
#' @importFrom dplyr arrange
#' @importFrom dplyr bind_rows
#' @importFrom dplyr everything
#' @importFrom dplyr select
#' @importFrom purrr map
#' @importFrom readr cols
#' @importFrom readr col_character
#' @importFrom readr col_double
#' @importFrom readr col_integer
#' @importFrom readr read_csv
#' @importFrom xml2 read_html
#' @importFrom xml2 xml_text
#' @importFrom rvest html_node
#' @importFrom stringr str_c
#' @importFrom stringr str_extract
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
    ward = NULL

  # create date last modified string
  website <- xml2::read_html("https://www.stlouis-mo.gov/data/service-requests.cfm")
  message <- rvest::html_node(website, xpath = '//*[@id="CS_CCF_627407_632762"]/ul/li[1]/span[1]')
  messageRegex <- stringr::str_extract(xml2::xml_text(message), "\\d{1,2}/\\d{1,2}/\\d{2}")

  # set source variable
  url <- "https://www.stlouis-mo.gov/data/upload/data-files/csb.zip"

  # create temporary directory, download and unzip data
  tmpdir <- tempdir()
  utils::download.file(url, paste0(tmpdir,"csb.zip"))
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
      dplyr::select(-c(probaddtype, probcity, probzip)) %>%
      dplyr::select(requestid, datetimeinit, probaddress, callertype, neighborhood, ward, problemcode,
                    description, submitto, status, dateinvtdone, datetimeclosed, prjcompletedate,
                    datecancelled, dplyr::everything()) -> out

  }

  # return output
  message(paste0("Data Last Modified: ", messageRegex))
  return(out)

}
