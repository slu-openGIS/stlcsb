
<!-- README.md is generated from README.Rmd. Please edit that file -->

# stlcsb

[![lifecycle](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
[![CRAN\_Status\_Badge](http://www.r-pkg.org/badges/version/stlcsb)](https://cran.r-project.org/package=stlcsb)

The goal of `stlcsb` is to provide access to data from the City of
St. Louis [Citizens’ Service
Bureau](https://www.stlouis-mo.gov/government/departments/public-safety/neighborhood-stabilization-office/citizens-service-bureau/index.cfm)
(CSB), which functions as a [3-1-1 like
service](https://en.wikipedia.org/wiki/3-1-1). Residents can contact the
number with non-emergecy service requests, and the CSB will forward
these requests to the appropriate City agency. `stlcsb` also includes
functions for cleaning and manipulating these data.

## Installation

You can install `stlcsb` from GitHub with:

``` r
# install.packages("devtools")
devtools::install_github("slu-openGIS/stlcsb")
```

## Usage

### Downloading Data

The `csb_get_data()` function can be used download our lightly cleaned
and compiled
[version](https://github.com/slu-openGIS/STL_CSB_RawRequests) of the
CSB’s [data
release](https://www.stlouis-mo.gov/data/service-requests.cfm). We have
ensured that the data are formatted in a uniform way and complied the
data together into a single tibble, but have not modified the data
beyond that.

``` r
data <- csb_get_data()
```

The download is quite large - it currently includes *n* = 1,072,382
observations - so it will take a short bit of time depending on your
internet connection.


## Notes on the CSB API

Early development of the package contained functions intended to make working with the API easier. However, at the moment the API has been deemed of low priority. Although we do not beleive it to offer any significant advantages at the moment, it may be revisited in the future.

## Contributor Code of Conduct

Please note that this project is released with a [Contributor Code of
Conduct](CODE_OF_CONDUCT.md). By participating in this project you agree
to abide by its terms.
