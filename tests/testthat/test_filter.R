context("test csb_filter")

# load test data --------------------------------
data(january_2018, package = "stlcsb")

# test errors -----------------------------------

test_that("Missing input errors triggered", {
  expect_error(csb_filter(), "Please provide an argument for .data")
  expect_error(csb_filter(january_2018), "Please provide the name of the variable containing the problem codes for 'var'.")
  expect_error(csb_filter(january_2018, problemcode), "Please specify the categories you would like to filter for as an argument to 'category'")
  expect_error(csb_filter(january_2018, problemcode, category = "non-real category"), "Category contains an invalid argument, please see `?csb_filter` for help", fixed = TRUE)
})

# test filtering ----------------------------------
output <- unlist(csb_filter(january_2018, "problemcode", category = cat_waste)[1])

test_that("Filtering works properly", {
  expect_length(output, 429)
})

# test returning tibble -------------------------
testData <- data.frame(january_2018)
test2 <- csb_filter(testData, problemcode, category = cat_law)

test_that("Returns Tibble", {
  expect_equal("tbl_df" %in% class(test2), TRUE)
})

# test unquoted and quoted input -----------------------------

test_that("Non-standard Evaluation works", {
  expect_silent(csb_filter(january_2018, "problemcode", category = cat_law))
  expect_silent(csb_filter(january_2018, problemcode, category = cat_law ))
})
