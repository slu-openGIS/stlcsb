context("test csb_missingXY")

# load test data --------------------------------
data(january_2018, package = "stlcsb")

# test errors -----------------------------------

test_that("Missing input errors triggered", {
  expect_error(csb_missingXY(), "Please provide an argument for .data")
  expect_error(csb_missingXY(january_2018), "Please provide an argument for varX with the variable name for the column with x coordinate data.")
  expect_error(csb_missingXY(january_2018, srx), "Please provide an argument for varY with the variable name for the column with y coordinate data.")
  expect_error(csb_missingXY(january_2018, srx, sry), "Please provide an argument for 'newVar' with a new variable name.")
})

# test logical appending ------------------------
Loutput <- unlist(csb_missingXY(january_2018, srx, sry, newVar = missing)["missing"])
names(Loutput) <- NULL
expected <- data.frame(table(Loutput))


test_that("Logical appending works", {
  expect_equal(expected$Freq[2], 48) # trues
  expect_equal(expected$Freq[1], 1506) # falses
})

# check character input --------------------------
test_that("Character input works", {
  expect_length(csb_missingXY(january_2018, "srx", "sry", newVar = missing), 18)
})

# test returning tibble -------------------------
testData <- data.frame(january_2018)
test2 <- csb_missingXY(testData, srx, sry, newVar = missing)

test_that("Returns Tibble", {
  expect_equal("tbl_df" %in% class(test2), TRUE)
})

# test unquoted and quoted input -----------------------------

test_that("Non-standard Evaluation works", {
  expect_silent(csb_missingXY(january_2018, "srx","sry", newVar = "missing"))
  expect_silent(csb_missingXY(january_2018, srx, sry, newVar = missing))
})
