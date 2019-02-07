context("test csb_date_filter")

# load test data --------------------------------
data(january_2018, package = "stlcsb")

# test errors -----------------------------------

test_that("Missing input errors triggered", {
  expect_error(csb_date_filter(), "Please provide an argument for .data")
  expect_error(csb_date_filter(january_2018), "Please provide the name of the variable containing the date you want to filter from for 'var'.")
  expect_error(csb_date_filter(january_2018, datetimeinit), "Please provide at least one argument for day, month or year")
  expect_error(csb_date_filter(january_2018, datetimeinit, year = 2007), "The year given is not valid for these data.")
  expect_error(csb_date_filter(january_2018, datetimeinit, month = "janu"), "An invalid argument for 'month' has been specified.")
  expect_error(csb_date_filter(january_2018, datetimeinit, month = 13), "An invalid argument for 'month' has been specified.")
})

# test messaging -------------------------------

test_that("Message about 2008 Soft Launch",{
  expect_message(csb_date_filter(january_2018, datetimeinit, year = 2008), "2008 only contains traffic requests")
})

# test filtering ------------------------------
tstdays <- unlist(csb_date_filter(january_2018, datetimeinit, day = 6)["datetimeinit"])
tstmonths <- unlist(csb_date_filter(january_2018, datetimeinit, month = 1)["datetimeinit"])
tstyears <- unlist(csb_date_filter(january_2018, datetimeinit, year = 2018)["datetimeinit"])
tstall <- unlist(csb_date_filter(january_2018, datetimeinit, day = 1, month = 01, year = 2018)["datetimeinit"])

test_that("Filtering for day", {
  expect_length(tstdays, 33)
})

test_that("Filtering for month", {
  expect_length(tstmonths, 1554)
})

test_that("Filtering for year", {
  expect_length(tstyears, 1554)
})

test_that("Filtering for all arguments", {
  expect_length(tstall, 32)
})

# test alternate forms of entry-------------------
tstaltMonth <- unlist(csb_date_filter(january_2018, "datetimeinit", month = c("jan", "feb", "mar", "may","jun","jul","aug","sep","oct","nov","dec"))["datetimeinit"])
tstaltMonth2 <- unlist(csb_date_filter(january_2018, "datetimeinit", month = c("January", "February", "March", "May","June","July","August","September","October","November","December"))["datetimeinit"])
tstaltYear <- unlist(csb_date_filter(january_2018, "datetimeinit", year = 18)["datetimeinit"])

test_that("Month alternate entry works", {
  expect_length(tstaltMonth, 1554)
  expect_length(tstaltMonth2, 1554)
})
test_that("Year alternate entry works", {
  expect_length(tstaltYear, 1554)
})

# test returning tibble -------------------------
testData <- data.frame(january_2018)
test2 <- csb_date_filter(testData, datetimeinit, year = 18)

test_that("Returns Tibble", {
  expect_equal("tbl_df" %in% class(test2), TRUE)
})

# test unquoted and quoted input -----------------------------

test_that("Non-standard Evaluation works", {
  expect_silent(csb_date_filter(january_2018, "datetimeinit", month = 1))
  expect_silent(csb_date_filter(january_2018, datetimeinit, month = 1))
})


# test that logical arguments greater than length one pass --------

test_that("Logical arguments of length > 1 Pass", {
  expect_silent(csb_date_filter(january_2018, datetimeinit, day = 1:15, month = 1:6, year = 09:14))
})
