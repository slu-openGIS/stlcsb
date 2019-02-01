context("test csb_categorize")

# load test data --------------------------------

data(january_2018, package = "stlcsb")

# test errors -----------------------------------

test_that("Missing input errors triggered", {
  expect_error(csb_categorize(),
               "Please provide an argument for .data.")
  expect_error(csb_categorize(test_data),
               "Please provide the name of the variable containing the problem codes for 'var'.")
  expect_error(csb_categorize(test_data, newVar = cat),
               "Please provide the name of the variable containing the problem codes for 'var'.")
  expect_error(csb_categorize(test_data, PROBLEMCODE),
               "Please provide a new variable name for 'newVar'.")
  expect_error(csb_categorize(test_data, var = PROBLEMCODE),
               "Please provide a new variable name for 'newVar'.")
})

# test categorization ---------------------------

test1 <- csb_categorize(january_2018, var = PROBLEMCODE, newVar = cat) # tests unquoted input
results <- data.frame(table(test1$cat))

test_that("Categorizing by Problemcode", {
  expect_equal(results$Freq[1], 49)    # Admin
  expect_equal(results$Freq[2], 66)    # Animal
  expect_equal(results$Freq[3], 49)    # Construction
  expect_equal(results$Freq[4], 92)    # Debris
  expect_equal(results$Freq[5], 124)   # Degrade
  expect_equal(results$Freq[6], 9)     # Disturbance
  expect_equal(results$Freq[7], 3)     # Event
  expect_equal(results$Freq[8], 71)    # Health
  expect_equal(results$Freq[9], 21)    # Landscape
  expect_equal(results$Freq[10], 42)   # Law
  expect_equal(results$Freq[11], 210)  # Maintenance
  expect_equal(results$Freq[12], 79)   # Nature
  expect_equal(results$Freq[13], 97)   # Road
  expect_equal(results$Freq[14], 155)  # Sewer
  expect_equal(results$Freq[15], 192)  # Traffic
  expect_equal(results$Freq[16], 429)  # Waste
})

testData <- data.frame(january_2018)
test2 <- csb_categorize(testData, var = "PROBLEMCODE", newVar = "cat") # tests quoted input

test_that("Returns Tibble", {
  expect_equal("tbl_df" %in% class(test2), TRUE)
})
