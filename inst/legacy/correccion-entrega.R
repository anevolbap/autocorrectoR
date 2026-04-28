## DEPRECATED: replaced by R/grade.R and R/export.R
## Kept for reference. Do not use.

library(stringr)
library(dplyr)
library(tidyverse)

EXTENSION_ZIP = ".zip"

corregir_ejercicio <- function(archivo, test_folder, all=FALSE){
    ## Corre funciones de test contra un archivo (ejercicio)
    ## archivo: nombre del archivo
    ## test_folde: carpeta con los tests
    ## env: enviroment dnde se cargan los tests y el archivo

    env = new.env()
    tests_archivo = paste("test", archivo, sep="_")
    tests_files = list.files(test_folder,
                             pattern=paste0("^", tests_archivo, "$"),
                             full.names = TRUE)
    tryCatch(
        {source(archivo, local=env)
        message(paste("Corrigiendo el archivo", archivo))
        },
        warning=function(cond){
            message("Error al abrir el archivo:", archivo)
            message(cond)
        })
    message(paste("Cargando los tests \n -", tests_files))
    source(tests_files, local=env)
    archivo_sin_ext = strsplit(archivo, "\\.")[[1]][1]
    tests_fun = ls(envir= env,
                   pattern = paste("test",
                                   archivo_sin_ext,
                                   sep="_"))
    ret = sapply(tests_fun, function(f) get(f, envir=env)())
    if (all) {
        ret = all(ret)
    }
    rm("env")
    return(ret)
}

procesar_entregas <- function(path_entregas){
    ## Si path_entregas es un zip lo descomprime en una carpeta con el mismo
    ## nombre. Si es una carpeta directamente la explora.
    ##
    ## path_entregas: nombre del archivo .zip o carpeta donde estan las entregas.
    if (str_sub(path_entregas, -4,-1) == EXTENSION_ZIP){
        unzip(zipfile= path_entregas,
              list=FALSE,
              exdir=str_sub(path_entregas, -4,-1))
    }
    estudiantes = list.files(path_entregas)
    planilla = list()
    for (estudiante in estudiantes) {
        nombre = str_to_title(strsplit(estudiante, split = "_")[[1]][1])
        message(paste("Corrigiendo a", nombre))
        ejercicios = list.files(paste(".", path_entregas, estudiante, sep = "/"),
                                pattern = "ejercicio")
        resultados = unlist(sapply(ejercicios,
                                   corregir_ejercicio,
                                   test_folder = "tests_entrega",
                                   all = TRUE))
        planilla = append(planilla, list(c(nombre=nombre, resultados)))
    }

    planilla = planilla %>%
        bind_rows() %>%
        column_to_rownames(var="nombre")

    return(planilla)
}
