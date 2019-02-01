context("test csb_vacant")

# load test data --------------------------------

data(january_2018, package = "stlcsb")

# test errors -----------------------------------

test_that("Missing input errors triggered", {
  expect_error(csb_categorize(),
               "Please provide an argument for .data.")
  expect_error(csb_vacant(test_data),
               "Please provide the name of the variable containing the problem codes for 'var'.")
  expect_error(csb_vacant(test_data, newVar = vacant),
               "Please provide the name of the variable containing the problem codes for 'var'.")
  expect_error(csb_vacant(test_data, PROBLEMCODE),
               "Please provide a new variable name for 'newVar'.")
  expect_error(csb_vacant(test_data, var = PROBLEMCODE),
               "Please provide a new variable name for 'newVar'.")
})

# test output ------------------------

test <- csb_vacant(january_2018, var = PROBLEMCODE, newVar = vacant) # tests unquoted input

test_that("Logical appending works", {
  expect_equal(table(test$vacant)[[1]], 1590) # not vacant / FALSE
  expect_equal(table(test$vacant)[[2]], 98)   # vacant / TRUE
})

testData <- data.frame(january_2018)
test2 <- csb_vacant(testData, var = "PROBLEMCODE", newVar = "cat") # tests quoted input

test_that("Returns Tibble", {
  expect_equal("tbl_df" %in% class(test2), TRUE)
})
