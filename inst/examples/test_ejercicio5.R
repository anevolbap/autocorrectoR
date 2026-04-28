test_ejercicio5_df = function(){
    df_in = data.frame(a = 1:10, b=1:10/10)
    df_out = data.frame(a = 1:10, b=c(rep("bajo", 5), rep("alto", 5)))

    expected_value = df_out
    actual_value = transformar_columna(df_in, "b", 0.5)
    ret = all(expected_value == actual_value)
    return(ret)
}
