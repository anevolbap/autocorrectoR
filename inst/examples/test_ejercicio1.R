# Ejercicio 1 — Raíces de una ecuación cuadrática
#
# El estudiante debe implementar:
#
#   ceros_cuadratica(a, b, c)
#
# Devuelve un vector numérico con las raíces reales de ax² + bx + c = 0,
# calculadas con la fórmula cuadrática. Se asume discriminante no negativo.
#
# Tests incluidos:
#   - Caso con dos raíces distintas
#   - Caso con raíz doble (discriminante = 0)
#   - Tipo de retorno correcto
#   - Caso degenerado: a = 0 (ecuación lineal)


# Caso estándar: x² - 1 = 0  →  raíces -1 y 1
test_ejercicio1_dos_raices <- function() {
  esperado <- c(-1, 1)
  all(ceros_cuadratica(1, 0, -1) == esperado)
}

# Raíz doble: x² = 0  →  raíz única 0 (ambas raíces coinciden)
test_ejercicio1_raiz_doble <- function() {
  raices <- ceros_cuadratica(1, 0, 0)
  length(unique(raices)) == 1 && unique(raices) == 0
}

# El resultado debe ser numérico, no character ni integer
test_ejercicio1_tipo_numerico <- function() {
  is.numeric(ceros_cuadratica(1, -3, 2))
}

# Caso degenerado: a = 0 da una ecuación lineal (x - 1 = 0 → x = 1).
# Este caso puede tratarse aparte o ignorarse según el enunciado;
# se incluye como test opcional para verificar robustez.
test_ejercicio1_lineal <- function() {
  raiz <- unique(ceros_cuadratica(0, 1, -1))
  raiz == 1
}
