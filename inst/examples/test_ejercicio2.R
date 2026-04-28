test_ejercicio2_hay = function(){
    expected_value = TRUE
    actual_value = buscar_una_palabra("hola", c("hola", "chau"))
    ret = expected_value == actual_value
    return(ret)
}

test_ejercicio2_nohay = function(){
    expected_value = FALSE
    actual_value = buscar_una_palabra("hola", c("holis", "chau"))
    ret = expected_value == actual_value
    return(ret)
}

test_ejercicio2_hayvarias = function(){
    expected_value = TRUE
    actual_value = buscar_una_palabra("hola", c("hola", "hola"))
    ret = expected_value == actual_value
    return(ret)
}
