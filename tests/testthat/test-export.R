sample_results <- function() {
  data.frame(
    student    = c("Alice", "Bob"),
    ejercicio1 = c(TRUE, FALSE),
    ejercicio2 = c(TRUE, TRUE),
    stringsAsFactors = FALSE
  )
}

test_that("export_to_csv writes a readable file", {
  tmp <- withr::local_tempfile(fileext = ".csv")
  results <- sample_results()
  export_to_csv(results, tmp)
  back <- utils::read.csv(tmp, stringsAsFactors = FALSE)
  expect_equal(back$student, c("Alice", "Bob"))
  expect_equal(back$ejercicio1, c(TRUE, FALSE))
})

test_that("export_to_html writes a file with expected content", {
  tmp <- withr::local_tempfile(fileext = ".html")
  results <- sample_results()
  export_to_html(results, tmp)
  html <- paste(readLines(tmp), collapse = "")
  expect_true(grepl("Alice", html))
  expect_true(grepl("class=\"pass\"", html))
  expect_true(grepl("class=\"fail\"", html))
  expect_true(grepl("Pass rate", html))
})
