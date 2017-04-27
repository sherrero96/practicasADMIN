#!/bin/bash
#Autores:  Sergio Herrero Barco 698521
#          Alex Oarga Hategan 718123
#Fecha: Marzo 2017
#Uso: ./practica2_3.sh [nombre de fichero]
#Explicacion: Verifica si existe el nombre dado, si es un archivo comun
#	      y lo convierte en archivo ejecutable para el usuario y el
#	      grupo.

if [ $# -ne 1 ]
then
	echo "Numero de comandos incorrecto"
	exit 1
fi
RUTA=$(find "$HOME" -name "$1") #Se busca la ruta del fichero
echo "$RUTA"
if [ -z "$RUTA" ] #Si no existe ninguna ruta con ese fichero
then
	echo "Fichero $NOMBRE no encontrado"
	exit 1 #Se termina con un error
fi
if [ -f "$RUTA" ] #Si el fichero encontrado es un archivo comun
then
	chmod u+x "$RUTA" #Añadido permiso ejecucion al usuario
	chmod g+x "$RUTA" #Añadido permiso ejecucion al grupo
	echo $(ls -l|egrep "$1") #Se muestra los modos actualizados
fi
