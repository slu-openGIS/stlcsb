#' Download CSB Data
#'
#' \code{csb_get_data} provides direct access to a compiled version of the CSB's data release.
#'
#' @usage csb_get_data()
#'
#' @return \code{csb_get_data} returns a tibble with all of the CSB requests
#'     contained in our version of the CSB's data release.
#'
#' @importFrom dplyr as_tibble bind_rows
#' @importFrom readr read_csv cols col_integer col_character col_double
#'
#' @export
csb_get_data <- function(){

  ## NOTES FOR FUNCTION IMPROVEMENT
  # Supress parsing output in console
  # Investigate parsing failure, I believe it may have to do with zipcode as integer


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

  # create temporary directory, download and unzip data
  tmpdir <- tempdir()
  utils::download.file(url, paste0(tmpdir,"csb.zip"))
  utils::unzip(paste0(tmpdir,"csb.zip"), exdir = tmpdir)

  # read in data

  # NOTE FOR DOCUMENTATION
  # 2008 Data is only for traffic and street requests. (From README file of download)
  y2008 <- readr::read_csv(
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
  ))
  y2009 <- readr::read_csv(
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
  ))
  y2010 <- readr::read_csv(
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
  ))
  y2011 <- readr::read_csv(
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
  ))
  y2012 <- readr::read_csv(
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
  ))
  y2013 <- readr::read_csv(
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
  ))
  y2014 <- readr::read_csv(
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
  ))
  y2015 <- readr::read_csv(
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
  ))
  y2016 <- readr::read_csv(
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
  ))
  y2017 <- readr::read_csv(
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
  ))
  y2018 <- readr::read_csv(
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
  ))

  # remove temp directory and objects
  unlink(tmpdir)
  rm(path1, path2, path3, path4, path5, path6, path7, path8, path9, path10, path11, url)

  # combine data frames
  STL_CSB_RawRequests <- dplyr::as_tibble(dplyr::bind_rows(y2008, y2009, y2010, y2011, y2012, y2013, y2014, y2015, y2016, y2017, y2018))

  return(STL_CSB_RawRequests)


}
