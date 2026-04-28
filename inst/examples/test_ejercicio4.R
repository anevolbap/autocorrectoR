NREP = 1e3
TOL = 0.1

test_ejercicio4_10 = function(){
    expected_value = exp(-1)
    actual_value = mean(replicate(NREP, sorteo_valido(10)))
    ret = all(abs(expected_value - actual_value) < TOL)
    return(ret)
}
