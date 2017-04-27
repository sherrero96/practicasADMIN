#!/bin/bash
#Autores:  Sergio Herrero Barco 698521
#          Alex Oarga Hategan 718123
#Fecha: Marzo 2017
#Uso: ./practica2_4.sh
#Explicacion: Pide una tecla al usuario y muestra si es letra, numero o caracter especial


echo -n "Pulse una tecla: " 
read -N 1 var
echo -e "\nTecla: $var"

case $var in
    [a-z]|[A-Z])
        echo "Es letra" ;;
    [0-9])
        echo "Es numero";;
    *)
        echo "Es caracter especial";;
esac




