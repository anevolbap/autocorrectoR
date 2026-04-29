\name{grade_submissions}
\alias{grade_submissions}
\title{Grade all student submissions in a directory or zip archive}
\usage{
grade_submissions(submissions_path, test_dir, timeout = Inf)
}
\arguments{
\item{submissions_path}{Path to a directory or \code{.zip} archive of
submissions.}

\item{test_dir}{Directory that contains the test files.}

\item{timeout}{Maximum seconds allowed per test function, passed to
\code{\link{grade_exercise}}. Default \code{Inf} (no limit).}
}
\value{
Data frame with one row per student (column \code{student}) and one
logical column per exercise (\code{TRUE} = all tests passed).
}
\description{
Expects one sub-folder per student inside \code{submissions_path}. Each
sub-folder may contain one or more R files whose names contain
\code{"ejercicio"}. Each file is graded with \code{\link{grade_exercise}}
and collapsed to a single pass/fail value (all tests passed).

If \code{submissions_path} ends in \code{.zip} it is extracted first into
a directory with the same base name.
}
\examples{
\dontrun{
results <- grade_submissions("submissions/", test_dir = "tests/")
results <- grade_submissions("submissions.zip", test_dir = "tests/",
                             timeout = 10)
}
}
