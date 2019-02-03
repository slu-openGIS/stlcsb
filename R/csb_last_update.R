#' Date of Last CSB Data Update from the City of St. Louis
#'
#' @description Data are updated by the City of St. Louis on their
#'     \href{https://www.stlouis-mo.gov/data/}{open data} site on a
#'     weekly basis. This function returns the date of the last
#'     update.
#'
#' @return A string scalar containing the date of last update.
#'
#' @importFrom xml2 read_html
#' @importFrom xml2 xml_text
#' @importFrom rvest html_node
#' @importFrom stringr str_extract
#'
#' @examples
#' \dontrun{
#' last_update <- csb_last_update()
#' }
#' @export
csb_last_update <- function(){

  # create date last modified string
  website <- xml2::read_html("https://www.stlouis-mo.gov/data/service-requests.cfm")
  message <- rvest::html_node(website, xpath = '//*[@id="CS_CCF_627407_632762"]/ul/li[1]/span[1]')
  out <- stringr::str_extract(xml2::xml_text(message), "\\d{1,2}/\\d{1,2}/\\d{2}")

  # return output
  return(out)

}
