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
  ## Note on URL, both "blob" and "raw" URLs work, but I have no idea which one to use or why...
  url <- "https://github.com/slu-openGIS/STL_CSB_RawRequests/raw/master/data/STL_CSB_RawRequests.rda"

  # download and extract data to temp dir

  tmpdir <- tempdir()
  utils::download.file(url, paste0(tmpdir,"RawRequests.rda"))
  data <- paste0(tmpdir,"RawRequests.rda")

  # import the data and return tibble
  load(data)

  tibble <- STL_CSB_RawRequests

  return(tibble)

}
