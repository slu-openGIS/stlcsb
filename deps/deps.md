Dependency Analysis
================
Chris
(February 02, 2019)

## Introduction

This notebook explores the dependencies used in the `stlcsb` package:

## Dependencies

This notebook requires the following packages:

``` r
# tidyverse packages
library(dplyr)
```

    ## 
    ## Attaching package: 'dplyr'

    ## The following objects are masked from 'package:stats':
    ## 
    ##     filter, lag

    ## The following objects are masked from 'package:base':
    ## 
    ##     intersect, setdiff, setequal, union

``` r
# other packages
library(itdepends) # install from GitHub
library(knitr)
```

The package `itdepends` will need to be installed from GitHub:

``` r
remotes::install_github("jimhester/itdepends")
```

## Count Dependencies

``` r
dep_usage_pkg("stlcsb") %>%
  count(pkg, sort = TRUE) %>%
  filter(pkg != "stlcsb") %>%
  kable()
```

| pkg       |   n |
| :-------- | --: |
| base      | 830 |
| rlang     |  59 |
| dplyr     |  58 |
| readr     |  12 |
| lubridate |   6 |
| stringr   |   5 |
| utils     |   3 |
| sf        |   2 |
| xml2      |   2 |
| purrr     |   1 |
| readxl    |   1 |
| rvest     |   1 |
