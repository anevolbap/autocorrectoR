sample_results <- function() {
  data.frame(
    student    = c("Alice", "Bob", "Carol"),
    ejercicio1 = c(TRUE,  FALSE, TRUE),
    ejercicio2 = c(TRUE,  TRUE,  FALSE),
    stringsAsFactors = FALSE
  )
}

test_that("plot_report runs without error and returns results invisibly", {
  pdf(nullfile())
  on.exit(dev.off())
  result <- plot_report(sample_results(), ask = FALSE)
  expect_identical(result, sample_results())
})
