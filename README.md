# autocorrectoR

[English version](README.en.md)

Paquete de R para corregir automáticamente ejercicios de programación. Cada
estudiante entrega un archivo `.R` por ejercicio y el docente provee los archivos
de tests. El paquete los carga en un entorno aislado, ejecuta los tests y
devuelve un data frame con los resultados.

## Instalación

```r
# install.packages("remotes")
remotes::install_github("tu-usuario-github/autocorrectoR")
```

## Ejemplo de principio a fin

```r
library(autocorrectoR)

# --- 1. Crear carpetas de entregas de ejemplo ---
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

El paquete incluye datos de ejemplo para probar las funciones sin necesidad de
armar entregas reales:

```r
resultados <- example_results()  # 8 estudiantes ficticios, 5 ejercicios
grade_report(resultados)
plot_report(resultados)
```

## Cómo funciona

El corrector usa la siguiente convención de nombres:

```
entregas/
├── garcia_juan/
│   ├── ejercicio1.R   <- archivo del estudiante
│   └── ejercicio2.R
└── lopez_maria/
    ├── ejercicio1.R
    └── ejercicio2.R

tests/
├── test_ejercicio1.R  <- archivo de tests del docente (el nombre tiene que coincidir)
└── test_ejercicio2.R
```

Cada archivo de tests tiene funciones con el formato `test_<ejercicio>_<caso>`
que devuelven `TRUE` o `FALSE`:

```r
# tests/test_ejercicio1.R
test_ejercicio1_raices <- function() {
  all(ceros_cuadratica(1, 0, -1) == c(-1, 1))
}

test_ejercicio1_tipo <- function() {
  is.numeric(ceros_cuadratica(1, 0, -1))
}
```

El código del estudiante y los tests se cargan en un entorno nuevo y aislado
para cada ejercicio, así las entregas no se interfieren entre sí.

## Uso

```r
library(autocorrectoR)

# Corregir un lote completo (carpeta o .zip)
resultados <- grade_submissions("entregas/", test_dir = "tests/")

# Corregir un archivo individual (útil mientras escribís los tests)
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

## Gráficos

`plot_report()` genera tres gráficos en secuencia: puntajes de los estudiantes
ordenados, tasa de aprobación por ejercicio y un mapa de calor de resultados.

```r
# Interactivo, pausa entre gráficos
plot_report(resultados)

# Guardar los tres gráficos en un PDF
pdf("informe.pdf", width = 8, height = 5)
plot_report(resultados, ask = FALSE)
dev.off()
```

![Vista previa de los gráficos](man/figures/plots-preview.png)

## Tiempo límite por test

Para evitar que bucles infinitos en el código de los estudiantes bloqueen el
corrector, podés definir un límite de tiempo en segundos:

```r
resultados <- grade_submissions("entregas/", test_dir = "tests/", timeout = 10)
```

Los tests que superen el límite se registran como `FALSE`.

## Archivos de tests de ejemplo

El paquete incluye ejemplos para cinco tipos de ejercicio: raíces de ecuación
cuadrática, búsqueda de palabras, ordenamiento, simulación y transformación de
data frames.

```r
system.file("examples", package = "autocorrectoR")
```

## Alternativas

Otros paquetes de R que resuelven problemas similares, cada uno con un alcance
distinto:

- **[gradethis](https://pkgs.rstudio.com/gradethis/)**: verifica código dentro
  de tutoriales interactivos de [learnr](https://rstudio.github.io/learnr/).
  Ideal para práctica guiada, pero requiere un servidor Shiny.
- **[exams](https://www.r-exams.org/)**: genera preguntas de examen
  aleatorizadas y exporta a Moodle, Canvas, PDF y otros formatos. Muy poderoso
  para cursos grandes que se repiten año a año.
- **[RTutor](https://github.com/skranz/RTutor)**: crea guías de problemas
  interactivas con corrección automática y seguimiento del progreso.

autocorrectoR es la opción más liviana: sin servidor, sin infraestructura,
entregas en archivos `.R` comunes y sin dependencias obligatorias.

## Contribuciones

El feedback es bienvenido. Abrí un issue en GitHub.

## Nombres de las carpetas

Se espera que las carpetas de cada estudiante empiecen con el apellido,
opcionalmente seguido de otros campos separados por guiones bajos
(por ejemplo `garcia_juan_12345`). El corrector extrae el primer segmento como
nombre para mostrar.

Las entregas también se pueden entregar como un único archivo `.zip`; el paquete
lo descomprime automáticamente antes de corregir.
