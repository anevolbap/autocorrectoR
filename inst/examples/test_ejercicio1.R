test_ejercicio1_doble = function(){
    expected_value = c(-1, 1)
    actual_value = ceros_cuadratica(1, 0, -1)
    ret = all(expected_value == actual_value)
    return(ret)
}

test_ejercicio1_simple = function(){
    expected_value = 0
    actual_value = unique(ceros_cuadratica(1, 0, 0))
    ret = expected_value == actual_value
    return(ret)
}

test_ejercicio1_tipo = function(){
    expected_value = "numeric" 
    actual_value = class(ceros_cuadratica(0, 1, -1))
    ret = expected_value == actual_value
    return(ret)
}

## test_ejercicio1_lineal = function(){
##     expected_value = 1 
##     actual_value = unique(ceros_cuadratica(0, 1, -1))
##     ret = expected_value == actual_value
##     return(ret)
## }
