context("test csb_date_parse")

# load test data --------------------------------
test_data <- read.csv(system.file("extdata", "testdata.csv", package = "stlcsb"), stringsAsFactors = F)

# test errors -----------------------------------

test_that("Missing input errors triggered", {
  expect_error(csb_date_parse(), "Please provide an argument for .data")
  expect_error(csb_date_parse(test_data), "Please provide an argument for var")
  expect_error(csb_date_parse(test_data, DATETIMEINIT), "Please provide at least one argument for day, month or year")
})

# test for parsing -----------------------------

tstday <- unlist(csb_date_parse(test_data, DATETIMEINIT, day = DAYINIT)["DAYINIT"])
names(tstday) <- NULL
expday <- c(8, 27, 18, 25, 19, 8 ,22)

tstmonth <- unlist(csb_date_parse(test_data, DATETIMEINIT, month = MNTHINIT)["MNTHINIT"])
names(tstmonth) <- NULL
expmonth <- c(1, 5, 4, 4, 7, 9, 1)

tstyear <- unlist(csb_date_parse(test_data, DATETIMEINIT, year = YEARINIT)["YEARINIT"])
names(tstyear) <- NULL
expyear <- c(2016, 2010, 2011, 2014, 2010, 2008, 2018)

test_that("Proper function of parsing", {
  expect_equal(tstday, expday)
  expect_equal(tstmonth, expmonth)
  expect_equal(tstyear, expyear)
})

# test deleting ---------------------------------
tstdel <- csb_date_parse(test_data, "DATETIMEINIT", day = DAYINIT, delete = TRUE)

test_that("Deleting the Original Variable works", {
  expect_length(tstdel, 19)
})
