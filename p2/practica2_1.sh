#!/bin/bash
#Autores:  Sergio Herrero Barco 698521
#          Alex Oarga Hategan 718123
#Fecha: Marzo 2017
#Uso: ./practica2_1.sh
#Explicacion: Indica si el nombre del fichero dado es legible, modificable y
#	      ejecutable.
 
echo -n "Nombre del fichero:"
read NOMBRE
RUTA=$(find $HOME -name $NOMBRE) #Se busca la ruta del archivo
if [ -z "$RUTA" ] #Si la ruta es vacia (archivo no encontrado)
then
	echo "Fichero $NOMBRE no encontrado"
	exit 1 #Se termina con un error
fi
if [ -r $RUTA ]
then
	echo "El fichero es legible"
else
	echo "El fichero no es legible"
fi
if [ -w $RUTA ]
then
	echo "El fichero es modificable"
else
	echo "El fichero no es modificable"
fi
if [ -x $RUTA ]
then
	echo "El fichero es ejecutable"
else
	echo "El fichero no es ejecutable"
fi
