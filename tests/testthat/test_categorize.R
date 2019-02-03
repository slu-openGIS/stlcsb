context("test csb_categorize")

# load test data --------------------------------

data(january_2018, package = "stlcsb")

# test errors -----------------------------------

test_that("Missing input errors triggered", {
  expect_error(csb_categorize(),
               "Please provide an argument for .data.")
  expect_error(csb_categorize(january_2018),
               "Please provide the name of the variable containing the problem codes for 'var'.")
  expect_error(csb_categorize(january_2018, newVar = cat),
               "Please provide the name of the variable containing the problem codes for 'var'.")
  expect_error(csb_categorize(january_2018, problemcode),
               "Please provide a new variable name for 'newVar'.")
  expect_error(csb_categorize(january_2018, var = problemcode),
               "Please provide a new variable name for 'newVar'.")
})

# test categorization ---------------------------

test1 <- csb_categorize(january_2018, var = problemcode, newVar = cat) # tests unquoted input
results <- data.frame(table(test1$cat))

test_that("Categorizing by Problemcode", {
  expect_equal(results$Freq[1], 48)    # Admin
  expect_equal(results$Freq[2], 64)    # Animal
  expect_equal(results$Freq[3], 42)    # Construction
  expect_equal(results$Freq[4], 92)    # Debris
  expect_equal(results$Freq[5], 124)   # Degrade
  expect_equal(results$Freq[6], 7)     # Disturbance
  expect_equal(results$Freq[7], 3)     # Event
  expect_equal(results$Freq[8], 71)    # Health
  expect_equal(results$Freq[9], 21)    # Landscape
  expect_equal(results$Freq[10], 42)   # Law
  expect_equal(results$Freq[11], 102)  # Maintenance
  expect_equal(results$Freq[12], 79)   # Nature
  expect_equal(results$Freq[13], 97)   # Road
  expect_equal(results$Freq[14], 141)  # Sewer
  expect_equal(results$Freq[15], 192)  # Traffic
  expect_equal(results$Freq[16], 429)  # Waste
})

# test returning tibble -------------------------
testData <- data.frame(january_2018)
test2 <- csb_categorize(testData, var = "problemcode", newVar = "cat") # tests quoted input

test_that("Returns Tibble", {
  expect_equal("tbl_df" %in% class(test2), TRUE)
})

# test unquoted and quoted input -----------------------------

test_that("Non-standard Evaluation works", {
  expect_silent(csb_categorize(january_2018, "problemcode", "category"))
  expect_silent(csb_categorize(january_2018, problemcode, category))
})

