# autocorrectoR

An R package for automatically grading student coding exercises. Each student
submits one R file per exercise; the professor provides matching test files. The
package sources both into an isolated environment, runs the tests, and returns a
tidy data frame of results.

## Installation

```r
# install.packages("pak")
pak::pak("your-github-username/autocorrectoR")
```

## How it works

The grader follows a naming convention:

```
submissions/
├── garcia_juan/
│   ├── ejercicio1.R   ← student file
│   └── ejercicio2.R
└── lopez_maria/
    ├── ejercicio1.R
    └── ejercicio2.R

tests/
├── test_ejercicio1.R  ← professor test file (name must match)
└── test_ejercicio2.R
```

Each test file contains functions named `test_<exercise>_<case>` that return
`TRUE` or `FALSE`:

```r
# tests/test_ejercicio1.R
test_ejercicio1_positivos <- function() {
  ceros_cuadratica(1, 0, -1) == c(-1, 1)
}

test_ejercicio1_tipo <- function() {
  is.numeric(ceros_cuadratica(1, 0, -1))
}
```

Student code and test code are sourced into a fresh, isolated environment for
each exercise, so submissions cannot interfere with each other.

## Usage

```r
library(autocorrectoR)

# Grade a full batch (directory or .zip)
results <- grade_submissions("submissions/", test_dir = "tests/")
#   student    ejercicio1 ejercicio2
# 1 Garcia          TRUE       TRUE
# 2 Lopez          FALSE       TRUE

# Grade a single file during development
grade_exercise("submissions/garcia_juan/ejercicio1.R", test_dir = "tests/")
# test_ejercicio1_positivos test_ejercicio1_tipo
#                      TRUE                 TRUE

# Console summary
grade_report(results)
# === Grade Report ===
#
# Pass rate by exercise:
#   ejercicio1                50%
#   ejercicio2               100%
#
# Overall mean score: 75%
#
# Score by student (descending):
#   Garcia               #################### 100%
#   Lopez                ##########            50%

# Export
export_to_csv(results, "grades.csv")
export_to_html(results, "report.html")   # colour-coded table

# Export to Google Sheets (requires googlesheets4)
googlesheets4::gs4_auth()
export_to_sheets(results, "https://docs.google.com/spreadsheets/d/...")
```

## Timeout

To prevent infinite loops in student code from hanging the grader, set a
per-test time limit in seconds:

```r
results <- grade_submissions("submissions/", test_dir = "tests/", timeout = 10)
```

Tests that exceed the limit are recorded as `FALSE`.

## Example test files

Fully worked examples for five different exercise types (quadratic roots, string
search, sorting, simulation, data frame transformation) are installed with the
package:

```r
system.file("examples", package = "autocorrectoR")
```

## Submission folder naming

Student folders are expected to start with the student's surname, optionally
followed by underscore-separated fields (e.g. `garcia_juan_12345`). The grader
extracts the first segment as the display name.

Submissions can also be provided as a single `.zip` archive — the package
extracts it automatically before grading.
