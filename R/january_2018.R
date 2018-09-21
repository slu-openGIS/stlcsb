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
#'   \item{REQUESTID}{unique request identifier}
#'   \item{PROBLEMCODE}{code of the request}
#'   \item{DESCRIPTION}{description of the request, not significantly different from PROBLEMCODE}
#'   \item{PROBADDRESS}{address of the request}
#'   \item{PROBCITY}{city of the request, note that all these data are for St. Louis}
#'   \item{PROBZIP}{zip code of the request}
#'   \item{PROBADDTYPE}{A or B, undetermined what this means}
#'   \item{SUBMITTO}{department the request was submitted to}
#'   \item{DATETIMEINIT}{date and time the request was recorded}
#'   \item{DATETIMECLOSED}{date and time the request was closed}
#'   \item{SRX}{stateplane meters X-axis}
#'   \item{SRY}{stateplane meters Y-axis}
#'   \item{STATUS}{if the request is open or closed}
#'   \item{PRJCOMPLETEDATE}{date the request was completed}
#'   \item{DATECANCELLED}{date the request was closed}
#'   \item{CALLERTYPE}{unknown, insufficient data}
#'   \item{DATEINVTDONE}{unknown}
#'   \item{NEIGHBORHOOD}{neighborhood of the request}
#'   \item{WARD}{ward of the request}
#'   }
#'
#' @source \href{https://www.stlouis-mo.gov/data/service-requests.cfm}{St. Louis Citizens' Service Bureau}
#'
#' @examples
#' str(january_2018)
#' head(january_2018)
#'
"january_2018"
