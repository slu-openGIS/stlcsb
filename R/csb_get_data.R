#' Download CSB data compliation
#'
#' @description The CSB's raw data are available from the City of St. Louis's website but have some
#' slight inconsistencies between the different files. They also lack stable names. For this reason,
#' we hae a compilation of their data releases in a single \code{.rda} file. This function downloads
#' and loads our compilation file.
#'
#' @return A tibble with the contents of our compliation of the City's data releases.
#'
#' @importFrom utils download.file
#' @importFrom utils unzip
#'
#' @export
csb_get_data <- function() {

  url <- "https://github.com/slu-openGIS/STL_CSB_RawRequests/archive/master.zip"
  path <- "/STL_CSB_RawRequests-master/data/STL_CSB_RawRequests.rda"

  tmpdir <- tempdir()
  utils::download.file(url, paste0(tmpdir,"master.zip"))
  utils::unzip(paste0(tmpdir,"master.zip"), exdir = tmpdir)
  data <- paste0(tmpdir,path)

  load(file = data)
  unlink(tmpdir)

  return(STL_CSB_RawRequests)
}
