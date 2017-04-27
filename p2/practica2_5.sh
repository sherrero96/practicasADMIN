#!/bin/bash
#Autor: Sergio Herrero Barco 698521
#	Alex Oarga Hategan 718123
#Uso: ./practica2_5.sh [ruta de directorio]
#Explicacion: Muestra cuantos archivos y cuantos directorios hay dentro
#	      del directorio dado por parametro.

echo -n "Ruta del directorio:"
read RUTA
DIRECTORIOS=$(ls -F "$RUTA"|egrep *"/"$) #Solo nombres que acaben en /
OLDIFS=$IFS
IFS=$'/' #Se cambia IFS para poder contar cuantos directorios hay
if [ -z "$DIRECTORIOS" ] #Si no hay directorios
then
	NUMDIRECTORIOS=$(( 0 )) #Numero de Directorios = 0
else
	NUMDIRECTORIOS=$(echo $DIRECTORIOS|wc -l) #Contamos directorios
fi
echo "Hay $NUMDIRECTORIOS directorios:"
echo $DIRECTORIOS
echo " " #Se deja una linea para que se distinga mejor
FICHEROS=$(ls -F "$RUTA"|egrep [^//]$) #Solo nombres que no acaben en /
IFS=$'/' #Se vuelve a cambiar el IFS para contar cuantos ficheros hay
NUMFICHEROS=$(echo $FICHEROS|wc -l)
echo "Hay $NUMFICHEROS ficheros:"
echo $FICHEROS
IFS=$OLDIFS #Se restaura el IFS que ya estaba
