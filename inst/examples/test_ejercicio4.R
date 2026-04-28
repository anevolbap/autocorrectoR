# Ejercicio 4 — Simulación: sorteo sin punto fijo (desarreglo)
#
# El estudiante debe implementar:
#
#   sorteo_valido(n)
#
# Simula un sorteo aleatorio de n elementos y devuelve TRUE si ningún
# elemento queda en su posición original (desarreglo / derangement).
#
# Propiedad matemática: cuando n es grande, la probabilidad de que una
# permutación aleatoria sea un desarreglo converge a 1/e ≈ 0.368.
# Este test verifica esa propiedad de forma empírica.
#
# Nota: al ser un test estocástico, puede fallar esporádicamente.
# Aumentar NREP reduce esa probabilidad a costa de mayor tiempo de ejecución.


NREP <- 2000   # repeticiones de la simulación
TOL  <- 0.05   # tolerancia alrededor del valor teórico 1/e

# La proporción de sorteos válidos con n=10 debe aproximarse a 1/e
test_ejercicio4_probabilidad <- function() {
  proporcion_empirica <- mean(replicate(NREP, sorteo_valido(10)))
  abs(proporcion_empirica - exp(-1)) < TOL
}

# El resultado debe ser lógico (TRUE o FALSE), no numérico
test_ejercicio4_tipo_logico <- function() {
  is.logical(sorteo_valido(10))
}

# Con n=1 nunca hay un desarreglo posible: debe devolver FALSE siempre
test_ejercicio4_n1_imposible <- function() {
  todos <- replicate(100, sorteo_valido(1))
  all(todos == FALSE)
}
