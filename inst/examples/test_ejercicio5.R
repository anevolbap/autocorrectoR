# Ejercicio 5 — Transformación de una columna numérica en categórica
#
# El estudiante debe implementar:
#
#   transformar_columna(df, col, umbral)
#
# Reemplaza los valores de la columna `col` del data frame `df`:
#   - valores <= umbral  →  "bajo"
#   - valores >  umbral  →  "alto"
# Devuelve el data frame modificado. Las demás columnas no deben cambiar.
#
# Tests incluidos:
#   - Caso básico con umbral en el medio del rango
#   - Las columnas no afectadas permanecen intactas
#   - Valor exactamente igual al umbral cae en "bajo"
#   - Todos los valores por encima del umbral → solo "alto"


# Caso típico: 5 valores bajo el umbral, 5 sobre él
test_ejercicio5_basico <- function() {
  df_in  <- data.frame(a = 1:10, b = (1:10) / 10)
  df_out <- data.frame(a = 1:10, b = c(rep("bajo", 5), rep("alto", 5)))
  resultado <- transformar_columna(df_in, "b", 0.5)
  all(resultado == df_out)
}

# La columna `a` no debe verse afectada por la transformación
test_ejercicio5_otras_columnas_intactas <- function() {
  df_in <- data.frame(a = 1:5, b = c(0.1, 0.4, 0.6, 0.8, 1.0))
  resultado <- transformar_columna(df_in, "b", 0.5)
  all(resultado$a == 1:5)
}

# El valor exactamente igual al umbral debe clasificarse como "bajo"
test_ejercicio5_valor_en_umbral <- function() {
  df_in <- data.frame(x = 1, v = 0.5)
  resultado <- transformar_columna(df_in, "v", 0.5)
  resultado$v == "bajo"
}

# Si todos los valores superan el umbral, la columna queda sólo con "alto"
test_ejercicio5_todos_alto <- function() {
  df_in <- data.frame(x = 1:3, v = c(0.8, 0.9, 1.0))
  resultado <- transformar_columna(df_in, "v", 0.5)
  all(resultado$v == "alto")
}
