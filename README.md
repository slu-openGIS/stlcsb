
<!-- README.md is generated from README.Rmd. Please edit that file -->

# stlcsb

[![lifecycle](https://img.shields.io/badge/lifecycle-maturing-blue.svg)](https://www.tidyverse.org/lifecycle/#maturing)
[![CRAN\_Status\_Badge](http://www.r-pkg.org/badges/version/stlcsb)](https://cran.r-project.org/package=stlcsb)

The goal of `stlcsb` is to provide access to data from the City of St. Louis [Citizens’ Service Bureau](https://www.stlouis-mo.gov/government/departments/public-safety/neighborhood-stabilization-office/citizens-service-bureau/index.cfm) (CSB), the [3-1-1 service](https://en.wikipedia.org/wiki/3-1-1) for the City of Saint Louis.

Residents can contact the number with non-emergency service requests, and the CSB will dispatch these requests to the appropriate City agency.

`stlcsb` also includes functions for cleaning and manipulating these data.

## Installation

You can install `stlcsb` from GitHub with:

``` r
# install.packages("devtools")
devtools::install_github("slu-openGIS/stlcsb")
```

## Usage

### Downloading Data

The `csb_get_data()` function can be used download a
compiled version of the
CSB data. We have
ensured that the data are formatted in a uniform way and complied the
data together into a single tibble, but have not modified the data
beyond that.

``` r
data <- csb_get_data()
```

The download is quite large - (Approx. 60 MB) and currently includes > 1,100,000
observations - so it will take a short bit of time depending on your
internet connection.

### Functions for Data Manipulation

The functions in this package address 3 mains concerns with the raw data.

1. The original data are hard to categorize.

2. The spatial variables can be messy.

3. There are several time and date variables.


To learn everything this package has to offer, please see the vignette:

```r
vignette("stlcsb")
```

## Notes on the CSB API

Early development of the package contained functions intended to make working with the API easier. However, at the moment the API has been deemed of low priority. Although we do not believe it to offer any significant advantages at the moment, it may be revisited in the future.

## Contributor Code of Conduct

Please note that this project is released with a [Contributor Code of
Conduct](.github/CODE_OF_CONDUCT.md). By participating in this project you agree
to abide by its terms.
