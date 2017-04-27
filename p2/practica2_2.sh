#!/bin/bash
#Autores:  Sergio Herrero Barco 698521
#          Alex Oarga Hategan 718123
#Fecha: Marzo 2017
#Uso: ./practica2_2.sh par 1 par2 "par con espacios" ... panN
#Explicacion: Valida si cada fichero es un archivo comun existente
#			  y lo muestra



for par in $@
do
    if [ -r "$par" ]; then
        less "$par"
    fi
done
