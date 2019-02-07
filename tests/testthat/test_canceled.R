context("test csb_cancelled")

# load test data --------------------------------

data(january_2018, package = "stlcsb")

# test errors -----------------------------------

test_that("Missing input errors triggered", {
  expect_error(csb_canceled(),
               "Please provide an argument for .data")
  expect_error(csb_canceled(var = "datecancelled"),
               "Please provide an argument for .data")
  expect_error(csb_canceled(january_2018),
               "Please provide the name of the variable containing the cancellation timestamps.")
})

test_that("Logical input type errors triggered", {
  expect_error(csb_canceled(january_2018, var = "datecancelled", drop = "ham"),
               "Input for the 'drop' argument is invalid - it must be either 'TRUE' or 'FALSE'.")
})

# test results ------------------------------------------------

test1 <- csb_canceled(january_2018, var = datecancelled)

test_that("data are dropped appropriately", {
  expect_equal(nrow(test1), 1515)
  expect_equal(ncol(test1), 16)
})

testData <- data.frame(january_2018)
test2 <- csb_canceled(testData, var = "datecancelled", drop = FALSE)

test_that("data are dropped appropriately", {
  expect_equal(nrow(test2), 1515)
  expect_equal(ncol(test2), 17)
})

test_that("Returns Tibble", {
  expect_equal("tbl_df" %in% class(test2), TRUE)
})

# test unquoted and quoted input -----------------------------

test_that("Non-standard Evaluation works", {
  expect_silent(csb_canceled(january_2018, "datecancelled"))
  expect_silent(csb_canceled(january_2018, datecancelled))
})
