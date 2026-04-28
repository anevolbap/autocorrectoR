# Ejercicio 3 — Ordenamiento de un vector numérico
#
# El estudiante debe implementar:
#
#   ordenar(v)
#
# Devuelve el vector `v` ordenado de menor a mayor.
# No se permite usar sort() ni order() directamente.
#
# Tests incluidos:
#   - Naturales en orden inverso
#   - Enteros con negativos y cero
#   - Números decimales
#   - Vector con un solo elemento (caso borde)
#   - Vector ya ordenado (no debe modificarse)


# Caso típico: naturales al revés
test_ejercicio3_invertido <- function() {
  all(ordenar(10:1) == 1:10)
}

# Enteros con negativos y cero mezclados
test_ejercicio3_negativos <- function() {
  all(ordenar(c(10, 4, -1, 0, -2)) == c(-2, -1, 0, 4, 10))
}

# Decimales: el orden debe respetarse con punto flotante
test_ejercicio3_decimales <- function() {
  all(ordenar(c(10, 4, -1.9, 0.75, -2)) == c(-2, -1.9, 0.75, 4, 10))
}

# Un solo elemento: debe devolverse sin error
test_ejercicio3_un_elemento <- function() {
  ordenar(42) == 42
}

# Vector ya ordenado: no debe modificarse
test_ejercicio3_ya_ordenado <- function() {
  v <- c(1, 2, 3, 4, 5)
  all(ordenar(v) == v)
}
