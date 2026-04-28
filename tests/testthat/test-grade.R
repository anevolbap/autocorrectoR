test_dir <- test_path("fixtures/tests")

test_that("grade_exercise passes correct implementation", {
  file <- test_path("fixtures/student_ok/ejercicio1.R")
  result <- grade_exercise(file, test_dir)
  expect_true(all(result))
  expect_length(result, 2)
})

test_that("grade_exercise fails wrong implementation", {
  file <- test_path("fixtures/student_fail/ejercicio1.R")
  result <- grade_exercise(file, test_dir)
  expect_false(all(result))
})

test_that("grade_exercise returns source_error for unparseble file", {
  file <- test_path("fixtures/student_broken/ejercicio1.R")
  expect_warning(result <- grade_exercise(file, test_dir))
  expect_false(result[["source_error"]])
})

test_that("grade_exercise warns and returns empty when no test file found", {
  file <- test_path("fixtures/student_ok/ejercicio99.R")
  expect_warning(result <- grade_exercise(file, test_dir), "No test file found")
  expect_length(result, 0)
})
