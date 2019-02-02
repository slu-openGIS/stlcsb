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
  kable()
```

| pkg       |   n |
| :-------- | --: |
| base      | 830 |
| rlang     |  59 |
| dplyr     |  58 |
| stlcsb    |  34 |
| readr     |  12 |
| lubridate |   6 |
| stringr   |   5 |
| utils     |   3 |
| sf        |   2 |
| xml2      |   2 |
| purrr     |   1 |
| readxl    |   1 |
| rvest     |   1 |

## Count Functions

``` r
dep_usage_pkg("stlcsb") %>%
  group_by(pkg) %>%
  count(fun, sort = TRUE) %>% 
  kable()
```

| pkg       | fun               |   n |
| :-------- | :---------------- | --: |
| base      | \!                | 118 |
| base      | \<-               | 116 |
| base      | {                 | 113 |
| base      | if                | 100 |
| base      | %in%              |  45 |
| base      | missing           |  42 |
| base      | stop              |  39 |
| base      | \==               |  32 |
| base      | \=                |  26 |
| rlang     | enquo             |  20 |
| base      | ~                 |  19 |
| base      | c                 |  19 |
| base      | is.character      |  19 |
| base      | $                 |  18 |
| dplyr     | %\>%              |  17 |
| base      | append            |  12 |
| base      | return            |  12 |
| rlang     | quo\_name         |  11 |
| rlang     | :=                |  10 |
| dplyr     | mutate            |   9 |
| rlang     | quo               |   9 |
| rlang     | sym               |   9 |
| base      | as.list           |   8 |
| base      | class             |   8 |
| base      | match.call        |   8 |
| dplyr     | as\_tibble        |   8 |
| dplyr     | filter            |   8 |
| base      | \-                |   6 |
| base      | is.logical        |   6 |
| dplyr     | select            |   6 |
| base      | &                 |   5 |
| base      | &&                |   5 |
| base      | paste0            |   5 |
| readr     | col\_character    |   5 |
| base      | \!=               |   4 |
| base      | is.na             |   4 |
| base      | message           |   4 |
| base      | nrow              |   4 |
| dplyr     | rename            |   4 |
| base      | \<                |   3 |
| base      | is.numeric        |   3 |
| readr     | col\_integer      |   3 |
| stringr   | str\_detect       |   3 |
| base      | (                 |   2 |
| base      | |                 |   2 |
| base      | all               |   2 |
| base      | ifelse            |   2 |
| base      | match             |   2 |
| base      | names             |   2 |
| base      | tempdir           |   2 |
| base      | tolower           |   2 |
| dplyr     | case\_when        |   2 |
| dplyr     | slice             |   2 |
| lubridate | day               |   2 |
| lubridate | month             |   2 |
| lubridate | year              |   2 |
| readr     | col\_double       |   2 |
| stlcsb    | cat\_admin        |   2 |
| stlcsb    | cat\_animal       |   2 |
| stlcsb    | cat\_construction |   2 |
| stlcsb    | cat\_debris       |   2 |
| stlcsb    | cat\_degrade      |   2 |
| stlcsb    | cat\_disturbance  |   2 |
| stlcsb    | cat\_event        |   2 |
| stlcsb    | cat\_health       |   2 |
| stlcsb    | cat\_landscape    |   2 |
| stlcsb    | cat\_law          |   2 |
| stlcsb    | cat\_maintenance  |   2 |
| stlcsb    | cat\_nature       |   2 |
| stlcsb    | cat\_road         |   2 |
| stlcsb    | cat\_sewer        |   2 |
| stlcsb    | cat\_traffic      |   2 |
| stlcsb    | cat\_vacant       |   2 |
| stlcsb    | cat\_waste        |   2 |
| utils     | download.file     |   2 |
| base      | \[                |   1 |
| base      | \+                |   1 |
| base      | anyNA             |   1 |
| base      | as.character      |   1 |
| base      | dir               |   1 |
| base      | file.path         |   1 |
| base      | for               |   1 |
| base      | nchar             |   1 |
| base      | suppressWarnings  |   1 |
| base      | unlink            |   1 |
| base      | unlist            |   1 |
| dplyr     | arrange           |   1 |
| dplyr     | bind\_rows        |   1 |
| purrr     | map               |   1 |
| readr     | cols              |   1 |
| readr     | read\_csv         |   1 |
| readxl    | read\_excel       |   1 |
| rvest     | html\_node        |   1 |
| sf        | st\_as\_sf        |   1 |
| sf        | st\_transform     |   1 |
| stringr   | str\_c            |   1 |
| stringr   | str\_extract      |   1 |
| utils     | unzip             |   1 |
| xml2      | read\_html        |   1 |
| xml2      | xml\_text         |   1 |
