context("test csb_date_filter")

# load test data --------------------------------
test_data <- read.csv(system.file("extdata", "testdata.csv", package = "stlcsb"), stringsAsFactors = F)

# test errors -----------------------------------

test_that("Missing input errors triggered", {
  expect_error(csb_date_filter(), "Please provide an argument for .data")
  expect_error(csb_date_filter(test_data), "Please provide an argument for var")
  expect_error(csb_date_filter(test_data, DATETIMEINIT), "Please provide at least one argument for day, month or year")
  expect_error(csb_date_filter(test_data, DATETIMEINIT, year = 2007), "The year given is not valid for these data.")
})

# test messaging -------------------------------

test_that("Message about 2008 Soft Launch",{
  expect_message(csb_date_filter(test_data, DATETIMEINIT, year = 2008), "2008 only contains traffic requests")
})

# test filtering ------------------------------
tstdays <- unlist(csb_date_filter(test_data, DATETIMEINIT, day = 8)["DATETIMEINIT"])
tstmonths <- unlist(csb_date_filter(test_data, DATETIMEINIT, month = "April")["DATETIMEINIT"])
tstyears <- unlist(csb_date_filter(test_data, DATETIMEINIT, year = 2010)["DATETIMEINIT"])
tstall <- unlist(csb_date_filter(test_data, DATETIMEINIT, day = 8, month = 01, year = 16)["DATETIMEINIT"])

test_that("Filtering for day", {
  expect_length(tstdays, 2)
})

test_that("Filtering for month", {
  expect_length(tstmonths, 2)
})

test_that("Filtering for year", {
  expect_length(tstyears, 2)
})

test_that("Filtering for all arguments", {
  expect_length(tstall, 1)
})

# test alternate forms of entry-------------------
tstaltMonth <- unlist(csb_date_filter(test_data, "DATETIMEINIT", month = c("jan", "feb", "mar", "may","jun","jul","aug","sep","oct","nov","dec"))["DATETIMEINIT"])

test_that("Month alternate entry works", {
  expect_length(tstaltMonth, 5)
})

# test deleting ---------------------------------
tstdel <- csb_date_filter(test_data, DATETIMEINIT, day = 8, delete = TRUE)

test_that("Deleting the Original Variable works", {
  expect_length(tstdel, 18)
})
