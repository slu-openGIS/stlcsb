# Access to the Open311 API for St Louis City

library(httr)
library(glue)
library(magrittr)

# Defining Endpoints and Arguments

service_list <- function(key = Sys.getenv('csbkey')){
  url = glue::glue('https://www.stlouis-mo.gov/powernap/stlouis/api.cfm/services.json?api_key={key}')
  GET(url) %>%
    content()
}

service_def <- function(service_code, key = Sys.getenv('csbkey')){
  url = glue::glue('https://www.stlouis-mo.gov/powernap/stlouis/api.cfm/services/{service_code}.json?api_key={key}')
  GET(url) %>%
    content()
}

service_req <- function(request_id, key = Sys.getenv('csbkey')){
  url = glue::glue('https://www.stlouis-mo.gov/powernap/stlouis/api.cfm/requests/{request_id}.json?api_key={key}')
  GET(url) %>%
    content()
}

service_reqs <- function(request_id = NULL, service_code = NULL, start_date = NULL, end_date = NULL, status = NULL, key = Sys.getenv('csbkey')){
  url = 'https://www.stlouis-mo.gov/powernap/stlouis/api.cfm/requests.json'
  GET(url,
      query = list(
        service_request_id = request_id,
        service_code = service_code,
        start_date = start_date,
        end_date = end_date,
        status = status,
        api_key = key
      )
  ) %>%
    content()
}
