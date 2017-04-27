#!/bin/bash
#Autores:  Sergio Herrero Barco 698521
#          Alex Oarga Hategan 718123
#Fecha: Marzo 2017
#Uso: ./practica2_4.sh
#Explicacion: Mueve todos los archivos ejecutables del directorio actual hacia el
#			  subdirectorio $HOME/bin, muestra que ejectubles y cuantos a movido.


if [ -d $HOME/bin ]; #No existe el directorio
then
    echo "$HOME/bin existe."
else
	mkdir $HOME/bin #Se crea
    echo "$HOME/bin directorio creado"
fi

count=0
ls -F | grep -v $0 | grep -v */ | while read file #Con los grep quitamos el propio script
do
	count=$(( count+1 )) #Vamos contando cada fichero
	mv "$file" $HOME/bin
	echo "$count : $file" 
done 
