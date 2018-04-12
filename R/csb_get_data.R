#' Download Processed CSB Data
#'
#' \code{csb_get_data} provides access to our lightly cleaned and compiled version of the CSB's data release.
#'
#' @usage csb_get_data()
#'
#' @return \code{csb_get_data} returns a tibble with all of the CSB requests
#'     contained in our version of the CSB's data release.
#'
#' @export
csb_get_data <- function(){

  # no visible binding for global variable note
  STL_CSB_RawRequests = NULL

  # specify download path
  url <- "https://github.com/slu-openGIS/STL_CSB_RawRequests/archive/master.zip"
  path <- "/STL_CSB_RawRequests-master/data/STL_CSB_RawRequests.rda"

  # download and extract data to temp dir
  tmpdir <- tempdir()
  utils::download.file(url, paste0(tmpdir,"master.zip"))
  utils::unzip(paste0(tmpdir,"master.zip"), exdir = tmpdir)
  data <- paste0(tmpdir,path)

  # import the data and return tibble
  load(data)

  tibble <- STL_CSB_RawRequests

  return(tibble)

}
