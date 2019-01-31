context("test csb_missingXY")

# load test data --------------------------------
test_data <- read.csv(system.file("extdata", "testdata.csv", package = "stlcsb"), stringsAsFactors = F)

# test errors -----------------------------------
test_data[4,15] <- NA # Implements an NA for checking of incomplete spatial data

test_that("Missing input errors triggered", {
  expect_error(csb_missingXY(), "Please provide an argument for .data")
  expect_error(csb_missingXY(test_data), "Please provide an argument for varY with the variable name for the column with x coordinate data.")
  expect_error(csb_missingXY(test_data, SRX), "Please provide an argument for varY with the variable name for the column with y coordinate data.")
})

# test logical appending ------------------------
Loutput <- unlist(csb_missingXY(test_data, SRX, SRY, newVar = missing)["missing"])
names(Loutput) <- NULL
expected <- c(F,F,F,T,F,F,F)

test_that("Logical appending works", {
  expect_equal(Loutput, expected)
})

# check character input --------------------------
test_that("Character input works", {
  expect_length(csb_missingXY(test_data, "SRX", "SRY", newVar = missing), 20)
})
