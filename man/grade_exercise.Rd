\name{grade_exercise}
\alias{grade_exercise}
\title{Grade a single exercise file against its tests}
\usage{
grade_exercise(file, test_dir, timeout = Inf)
}
\arguments{
\item{file}{Path to the student's R file (e.g. \code{"ejercicio1.R"}).}

\item{test_dir}{Directory that contains the test files.}

\item{timeout}{Maximum seconds allowed per test function. Tests that exceed
this limit are recorded as \code{FALSE}. Default \code{Inf} (no limit).}
}
\value{
Named logical vector with one element per test function.
Returns \code{c(source_error = FALSE)} if the student file cannot be
sourced. Returns \code{logical(0)} with a warning if no matching test file
is found.
}
\description{
Sources the student's file and the matching test file into an isolated
environment, then runs every function whose name matches
\code{test_<stem>_*} and returns the results as a named logical vector.
}
\examples{
\dontrun{
grade_exercise("submissions/garcia/ejercicio1.R", test_dir = "tests/")
}
}
