#' Download CSB Data from the City of St. Louis
#'
#' \code{csb_get_data} provides direct access to a compiled version of the CSB's
#'     data release.
#'
#' @usage csb_get_data()
#'
#' @return \code{csb_get_data} returns a tibble with all of the CSB requests
#'     contained in our version of the CSB's data release.
#'
#' @importFrom dplyr bind_rows
#' @importFrom readr cols
#' @importFrom readr col_character
#' @importFrom readr col_double
#' @importFrom readr col_integer
#' @importFrom readr read_csv
#' @importFrom xml2 read_html
#' @importFrom xml2 xml_text
#' @importFrom rvest html_node
#' @importFrom stringr str_extract
#' @importFrom tibble as_tibble
#'
#' @examples
#' \dontrun{csb <- csb_get_data()}
#'
#' @export
csb_get_data <- function(){

  #Function for returning date data last modified as message
  website <- xml2::read_html("https://www.stlouis-mo.gov/data/service-requests.cfm")
  message <- rvest::html_node(website, xpath = '//*[@id="CS_CCF_627407_632762"]/ul/li[1]/span[1]')
  messageRegex <- stringr::str_extract(xml2::xml_text(message), "\\d{1,2}/\\d{1,2}/\\d{2}")

  # no visible binding for global variable note
  STL_CSB_RawRequests = NULL

  # set source variables
  # This will need to be updated on an annual basis, if the city continues using the same format
  url <- "https://www.stlouis-mo.gov/data/upload/data-files/csb.zip"
  path1 <- "/2008.csv"
  path2 <- "/2009.csv"
  path3 <- "/2010.csv"
  path4 <- "/2011.csv"
  path5 <- "/2012.csv"
  path6 <- "/2013.csv"
  path7 <- "/2014.csv"
  path8 <- "/2015.csv"
  path9 <- "/2016.csv"
  path10 <- "/2017.csv"
  path11 <- "/2018.csv"
  path12 <- "/2019.csv"

  # create temporary directory, download and unzip data
  tmpdir <- tempdir()
  utils::download.file(url, paste0(tmpdir,"csb.zip"))
  utils::unzip(paste0(tmpdir,"csb.zip"), exdir = tmpdir)


  # read in data

  # NOTE FOR DOCUMENTATION
  # 2008 Data is only for traffic and street requests. (From README file of download)
  suppressWarnings(y2008 <- readr::read_csv(
  paste0(tmpdir,path1),
  col_types = cols(
  PROBZIP = col_integer(),
  DATETIMEINIT = col_character(),
  DATETIMECLOSED = col_character(),
  SRX = col_double(),
  SRY = col_double(),
  PRJCOMPLETEDATE = col_character(),
  DATECANCELLED = col_character(),
  DATEINVTDONE = col_character(),
  NEIGHBORHOOD = col_integer(),
  WARD = col_integer()
  )))
  suppressWarnings(y2009 <- readr::read_csv(
  paste0(tmpdir,path2),
  col_types = cols(
  PROBZIP = col_integer(),
  DATETIMEINIT = col_character(),
  DATETIMECLOSED = col_character(),
  SRX = col_double(),
  SRY = col_double(),
  PRJCOMPLETEDATE = col_character(),
  DATECANCELLED = col_character(),
  DATEINVTDONE = col_character(),
  NEIGHBORHOOD = col_integer(),
  WARD = col_integer()
  )))
  suppressWarnings(y2010 <- readr::read_csv(
  paste0(tmpdir,path3),
  col_types = cols(
  PROBZIP = col_integer(),
  DATETIMEINIT = col_character(),
  DATETIMECLOSED = col_character(),
  SRX = col_double(),
  SRY = col_double(),
  PRJCOMPLETEDATE = col_character(),
  DATECANCELLED = col_character(),
  DATEINVTDONE = col_character(),
  NEIGHBORHOOD = col_integer(),
  WARD = col_integer()
  )))
  suppressWarnings(y2011 <- readr::read_csv(
  paste0(tmpdir,path4),
  col_types = cols(
  PROBZIP = col_integer(),
  DATETIMEINIT = col_character(),
  DATETIMECLOSED = col_character(),
  SRX = col_double(),
  SRY = col_double(),
  PRJCOMPLETEDATE = col_character(),
  DATECANCELLED = col_character(),
  DATEINVTDONE = col_character(),
  NEIGHBORHOOD = col_integer(),
  WARD = col_integer()
  )))
  suppressWarnings(y2012 <- readr::read_csv(
  paste0(tmpdir,path5),
  col_types = cols(
  PROBZIP = col_integer(),
  DATETIMEINIT = col_character(),
  DATETIMECLOSED = col_character(),
  SRX = col_double(),
  SRY = col_double(),
  PRJCOMPLETEDATE = col_character(),
  DATECANCELLED = col_character(),
  DATEINVTDONE = col_character(),
  NEIGHBORHOOD = col_integer(),
  WARD = col_integer()
  )))
  suppressWarnings(y2013 <- readr::read_csv(
  paste0(tmpdir,path6),
  col_types = cols(
  PROBZIP = col_integer(),
  DATETIMEINIT = col_character(),
  DATETIMECLOSED = col_character(),
  SRX = col_double(),
  SRY = col_double(),
  PRJCOMPLETEDATE = col_character(),
  DATECANCELLED = col_character(),
  DATEINVTDONE = col_character(),
  NEIGHBORHOOD = col_integer(),
  WARD = col_integer()
  )))
  suppressWarnings(y2014 <- readr::read_csv(
  paste0(tmpdir,path7),
  col_types = cols(
  PROBZIP = col_integer(),
  DATETIMEINIT = col_character(),
  DATETIMECLOSED = col_character(),
  SRX = col_double(),
  SRY = col_double(),
  PRJCOMPLETEDATE = col_character(),
  DATECANCELLED = col_character(),
  DATEINVTDONE = col_character(),
  NEIGHBORHOOD = col_integer(),
  WARD = col_integer()
  )))
  suppressWarnings(y2015 <- readr::read_csv(
  paste0(tmpdir,path8),
  col_types = cols(
  PROBZIP = col_integer(),
  DATETIMEINIT = col_character(),
  DATETIMECLOSED = col_character(),
  SRX = col_double(),
  SRY = col_double(),
  PRJCOMPLETEDATE = col_character(),
  DATECANCELLED = col_character(),
  DATEINVTDONE = col_character(),
  NEIGHBORHOOD = col_integer(),
  WARD = col_integer()
  )))
  suppressWarnings(y2016 <- readr::read_csv(
  paste0(tmpdir,path9),
  col_types = cols(
  PROBZIP = col_integer(),
  DATETIMEINIT = col_character(),
  DATETIMECLOSED = col_character(),
  SRX = col_double(),
  SRY = col_double(),
  PRJCOMPLETEDATE = col_character(),
  DATECANCELLED = col_character(),
  DATEINVTDONE = col_character(),
  NEIGHBORHOOD = col_integer(),
  WARD = col_integer()
  )))
  suppressWarnings(y2017 <- readr::read_csv(
  paste0(tmpdir,path10),
  col_types = cols(
  PROBZIP = col_integer(),
  DATETIMEINIT = col_character(),
  DATETIMECLOSED = col_character(),
  SRX = col_double(),
  SRY = col_double(),
  PRJCOMPLETEDATE = col_character(),
  DATECANCELLED = col_character(),
  DATEINVTDONE = col_character(),
  NEIGHBORHOOD = col_integer(),
  WARD = col_integer()
  )))
  suppressWarnings(y2018 <- readr::read_csv(
  paste0(tmpdir,path11),
  col_types = cols(
  PROBZIP = col_integer(),
  DATETIMEINIT = col_character(),
  DATETIMECLOSED = col_character(),
  SRX = col_double(),
  SRY = col_double(),
  PRJCOMPLETEDATE = col_character(),
  DATECANCELLED = col_character(),
  DATEINVTDONE = col_character(),
  NEIGHBORHOOD = col_integer(),
  WARD = col_integer()
  )))
  suppressWarnings(y2019 <- readr::read_csv(
    paste0(tmpdir,path12),
    col_types = cols(
      PROBZIP = col_integer(),
      DATETIMEINIT = col_character(),
      DATETIMECLOSED = col_character(),
      SRX = col_double(),
      SRY = col_double(),
      PRJCOMPLETEDATE = col_character(),
      DATECANCELLED = col_character(),
      DATEINVTDONE = col_character(),
      NEIGHBORHOOD = col_integer(),
      WARD = col_integer()
    )))

  # remove temp directory and objects
  unlink(tmpdir)
  rm(path1, path2, path3, path4, path5, path6, path7, path8, path9, path10, path11, path12, url)

  # combine data frames
  STL_CSB_RawRequests <- dplyr::as_tibble(dplyr::bind_rows(y2008, y2009, y2010, y2011, y2012, y2013, y2014, y2015, y2016, y2017, y2018, y2019))

  message(paste0("Data Last Modified ", messageRegex))
  return(STL_CSB_RawRequests)

}
