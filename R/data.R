#' Sample grading results
#'
#' A small fake data frame with 8 students and 5 exercises, useful for
#' trying out [grade_report()], [plot_report()], and the export functions
#' without needing real student submissions.
#'
#' @return Data frame with columns `student`, `ejercicio1`, ..., `ejercicio5`.
#' @export
#' @examples
#' results <- example_results()
#' grade_report(results)
#' plot_report(results, ask = FALSE)
example_results <- function() {
  data.frame(
    student    = c("Garcia", "Lopez", "Martinez", "Rodriguez",
                   "Fernandez", "Gonzalez", "Perez", "Sanchez"),
    ejercicio1 = c(TRUE,  TRUE,  TRUE,  FALSE, TRUE,  TRUE,  FALSE, TRUE),
    ejercicio2 = c(TRUE,  TRUE,  FALSE, TRUE,  TRUE,  FALSE, TRUE,  TRUE),
    ejercicio3 = c(TRUE,  FALSE, TRUE,  TRUE,  TRUE,  TRUE,  FALSE, FALSE),
    ejercicio4 = c(FALSE, TRUE,  TRUE,  FALSE, FALSE, TRUE,  TRUE,  TRUE),
    ejercicio5 = c(TRUE,  TRUE,  TRUE,  TRUE,  FALSE, TRUE,  TRUE,  FALSE),
    stringsAsFactors = FALSE
  )
}
