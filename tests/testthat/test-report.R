sample_results <- function() {
  data.frame(
    student    = c("Alice", "Bob", "Carol"),
    ejercicio1 = c(TRUE,  FALSE, TRUE),
    ejercicio2 = c(TRUE,  TRUE,  FALSE),
    stringsAsFactors = FALSE
  )
}

test_that("grade_report computes correct pass rates", {
  r <- grade_report(sample_results())
  expect_equal(r$pass_rate_by_exercise[["ejercicio1"]], 2 / 3)
  expect_equal(r$pass_rate_by_exercise[["ejercicio2"]], 2 / 3)
})

test_that("grade_report computes correct student scores", {
  r <- grade_report(sample_results())
  expect_equal(r$score_by_student[["Alice"]], 1.0)
  expect_equal(r$score_by_student[["Bob"]],   0.5)
  expect_equal(r$score_by_student[["Carol"]], 0.5)
})

test_that("grade_report overall_mean is correct", {
  r <- grade_report(sample_results())
  expect_equal(r$overall_mean, mean(c(1.0, 0.5, 0.5)))
})

test_that("print.grade_report produces output without error", {
  r <- grade_report(sample_results())
  expect_output(print(r), "Grade Report")
  expect_output(print(r), "Pass rate")
  expect_output(print(r), "Alice")
})
