context("test csb_cancelled")

# load test data --------------------------------

data(january_2018, package = "stlcsb")

# test errors -----------------------------------

test_that("Missing input errors triggered", {
  expect_error(csb_cancelled(),
               "Please provide an argument for .data")
  expect_error(csb_cancelled(var = "DATECANCELLED"),
               "Please provide an argument for .data")
  expect_error(csb_cancelled(test),
               "Please provide the name of the variable containing the cancellation timestamps.")
})

# test results ------------------------------------------------

test1 <- csb_cancelled(january_2018, var = DATECANCELLED) # tests unquoted input

test_that("data are dropped appropriately", {
  expect_equal(nrow(test1), 1647)
  expect_equal(ncol(test1), 18)
})

test2 <- csb_cancelled(january_2018, var = "DATECANCELLED", drop = FALSE) # tests quoted input

test_that("data are dropped appropriately", {
  expect_equal(nrow(test2), 1647)
  expect_equal(ncol(test2), 19)
})
