context("test csb_date_parse")

# load test data --------------------------------
data(january_2018, package = "stlcsb")

# test errors -----------------------------------

test_that("Missing input errors triggered", {
  expect_error(csb_date_parse(), "Please provide an argument for .data")
  expect_error(csb_date_parse(january_2018), "Please provide the name of the variable containing the date you want to parse from for 'var'.")
  expect_error(csb_date_parse(january_2018, datetimeinit), "Please provide at least one argument for day, month or year")
  expect_error(csb_date_parse(january_2018, datetimeinit, day = dayinit, drop = "ham"), "Input for the 'drop' argument is invalid - it must be either 'TRUE' or 'FALSE'.")
})

# test for parsing -----------------------------

tstday <- unlist(csb_date_parse(january_2018, datetimeinit, day = DAYINIT)["DAYINIT"])
names(tstday) <- NULL
expday <- c(rep(1, times = 32), rep(2, times = 290),rep(3, times = 357),rep(4, times = 361),rep(5, times = 430),rep(6, times = 33),rep(7, times = 51))

tstmonth <- unlist(csb_date_parse(january_2018, datetimeinit, month = MNTHINIT)["MNTHINIT"])
names(tstmonth) <- NULL
expmonth <- rep(1, times = 1554)

tstyear <- unlist(csb_date_parse(january_2018, datetimeinit, year = YEARINIT)["YEARINIT"])
names(tstyear) <- NULL
expyear <- rep(2018, times = 1554)

test_that("Proper function of parsing", {
  expect_equal(tstday, expday)
  expect_equal(tstmonth, expmonth)
  expect_equal(tstyear, expyear)
})

# test deleting ---------------------------------
tstdel <- csb_date_parse(january_2018, "datetimeinit", day = dayinit, drop = TRUE)

test_that("Deleting the Original Variable works", {
  expect_length(tstdel, 17)
})

# test returning tibble -------------------------
testData <- data.frame(january_2018)
test2 <- csb_date_parse(testData, datetimeinit, day = dayinit)

test_that("Returns Tibble", {
  expect_equal("tbl_df" %in% class(test2), TRUE)
})

# test unquoted and quoted input -----------------------------

test_that("Non-standard Evaluation works", {
  expect_silent(csb_date_parse(january_2018, "datetimeinit", day = "dayinit", month = "monthinit", year = "yearinit"))
  expect_silent(csb_date_parse(january_2018, datetimeinit, day = dayinit, month = monthinit, year = yearinit))
})
