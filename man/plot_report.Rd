\name{plot_report}
\alias{plot_report}
\title{Plot a visual summary of grading results}
\usage{
plot_report(results, ask = interactive())
}
\arguments{
\item{results}{Data frame returned by \code{\link{grade_submissions}}.}

\item{ask}{If \code{TRUE} (default in interactive sessions), pause between
plots. Pass \code{FALSE} when rendering to a file device (PDF, PNG, etc.).}
}
\value{
\code{results}, invisibly.
}
\description{
Produces three base-R plots in sequence:
\enumerate{
  \item Student scores ranked (horizontal bar chart).
  \item Pass rate per exercise (bar chart).
  \item Pass/fail heatmap (students x exercises).
}
}
\examples{
plot_report(example_results(), ask = FALSE)

\dontrun{
# Save to PDF
pdf("report.pdf", width = 8, height = 5)
plot_report(results, ask = FALSE)
dev.off()
}
}
