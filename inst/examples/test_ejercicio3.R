test_ejercicio3_naturales = function(){
    expected_value = 1:10
    actual_value = ordenar(10:1)
    ret = all(expected_value == actual_value)
    return(ret)
}


test_ejercicio3_enteros = function(){
    expected_value = c(-2, -1, 0, 4, 10)
    actual_value = ordenar(c(10 ,4, -1, 0, -2))
    ret = all(expected_value == actual_value)
    return(ret)
}

test_ejercicio3_float = function(){
    expected_value = c(-2, -1.9, 0.75, 4, 10)
    actual_value = ordenar(c(10 ,4, -1.9, 0.75, -2))
    ret = all(expected_value == actual_value)
    return(ret)
}
