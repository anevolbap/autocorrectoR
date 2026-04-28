#' Export grading results to a CSV file
#'
#' @param results Data frame returned by [grade_submissions()].
#' @param path Output file path (e.g. `"grades.csv"`).
#' @return `results`, invisibly.
#' @export
export_to_csv <- function(results, path) {
  utils::write.csv(results, path, row.names = FALSE)
  invisible(results)
}

#' Export grading results to a Google Sheet
#'
#' Writes the results data frame to an existing Google Sheet, replacing its
#' contents. Requires the \pkg{googlesheets4} package and prior authentication —
#' call [googlesheets4::gs4_auth()] once per session before using this function.
#'
#' @param results Data frame returned by [grade_submissions()].
#' @param sheet_url URL of the target Google Sheet.
#' @param sheet Name or index of the worksheet tab (default: first sheet).
#' @return `results`, invisibly.
#' @export
export_to_sheets <- function(results, sheet_url, sheet = 1) {
  if (!requireNamespace("googlesheets4", quietly = TRUE)) {
    stop(
      "Package 'googlesheets4' is required. ",
      "Install with: install.packages('googlesheets4')"
    )
  }
  googlesheets4::sheet_write(results, ss = sheet_url, sheet = sheet)
  invisible(results)
}
