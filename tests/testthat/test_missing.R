context("test csb_missing")

# load test data --------------------------------
test_data <- read.csv(system.file("extdata", "testdata.csv", package = "stlcsb"), stringsAsFactors = F)

# test errors -----------------------------------
test_data[4,15] <- NA # Implements an NA for checking of incomplete spatial data

test_that("Missing input errors triggered", {
  expect_error(csb_missing(), "Please provide an argument for .data")
  expect_error(csb_missing(test_data), "Please provide an argument for varX")
  expect_error(csb_missing(test_data, SRX), "Please provide an argument for varY")
  expect_error(csb_missing(test_data, SRX, SRY), "Please supply an argument for newVar OR filter")
})

# test warnings ---------------------------------

test_that("Warnings function properly", {
  expect_warning(csb_missing(test_data, SRX, SRY, newVar = missing, filter = T), "A logical is not appended if filter is TRUE")
})

# test logical appending ------------------------
Loutput <- unlist(csb_missing(test_data, SRX, SRY, newVar = missing)["missing"])
names(Loutput) <- NULL
expected <- c(F,F,F,T,F,F,F)

test_that("Logical appending works", {
  expect_equal(Loutput, expected)
})

# test filtering --------------------------------
Foutput <- unlist(csb_missing(test_data, SRX, SRY, filter = T)[1])

test_that("Filtering works", {
  expect_length(Foutput, 6)
})
