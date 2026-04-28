# autocorrectoR

[English version](README.md)

Paquete de R para corregir automáticamente ejercicios de programación. Cada
estudiante entrega un archivo `.R` por ejercicio; el docente provee archivos de
tests correspondientes. El paquete carga ambos en un entorno aislado, ejecuta
los tests y devuelve un data frame con los resultados.

## Instalación

```r
# install.packages("pak")
pak::pak("tu-usuario-github/autocorrectoR")
```

## Ejemplo mínimo de principio a fin

```r
library(autocorrectoR)

# --- 1. Crear una entrega de ejemplo ---
dir.create("entregas/garcia", recursive = TRUE)
dir.create("entregas/lopez",  recursive = TRUE)
dir.create("tests")

writeLines(
  'ceros_cuadratica <- function(a, b, c) {
     d <- b^2 - 4*a*c
     c((-b - sqrt(d)) / (2*a), (-b + sqrt(d)) / (2*a))
   }',
  "entregas/garcia/ejercicio1.R"
)

writeLines(
  'ceros_cuadratica <- function(a, b, c) c(0, 0)',  # incorrecto
  "entregas/lopez/ejercicio1.R"
)

writeLines(
  'test_ejercicio1_raices <- function() {
     all(ceros_cuadratica(1, 0, -1) == c(-1, 1))
   }
   test_ejercicio1_tipo <- function() {
     is.numeric(ceros_cuadratica(1, 0, -1))
   }',
  "tests/test_ejercicio1.R"
)

# --- 2. Corregir ---
resultados <- grade_submissions("entregas/", test_dir = "tests/")
#   student    ejercicio1
# 1 Garcia          TRUE
# 2 Lopez          FALSE

# --- 3. Resumen y exportación ---
grade_report(resultados)
export_to_html(resultados, "informe.html")
export_to_csv(resultados,  "notas.csv")
```

## Cómo funciona

El corrector sigue una convención de nombres:

```
entregas/
├── garcia_juan/
│   ├── ejercicio1.R   ← archivo del estudiante
│   └── ejercicio2.R
└── lopez_maria/
    ├── ejercicio1.R
    └── ejercicio2.R

tests/
├── test_ejercicio1.R  ← archivo de tests del docente (el nombre debe coincidir)
└── test_ejercicio2.R
```

Cada archivo de tests contiene funciones con el formato `test_<ejercicio>_<caso>`
que devuelven `TRUE` o `FALSE`:

```r
# tests/test_ejercicio1.R
test_ejercicio1_positivos <- function() {
  all(ceros_cuadratica(1, 0, -1) == c(-1, 1))
}

test_ejercicio1_tipo <- function() {
  is.numeric(ceros_cuadratica(1, 0, -1))
}
```

El código del estudiante y los tests se cargan en un entorno nuevo y aislado
para cada ejercicio, por lo que las entregas no pueden interferir entre sí.

## Uso

```r
library(autocorrectoR)

# Corregir un lote completo (carpeta o .zip)
resultados <- grade_submissions("entregas/", test_dir = "tests/")

# Corregir un archivo individual (útil al escribir los tests)
grade_exercise("entregas/garcia_juan/ejercicio1.R", test_dir = "tests/")

# Resumen en consola
grade_report(resultados)
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

# Exportar
export_to_csv(resultados, "notas.csv")
export_to_html(resultados, "informe.html")   # tabla con colores

# Exportar a Google Sheets (requiere googlesheets4)
googlesheets4::gs4_auth()
export_to_sheets(resultados, "https://docs.google.com/spreadsheets/d/...")
```

## Tiempo límite por test

Para evitar que bucles infinitos en el código de los estudiantes bloqueen el
corrector, se puede definir un límite de tiempo en segundos:

```r
resultados <- grade_submissions("entregas/", test_dir = "tests/", timeout = 10)
```

Los tests que superen el límite se registran como `FALSE`.

## Archivos de tests de ejemplo

El paquete incluye ejemplos completos para cinco tipos de ejercicio (raíces de
ecuación cuadrática, búsqueda de palabras, ordenamiento, simulación y
transformación de data frames):

```r
system.file("examples", package = "autocorrectoR")
```

## Convención para los nombres de carpetas

Se espera que las carpetas de cada estudiante comiencen con el apellido,
opcionalmente seguido de otros campos separados por guiones bajos
(p. ej. `garcia_juan_12345`). El corrector extrae el primer segmento como nombre
para mostrar.

Las entregas también pueden proporcionarse como un único archivo `.zip`; el
paquete lo descomprime automáticamente antes de corregir.
