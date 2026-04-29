\name{grade_report}
\alias{grade_report}
\alias{print.grade_report}
\title{Summarise grading results}
\usage{
grade_report(results)

\method{print}{grade_report}(x, ...)
}
\arguments{
\item{results}{Data frame returned by \code{\link{grade_submissions}}.}

\item{x}{A \code{grade_report} object.}

\item{...}{Ignored.}
}
\value{
A \code{grade_report} object (a list) with components:
\describe{
  \item{\code{pass_rate_by_exercise}}{Named numeric vector (0-1).}
  \item{\code{score_by_student}}{Named numeric vector (0-1).}
  \item{\code{overall_mean}}{Scalar numeric (0-1).}
}
}
\description{
Computes pass rate per exercise and score per student. The returned object
has a \code{print} method that renders a readable console summary.
}
\examples{
r <- grade_report(example_results())
print(r)
}
