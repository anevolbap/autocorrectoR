# Ejercicio 2 — Búsqueda de una palabra en un vector
#
# El estudiante debe implementar:
#
#   buscar_una_palabra(palabra, vector)
#
# Devuelve TRUE si `palabra` aparece al menos una vez en `vector`,
# FALSE en caso contrario. La comparación es exacta (no parcial).
#
# Tests incluidos:
#   - La palabra está presente (una sola vez)
#   - La palabra no está presente
#   - La palabra aparece más de una vez (debe seguir devolviendo TRUE)
#   - La palabra es similar pero no idéntica (no debe confundirse)


# Caso básico: la palabra está en el vector
test_ejercicio2_presente <- function() {
  buscar_una_palabra("hola", c("hola", "chau")) == TRUE
}

# La palabra no figura en ninguna posición
test_ejercicio2_ausente <- function() {
  buscar_una_palabra("hola", c("holis", "chau")) == FALSE
}

# Duplicados: si la palabra aparece más de una vez sigue siendo TRUE
test_ejercicio2_duplicada <- function() {
  buscar_una_palabra("hola", c("hola", "hola")) == TRUE
}

# "holis" no es "hola": la búsqueda debe ser exacta, no por subcadena
test_ejercicio2_exacta <- function() {
  buscar_una_palabra("hola", c("holis", "holaaa")) == FALSE
}
