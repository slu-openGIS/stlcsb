#' CSB Calls in St. Louis, January 2018
#'
#' A data set containing CSB calls in St. Louis, Missouri during January 2018.
#'
#' @docType data
#'
#' @usage data(january_2018)
#'
#' @format A tibble with 8812 rows and 19 variables:
#' \describe{
#'   \item{REQUESTID}{system generated unique request identifier}
#'   \item{PROBLEMCODE}{type of report}
#'   \item{DESCRIPTION}{same as problemcode OR slightly more specific}
#'   \item{PROBADDRESS}{address of the request}
#'   \item{PROBCITY}{city of the request, note that all these data are for the City of St. Louis}
#'   \item{PROBZIP}{zip code of the request, often blank}
#'   \item{PROBADDTYPE}{A = Parcel, B = Intersection}
#'   \item{SUBMITTO}{city division responsible for completing the request}
#'   \item{DATETIMEINIT}{date and time the request was initiated}
#'   \item{DATETIMECLOSED}{date and time the request was closed}
#'   \item{SRX}{map coordinate, X-coordinate}
#'   \item{SRY}{map coordinate, Y-coordinate}
#'   \item{STATUS}{status of the request}
#'   \item{PRJCOMPLETEDATE}{date by which city division should have initial inspection complete, auto-populated based on service level agreements}
#'   \item{DATECANCELLED}{indicates a duplicate, cancelled or entered in error request}
#'   \item{CALLERTYPE}{method used by citizen to report issue (Phone, Web, Twitter, etc)}
#'   \item{DATEINVTDONE}{date of investigation-date that work was done, may differ from closing date because of crews using paper copies of requests}
#'   \item{NEIGHBORHOOD}{City of St. Louis Neighborhood number (1-79)}
#'   \item{WARD}{City of St. Louis Ward number (1-28)}
#'   }
#'
#' @source \href{https://www.stlouis-mo.gov/data/service-requests.cfm}{St. Louis Citizens' Service Bureau}
#'
#' @examples
#' str(january_2018)
#' head(january_2018)
#'
"january_2018"
