#' CSB API Requests
#'
#' @description \code{csb_api_requests} can be used to access API data for requests reported to the CSB by using the unique request ID. It requires that the user have an API key stored using the \code{csb_api_key} function.
#' @usage csb_api_requests(requestID)
#' @param requestID a vector containing the unique requestID number of each CSB call.
#'
#' @importFrom httr GET
#' @importFrom jsonlite fromJSON
#' @importFrom purrr map
#'
#' @export
csb_api_requests <- function(requestID, key = NULL){

  # Check for an existing CSB api key

  if (Sys.getenv('CSB_API_KEY') != '') {

    key <- Sys.getenv('CSB_API_KEY')

  } else if (is.null(key)) {

    stop('Error: CSB API key is required.  Obtain one at https://www.stlouis-mo.gov/government/departments/information-technology/web-development/city-api/sign-up.cfm, and then supply the key to the `csb_api_key` function to use it throughout your session.')

  }
  # CSB api setup
  base <- "https://www.stlouis-mo.gov/powernap/stlouis/api.cfm/requests/"
  json <- ".json?api_key="

  ##call <- paste0(base,requestID,json,key)

  ##z <- GET(call)

 ## get_address_text <- content(z, "text")
  ## get_address_json <- fromJSON(get_address_text, flatten = TRUE)

  # Using map to iterate multiple requests. (Faster than loop or lapply...)
  #setup function for map()
  #mf <- function(){jsonlite::fromJSON(paste0(base, requestID, json, key))}

  map(requestID, ~jsonlite::fromJSON(paste0(base, requestID, json, key))) ->q

  return(q)
}
