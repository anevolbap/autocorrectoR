#' Summarise grading results
#'
#' Computes pass rate per exercise and score per student. The returned object
#' has a [print()] method that renders a readable console summary.
#'
#' @param results Data frame returned by [grade_submissions()].
#' @return A `grade_report` object (a list) with components:
#'   \describe{
#'     \item{`pass_rate_by_exercise`}{Named numeric vector (0–1).}
#'     \item{`score_by_student`}{Named numeric vector (0–1).}
#'     \item{`overall_mean`}{Scalar numeric (0–1).}
#'   }
#' @export
grade_report <- function(results) {
  exercise_cols <- setdiff(names(results), "student")

  pass_rate <- colMeans(results[exercise_cols], na.rm = TRUE)
  student_scores <- rowMeans(results[exercise_cols], na.rm = TRUE)
  names(student_scores) <- results$student

  structure(
    list(
      pass_rate_by_exercise = pass_rate,
      score_by_student = student_scores,
      overall_mean = mean(student_scores, na.rm = TRUE)
    ),
    class = "grade_report"
  )
}

#' @export
print.grade_report <- function(x, ...) {
  pct <- function(v) sprintf("%.0f%%", v * 100)

  cat("=== Grade Report ===\n\n")

  cat("Pass rate by exercise:\n")
  for (ex in names(x$pass_rate_by_exercise)) {
    cat(sprintf("  %-25s %s\n", ex, pct(x$pass_rate_by_exercise[[ex]])))
  }

  cat(sprintf("\nOverall mean score: %s\n\n", pct(x$overall_mean)))

  cat("Score by student (descending):\n")
  sorted <- sort(x$score_by_student, decreasing = TRUE)
  bar_width <- 20L
  for (nm in names(sorted)) {
    bar <- strrep("#", round(sorted[[nm]] * bar_width))
    cat(sprintf("  %-20s %-*s %s\n", nm, bar_width, bar, pct(sorted[[nm]])))
  }

  invisible(x)
}
